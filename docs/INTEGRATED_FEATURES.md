# Drag X TURBO 0.4.0 — integrated feature adaptation

The five supplied packages are development references, not runtime dependencies.

- Celestial Flinger Flux → SurfaceFlinger/display telemetry and hardware-aware refresh verification.
- Game Asset Prefetcher → game detection plus bounded APK/cache warming.
- VeuLexier → controlled cache maintenance through Android cache-management APIs and root-only cache cleanup.
- GMS Optimizer → targeted Google Mobile Services cache maintenance.
- NexaCore → central optimization/orchestration concept; TURBO owns the single `dragxctl` command surface.

The integration intentionally does not copy the supplied binary executables into Drag X TURBO. Unsupported capabilities are reported rather than simulated.
