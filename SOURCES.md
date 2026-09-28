# Drag X TURBO 0.4.0 source integration

The five supplied ZIPs are the source inputs for v0.4.0. They are preserved as release/source artifacts while their executable and resource components are integrated into the repository under the backend/component layout.

| Source | Integration role |
|---|---|
| Cache cleaner-VeuLexier [ AxM ] | cache-cleaner backend |
| Celestial-Flinger-Flux-2.5 (12092026 release) | Flinger backend + telemetry |
| Game-Asset-Prefetcher-1.6 (25082026 release) | asset-prefetch backend |
| GMS-Optimizer (11082026 released) | GMS maintenance backend |
| NexaCore @EnriqueBrach | AxManager/NexaCore integration reference and web/backend resources |

## Packaging rule

The release package must contain the actual integrated executable/resource payloads. A wrapper that merely points at an external ZIP is not considered a complete payload.

Decorative source-only assets may be deduplicated when packaging, but executable files, scripts, configuration, game lists and required web/resources must remain available to the module.

## Release naming

Drag X TURBO 0.4.0.zip

The GitHub repository is the source of truth; the GitHub Release is the assembled distribution artifact.