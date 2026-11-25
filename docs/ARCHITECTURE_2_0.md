# MINDMATCH 2.0 — Application architecture

This release reorganizes the Flutter application around product features while preserving the existing offline-first product behavior and challenge-code compatibility.

## Top-level structure

- `app/`: application composition, locale state, and app shell.
- `core/`: design tokens and cross-feature foundations.
- `features/`: feature-owned presentation, domain models, and data services.
- `shared/`: cross-feature localization and reusable presentation resources.

## Feature ownership

| Feature | Responsibility |
|---|---|
| `home` | Home experience, pack discovery, entry points |
| `quiz` | Question catalog, question model, quiz flow |
| `challenges` | Challenge encoding/decoding and invitation compatibility |
| `results` | Match results, comparison, QR and sharing |
| `history` | Private on-device history and history screen |
| `daily` | Daily challenge rotation and streak persistence |
| `ads` | AdMob initialization, placements, consent and privacy options |

Each feature owns its implementation. Cross-feature dependencies use stable `package:mindmatch/...` imports instead of fragile relative paths between screen folders.

## Runtime composition

`main.dart` is now a small composition root. It initializes Flutter, starts the existing local persistence and ads services, and launches `MindMatchApp`. Theme tokens and locale state live outside the app shell.

## Product invariants retained

- Solo play remains available without an account or network.
- The existing MM1 challenge format and legacy question IDs remain compatible.
- History remains private and on-device, with its existing retention limit.
- Daily rotation and streak behavior remain local.
- Ad placements remain outside the active question-answering flow.
- No Firebase project, paid backend, billing dependency, or mandatory registration is introduced.

## Validation required before release

- `flutter pub get`
- `flutter analyze --no-fatal-infos`
- `flutter test`
- `flutter build appbundle --release`
- `flutter build apk --debug`
- Physical Android verification of challenge creation/join, QR/share, history persistence and deletion, RTL layout, consent/privacy options, and live ad behavior.

A green CI build is necessary but does not replace device verification or Play Console policy review.
