# Step 3B — Native payload layer

Required payloads:
- GAP32 — armeabi-v7a — Android 28+
- GAP64 — arm64-v8a — Android 28+
- vmtouch32 — armeabi-v7a — Android 24+
- vmtouch64 — arm64-v8a — Android 24+

SHA-256:
- GAP32: 0464adac4a65b00e31de7fab33c0cc5426a7335f28d3941f37ac12314478c753
- GAP64: cb64fcc3742cb5534605189a1d1e5309294cfd2825ce206581ad745eb11be488
- vmtouch32: a73edcc661e59b169e99f52a08e8d8b26c78beeb7c69ff0bf1d1675fbc7c392f
- vmtouch64: 05caac082fcfa1d6b5702f1128d3c9ada04e4e9acdbac83e1297d4ab6edfa850

Selection:
1. Read ro.product.cpu.abi, then ro.product.cpu.abilist.
2. Select the matching ARM32/ARM64 pair.
3. Verify SHA-256 before execution.
4. Reject missing, non-executable or mismatched payloads.
5. Never downgrade ARM64 to ARM32 because a payload is missing.
6. Report unsupported ABI through the normalized result contract.

The manifest, selector and verification contract are implemented in this branch. The binary objects and complete source gamelist still require a binary-capable repository upload before 0.4.0 packaging can be considered complete.
