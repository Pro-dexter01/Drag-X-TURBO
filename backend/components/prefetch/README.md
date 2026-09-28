# Prefetch component

Owns game detection and bounded asset/APK warming.

## Step 3B native payload contract

The source Game Asset Prefetcher package provides GAP32/GAP64 and vmtouch32/vmtouch64. Their source SHA-256 values are recorded in payload-manifest.tsv.

TURBO selects the pair from the device-reported ABI and verifies both files before execution. Missing, non-executable or hash-mismatched payloads are reported as fallback/error; the wrong architecture is never silently executed.

The source package also supplies gamelist.txt. Its package IDs are source data for the TURBO game database and must be normalized into the repository during Step 3B.

The source ZIP is not a runtime dependency.
