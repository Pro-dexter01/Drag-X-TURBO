# Drag X TURBO integrated backends

The supplied Celestial Flinger Flux, Game Asset Prefetcher, VeuLexier Cache Cleaner, GMS Optimizer and NexaCore packages are development references. Their useful behaviors are adapted into the standalone Drag X TURBO backend rather than shipped as runtime dependencies.

`dragxctl` is the single command surface. It performs capability detection before actions and reports actual Android state.

Display refresh-rate semantics:
- requested = user target
- supported = Android-reported physical modes
- active = Android-reported active mode
- verified = requested mode is actually active
- fallback = requested mode is unsupported or could not be applied

No arbitrary 144/165/240 Hz value is reported as supported or active.
