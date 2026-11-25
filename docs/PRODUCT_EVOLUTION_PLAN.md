# MINDMATCH — Product evolution and backend rollout

## Goal
Turn the current stable quiz MVP into a polished social game that earns repeat visits, makes inviting a friend effortless, and can grow into group play without introducing mandatory registration or paid infrastructure.

## Product principles
- Preserve a complete offline solo experience.
- Keep the current deterministic match calculation and challenge-code compatibility.
- Make the next action obvious: play, invite, join, or return for today's challenge.
- Never imply that a match score measures scientific compatibility or personality.
- Ads must not interrupt answering, hide controls, or appear on the challenge hand-off screen.
- No production rollout until the new flows pass Android device testing and privacy review.

## Workstreams

### 1. Brand and first impression
- Replace the rough launcher artwork with a clean geometric mark based on two interlocking minds and the existing pink / blue / violet palette.
- Validate adaptive and legacy Android launchers at small icon sizes, on light and dark launchers, and on a physical device.
- Review typography, spacing, contrast, empty states, loading states, and Arabic RTL layout.

### 2. Retention and content
- Expanded the original catalogue to 56 unique questions across eight editorially distinct packs; continue adding versioned content rather than recycled combinations.
- Added an offline daily streak backed by a small local completion history; next add a browsable recent-results history.
- Add rotating daily/weekly themes and seasonal collections with content versioning.
- Later, fetch published packs from a backend while retaining a cached offline catalogue.
- Do not use sensitive questions or present scores as psychological assessments.

### 3. Invitations and joining
- Share one human-readable HTTPS invitation link with a short explanation and a challenge payload.
- The web fallback must explain what MINDMATCH is, show the challenge code, and make copying it easy.
- When a verified app-link domain is configured, route installed-app users directly into the challenge; otherwise the web fallback remains functional.
- Keep the legacy MM1 code parser working during migration.
- Add paste-from-clipboard and a prominent Join action on the home screen; validate malformed/expired links with friendly recovery.

### 4. Social and group play
- Start with anonymous Firebase Authentication so a user can join without a sign-up form.
- Use Cloud Firestore for challenge metadata, group rooms, content manifests, and expiry timestamps.
- Store only the minimum data required. Ask before publishing profile details or making a room discoverable.
- Use server-authoritative validation for membership, scoring, expiry, rate limits, and moderation before public group challenges launch.
- Do not trust client-written scores or client timestamps for competitive leaderboards.

## Backend decision: Firebase Spark first
- Prototype with Firebase Authentication (anonymous) and Cloud Firestore on the no-cost Spark plan.
- Avoid Cloud Functions, paid extensions, and any feature that requires switching to Blaze until the owner explicitly approves the cost and billing implications.
- Enforce Firestore Security Rules and App Check before connecting real users.
- Treat client-only group writes as a prototype, not a secure public multiplayer system.
- Define quotas, offline behavior, deletion/retention, and abuse limits before launch.
- If Firebase requires a billing upgrade for a required capability, stop and present a no-cost alternative rather than enabling billing.

## Delivery gates
1. **Foundation:** visual identity, share landing page, obvious join flow, product architecture, and regression tests.
2. **Retention:** additional original content, daily streak/history, pack discovery, localization, and offline persistence.
3. **Invites:** verified HTTPS app links, deferred install hand-off where supported, code validation, and device-to-device tests.
4. **Backend pilot:** anonymous auth, Firestore schema/rules, App Check, emulator tests, quota monitoring, and privacy-policy update.
5. **Groups:** secure room lifecycle, invite permissions, anti-spam controls, reporting, and server-authoritative results.
6. **Release readiness:** accessibility, Android device matrix, ads/consent checks, Play Console Data safety and Ads declarations, crash-free test window, and signed AAB.

## Explicit non-goals for the first backend increment
- No mandatory account creation.
- No paid hosting or billing activation.
- No public leaderboard based on untrusted client data.
- No contact-book upload.
- No collection of sensitive personality or relationship data.
- No production Firebase connection until rules and privacy disclosures are reviewed.
