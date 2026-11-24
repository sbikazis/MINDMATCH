# Release checklist

- [x] Add native Android and iOS host projects with a consistent default application identifier (verify store availability before release).
- [ ] Confirm application ID / Android package name is available and reserve it before first Play upload.
- [x] Add Android legacy vector launcher icon and Android 8+ adaptive launcher icon.
- [x] Add editable iOS brand artwork (SVG asset).
- [ ] Export and configure the required 1024 × 1024 PNG in the iOS AppIcon asset catalog.
- [x] Add English, Arabic RTL, and French localization foundations.
- [x] Native share sheet for challenge codes and QR display for challenge codes.
- [x] Branded result-card capture and image sharing implementation (verify on physical devices).
- [ ] Add accessibility labels and text scaling checks.
- [ ] Add AdMob app ID and real ad unit IDs; never ship test IDs as production.
- [ ] Publish privacy policy and complete Data safety / consent requirements before enabling ads.
- [ ] Run flutter pub get, flutter analyze, and flutter test on a Flutter SDK.
- [ ] Build and test a release Android App Bundle on physical devices.
- [ ] Configure production Android signing and Apple Developer signing.
- [ ] Prepare store listing, screenshots, feature graphic, and content rating.
- [ ] Verify Play Console target API and current policy requirements at release time.
