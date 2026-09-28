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


## Step 3A — repository foundation

Completed on 2026-09-28:
- Added isolated backend component boundaries for display, Flinger, prefetch, cache, GMS, Game Profile and Turbo orchestration.
- Added shared core/lib conventions for capability checks, safety classes and normalized command results.
- Corrected source-integration documentation so the five ZIPs are clearly development/reference inputs, not runtime dependencies.
- Kept native payload integration and deeper source-derived behavior for Steps 3B–3D.

Next: Step 3B native payload layer — GAP32/GAP64, vmtouch32/vmtouch64, game database, ABI selection and payload integrity verification.

## 0.4.0 packaging correction

The repository is the persistent source of truth. The five supplied source ZIPs are inputs to the repository integration and to the release distribution. v0.4.0 must package real executable/resource payloads inside the assembled module; tiny wrappers that depend on external ZIPs are not acceptable. The GitHub Release artifact is `Drag X TURBO 0.4.0.zip`. A packaging workflow is present at `.github/workflows/package-release.yml` and produces the ZIP plus SHA-256 checksum.