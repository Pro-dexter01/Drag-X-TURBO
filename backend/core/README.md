# Drag X TURBO core

The core layer owns shared execution contracts used by every backend component.

Responsibilities:
- capability detection
- safety classification
- state snapshot/restore boundaries
- normalized command results
- logging without pretending an unsupported operation succeeded

Component implementations must not silently invent Android capabilities. A backend either performs a verified operation or returns a structured fallback/unsupported result.

## Result contract

Machine-readable lines use:

RESULT|component=<name>|action=<action>|status=<ok|fallback|unsupported|error>|reason=<reason>

Optional fields may follow the same key=value convention.

## Safety classes

- READ_ONLY — telemetry/detection only.
- BOUNDED — reversible or bounded maintenance with no global persistent override.
- PERSISTENT — changes a persistent system/app preference and requires a snapshot before mutation.
- DESTRUCTIVE — data deletion or broad system mutation. Not part of the default TURBO path.

The default TURBO path may use READ_ONLY and approved BOUNDED operations. PERSISTENT operations require explicit support plus restore handling.
