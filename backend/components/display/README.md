# Display component

Owns supported-mode discovery, requested-mode application and post-apply verification.

Rules:
1. Only Android-reported modes are eligible.
2. Requested refresh rate and game FPS target remain separate concepts.
3. Active refresh is reported from Android state after an apply attempt.
4. Unsupported/unavailable controls return fallback or unsupported; they are never simulated.
