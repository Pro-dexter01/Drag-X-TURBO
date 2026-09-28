# Turbo orchestration component

Owns the ordered high-level TURBO sequence.

The orchestrator must:
1. detect capabilities;
2. select only supported operations;
3. execute bounded operations in a defined order;
4. collect normalized results;
5. expose failures/fallbacks instead of masking them.

Step 3D will connect this boundary to the expanded dragxctl command surface.
