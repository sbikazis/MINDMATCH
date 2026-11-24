# MINDMATCH

A playful social mind-matching game. Answer the same questions as a friend, compare choices, and share a result card.

## Product direction
- Offline-first Flutter app; no account required for the first release.
- Short question packs with transparent, deterministic matching scores.
- Challenge codes carry the creator's answers so a friend can complete a match without a backend.
- Arabic, English, and French foundations.
- Privacy-first: answers stay on-device unless the user deliberately shares a challenge code.

## Native platforms
- Android host project: `android/`
- iOS host project: `ios/`
- Final Android application ID and iOS bundle identifier: `com.sbikazis.mindmatch` (store registration is still required before submission).
- Android minimum SDK: 24; iOS deployment target: 15.0.

## Status
Native Android and iOS host projects are included. Ads and remote/group challenges are intentionally not enabled until real AdMob IDs and a secure backend are configured.

## Run
```sh
flutter pub get
flutter analyze
flutter test
flutter run
```

See [native platform setup](docs/PLATFORM_SETUP.md) for Android/iOS build and signing instructions.

## Privacy and support

- Privacy policy: [MINDMATCH Privacy Policy](https://sbikazis.github.io/MINDMATCH/privacy.html)
- Support: [MINDMATCH Help & Support](https://sbikazis.github.io/MINDMATCH/support.html)
- Public information site: [MINDMATCH](https://sbikazis.github.io/MINDMATCH/)

These pages are published from `docs/` using GitHub Pages. The repository's GitHub Pages source must be set to **GitHub Actions** under Settings → Pages before the first deployment can publish successfully.
