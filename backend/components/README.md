# Drag X TURBO components

Each source-derived capability has an isolated component boundary. Components are invoked through the central controller rather than exposing unrelated commands directly.

Planned component boundaries:

- display/ — Android display-mode discovery, application and verification.
- flinger/ — SurfaceFlinger telemetry.
- prefetch/ — game detection, asset/APK warming and native prefetch payloads.
- cache/ — bounded cache/memory maintenance adapted from VeuLexier.
- gms/ — targeted Google Mobile Services maintenance.
- game-profile/ — per-game orchestration and profile selection.
- turbo/ — ordered orchestration of supported components.

Step 3A establishes these boundaries. Actual native payloads and source-derived implementations are added in Steps 3B–3D.
