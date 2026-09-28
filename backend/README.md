# Drag X TURBO - Hardware-Aware Display & FPS

This layer makes Display & FPS hardware-aware instead of treating refresh-rate numbers as arbitrary selectable values.

Runtime contract:
- Requested Hz = the user's requested target.
- Supported Hz = modes Android reports for the physical display.
- Active Hz = the mode Android reports as active after a request.
- A value is never reported active merely because the UI accepted it.

Detection reads Android display-service data and extracts display ID, mode ID, width, height, refresh rate, and active mode ID.

Apply/verify requirements:
1. Refresh supported modes immediately before applying.
2. Reject a request with no matching Android-supported mode.
3. Apply only an exact supported mode when the device exposes a supported display-control command.
4. Re-read the active mode after applying.
5. Mark a request Verified only when Android reports the requested mode active.
6. Otherwise report requested-but-not-active and expose the actual active mode.
7. Never claim 240 Hz or any other rate without Android reporting it.

UI semantics:
Requested: 120 Hz
Supported: 60 / 90 / 120 Hz
Active: 120 Hz
State: Verified

Unsupported example:
Requested: 240 Hz
Supported: 60 / 90 / 120 Hz
Active: 120 Hz
State: Fallback

Supported-mode controls must be generated from the device-reported list. Do not hard-code 144/165/240 Hz entries.

Refresh rate and game FPS remain separate: display mode is the physical panel mode; game FPS target is the application/render target; active FPS is measured/live telemetry when available.

If display control is unavailable, remain read-only and report detected modes. Never emit fake success.
