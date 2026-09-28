# Drag X TURBO 0.4.0 — integrated feature adaptation

The five supplied packages are development/reference sources, not runtime dependencies.

## Current Step 3A foundation

Step 3A establishes isolated component boundaries and a shared backend contract:

- display → Android-reported display modes and verified application.
- flinger → read-only SurfaceFlinger telemetry.
- prefetch → bounded game/APK/cache warming, with native payload integration planned for Step 3B.
- cache → bounded cache/memory maintenance adapted from VeuLexier, with operation-level safety classification planned for Step 3C.
- gms → targeted Google Mobile Services maintenance.
- game-profile → per-game capability/profile selection.
- turbo → ordered orchestration.
- core/lib → capability, safety and normalized-result conventions.

The existing dragxctl and display backend remain the active implementation surface during this foundation step.

## Source adaptation policy

Source behavior is adapted component-by-component. The source ZIPs are not executed or required at runtime.

Unsupported capabilities are reported rather than simulated. Broad deletion, settings wiping, unrelated system-data mutation and other destructive source operations are not part of the default TURBO path.

## Planned implementation

- Step 3B: integrate GAP32/GAP64, vmtouch32/vmtouch64, game database, ABI selection and payload integrity checks.
- Step 3C: expand cache, GMS and Flinger implementations while preserving verified display semantics.
- Step 3D: expand dragxctl, snapshots/rollback, normalized results and Turbo/Game Profile orchestration.
- Step 3E: validate payloads, packaging, architecture selection and fallbacks.
