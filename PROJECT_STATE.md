# Drag X TURBO — v0.4.0

Current project direction:
- AxManager/NexaCore-compatible standalone plugin/module.
- Existing architecture and UI are preserved; new work is additive.
- Central dragxctl backend for capability detection and writable game/display controls.
- Game Profile, Display & FPS, Touch & Feel, Live HUD and Turbo functions.
- Supplied Celestial Flinger Flux, Game Asset Prefetcher, VeuLexier Cache Cleaner, GMS Optimizer and NexaCore packages are development/reference sources whose useful behaviors are adapted into TURBO.
- The five source ZIPs are not runtime dependencies and are not the Drag X TURBO deliverable.
- Final deliverable is the standalone Drag X TURBO module ZIP.

Integrated backend behaviors:
- SurfaceFlinger/display telemetry and hardware-aware refresh verification.
- Game detection and bounded game-data/APK cache warming.
- Controlled Android cache maintenance.
- Targeted Google Mobile Services cache maintenance.
- Central orchestration through dragxctl.

Display verification requirement:
1. Read supported display modes from Android.
2. Apply only an Android-reported supported mode when a supported display-control command exists.
3. Read the active mode after applying.
4. Report requested vs active Hz in Live HUD.
5. Fall back safely when the requested mode is unsupported or control is unavailable.
6. Never claim 144/165/240 Hz merely because a number was placed in the UI.

Refresh rate and game FPS remain separate: display mode is the physical panel mode; game FPS target is the application/render target; active FPS is measured/live telemetry when available.

Important: the existing architecture/design must not be removed when adding features.
