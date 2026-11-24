# MINDMATCH MVP — Product Scope

## Core loop
1. Player answers seven playful, non-sensitive multiple-choice prompts.
2. App generates an MM1- challenge code containing the seven option indexes.
3. Player shares the code outside the app.
4. Friend pastes the code, answers the same seven prompts, and sees the exact-match percentage plus per-question comparison.

## MVP boundaries
- Offline-first; no registration, server, or personal profile.
- One curated question pack.
- Deterministic scoring: exact same option = match; percentage is rounded to the nearest integer.
- Copy-to-clipboard sharing in the first scaffold.
- No claim that the score is a scientific measure of compatibility or personality.
- Challenge payload is Base64URL-encoded for transport, NOT encrypted. Never put private data in it.

## Next increments
1. Localized English, Arabic (RTL), and French question packs and UI.
2. Native share sheet and QR generation/scanning.
3. Branded result cards and save/share image.
4. More themed question packs and daily question rotation.
5. Integrate Google Mobile Ads only after real app/ad unit IDs and consent/privacy flows exist.
6. Add backend-backed group/live challenges only if usage validates the need.

## Acceptance criteria
- A new player can complete all seven questions without an account.
- A challenge code can be copied, reopened on a separate install, and decoded.
- Invalid, truncated, unsupported, or malformed codes show a friendly error.
- Match score is reproducible and agrees with the per-question comparison.
- No ads interrupt answering or reveal screens.
