# Drag X TURBO 0.4.0 source integration

The five supplied ZIPs are development/reference inputs for the 0.4.0 implementation.

| Source | Integration role |
|---|---|
| Cache cleaner-VeuLexier [ AxM ] | cache/memory behavior reference |
| Celestial-Flinger-Flux-2.5 (12092026 release) | Flinger/display telemetry reference |
| Game-Asset-Prefetcher-1.6 (25082026 release) | asset-prefetch behavior and native payload reference |
| GMS-Optimizer (11082026 released) | GMS maintenance behavior reference |
| NexaCore @EnriqueBrach | AxManager/NexaCore integration and orchestration reference |

## Runtime rule

The source ZIPs are not runtime dependencies and are not executed by Drag X TURBO.

Useful, permitted behavior is adapted into the repository's own component boundaries. Executable/resource payloads required by the final module must be integrated into the repository in later implementation steps rather than referenced from an external ZIP.

## Step 3A status

Step 3A establishes the component structure and shared capability/safety/result conventions. Native payload integration begins in Step 3B.

## Release naming

Drag X TURBO 0.4.0.zip

The GitHub repository is the source of truth; the GitHub Release is the assembled distribution artifact.
