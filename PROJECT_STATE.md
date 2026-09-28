# Drag X TURBO — v0.4.0

Current project direction:
- AxManager/NexaCore-compatible standalone plugin/module.
- Existing architecture and UI are preserved; new work is additive.
- Central dragxctl backend for capability detection and writable game/display controls.
- Game Profile, Display & FPS, Touch & Feel, Live HUD and Turbo functions.
- Integrated backend actions for Celestial Flinger Flux, Game Asset Prefetcher, VeuLexier cache cleaning and GMS optimization.
- Recorder policy scales with device/display class rather than a fixed 540p ceiling.
- Refresh-rate controls must distinguish requested refresh rate from the actual active hardware mode.
- 240 Hz is currently an exposed/requested target, not verified as an actual 240 Hz output on a physical device.

Verification requirement for refresh rate:
1. Read supported display modes from Android.
2. Apply the requested mode only when supported.
3. Read the active mode after applying it.
4. Report requested vs active Hz in Live HUD.
5. Fall back safely when the requested mode is unsupported.

Important: the existing architecture/design must not be removed when adding features.

## Hardware-aware Display & FPS implementation

The `backend/display_hardware.sh` detector now provides Android-reported display modes and the active mode as separate data. `backend/README.md` defines the requested/supported/active contract and verification semantics, and `backend/test_display_hardware.sh` provides a parser regression fixture. The next UI/dragxctl integration must consume these results rather than maintain a hard-coded Hz list.
