# Drag X TURBO 0.4.0 release contract

## Architecture

Drag X TURBO → dragxctl central controller → Turbo orchestration → tray/record → hardware-aware display → refresh-rate handling → cache cleaner → GMS optimizer → asset prefetch → Flinger telemetry → NexaCore/AxManager integration.

## Source payload policy

v0.4.0 is built from the five supplied source packages. Components are integrated into the repository rather than represented by placeholder wrappers. The final ZIP is assembled from the repository tree.

## Verification

Before release, packaging must verify:

- module metadata reports v0.4.0 / versionCode 400;
- system/bin/dragxctl is present and executable;
- integrated component payloads exist in the package;
- no action/service script points to an absent external source ZIP;
- ZIP can be extracted successfully;
- SHA-256 is generated for the release artifact;
- the release asset is named exactly Drag X TURBO 0.4.0.zip.