#!/usr/bin/env node
'use strict';

const crypto = require('node:crypto');
const fs = require('node:fs');
const https = require('node:https');

const SHA256_PATTERN = /^[a-fA-F0-9]{64}$/;
const REPOSITORY_PATTERN = /^[^/\s]+\/[^/\s]+$/;
const BLOB_SHA_PATTERN = /^[a-fA-F0-9]{40}$/;

function usage() {
  return 'Usage: node scripts/github-upload-binary.js --file <path> --repo <owner/repo> [--token <token>] [--expected-sha256 <sha256>]';
}

function parseArguments(argv) {
  const options = {};
  const valueOptions = new Set(['file', 'repo', 'token', 'expected-sha256']);

  for (let index = 0; index < argv.length; index += 1) {
    const argument = argv[index];
    if (!argument.startsWith('--')) {
      throw new Error(`Invalid argument: ${argument}`);
    }

    const name = argument.slice(2);
    if (!valueOptions.has(name) || Object.prototype.hasOwnProperty.call(options, name)) {
      throw new Error(`Invalid argument: ${argument}`);
    }

    const value = argv[index + 1];
    if (!value || value.startsWith('--')) {
      throw new Error(`Missing value for --${name}`);
    }
    options[name] = value;
    index += 1;
  }

  if (!options.file || !options.repo) {
    throw new Error(`Missing required argument. ${usage()}`);
  }
  if (!REPOSITORY_PATTERN.test(options.repo)) {
    throw new Error('--repo must be in owner/repo format');
  }
  if (options['expected-sha256'] && !SHA256_PATTERN.test(options['expected-sha256'])) {
    throw new Error('--expected-sha256 must be exactly 64 hexadecimal characters');
  }

  options.token = options.token || process.env.GITHUB_TOKEN;
  if (!options.token) {
    throw new Error('A GitHub token is required via --token or GITHUB_TOKEN');
  }

  return options;
}

function readAndHash(filePath) {
  let bytes;
  try {
    bytes = fs.readFileSync(filePath);
  } catch (error) {
    throw new Error(`Unable to read input file: ${error.message}`);
  }

  const sha256 = crypto.createHash('sha256').update(bytes).digest('hex');
  return { bytes, sha256 };
}

function uploadBlob(repository, token, bytes) {
  const [owner, repo] = repository.split('/');
  const requestBody = JSON.stringify({
    content: bytes.toString('base64'),
    encoding: 'base64',
  });

  return new Promise((resolve, reject) => {
    const request = https.request({
      hostname: 'api.github.com',
      method: 'POST',
      path: `/repos/${encodeURIComponent(owner)}/${encodeURIComponent(repo)}/git/blobs`,
      headers: {
        Accept: 'application/vnd.github+json',
        Authorization: `Bearer ${token}`,
        'Content-Type': 'application/json',
        'Content-Length': Buffer.byteLength(requestBody),
        'User-Agent': 'drag-x-turbo-binary-blob-bridge',
        'X-GitHub-Api-Version': '2022-11-28',
      },
    }, (response) => {
      const chunks = [];
      response.on('data', (chunk) => chunks.push(chunk));
      response.on('end', () => {
        const responseBody = Buffer.concat(chunks).toString('utf8');
        let parsed;
        try {
          parsed = JSON.parse(responseBody);
        } catch {
          reject(new Error(`GitHub API returned malformed JSON (HTTP ${response.statusCode})`));
          return;
        }

        if (response.statusCode < 200 || response.statusCode >= 300) {
          const detail = typeof parsed.message === 'string' ? `: ${parsed.message}` : '';
          reject(new Error(`GitHub API request failed (HTTP ${response.statusCode})${detail}`));
          return;
        }
        if (!parsed || typeof parsed.sha !== 'string' || !BLOB_SHA_PATTERN.test(parsed.sha)) {
          reject(new Error('GitHub API returned a malformed blob response'));
          return;
        }
        resolve(parsed.sha);
      });
    });

    request.on('error', (error) => reject(new Error(`GitHub API request failed: ${error.message}`)));
    request.end(requestBody);
  });
}

async function main() {
  const options = parseArguments(process.argv.slice(2));
  const { bytes, sha256 } = readAndHash(options.file);

  if (options['expected-sha256'] && sha256.toLowerCase() !== options['expected-sha256'].toLowerCase()) {
    throw new Error(`SHA-256 mismatch: calculated ${sha256}, expected ${options['expected-sha256'].toLowerCase()}`);
  }

  const blobSha = await uploadBlob(options.repo, options.token, bytes);
  process.stdout.write(`${blobSha}\n`);
}

main().catch((error) => {
  process.stderr.write(`Error: ${error.message}\n`);
  process.exitCode = 1;
});
