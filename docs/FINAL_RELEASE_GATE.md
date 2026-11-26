# MINDMATCH — Final release gate

This is the final engineering gate before the first Google Play production rollout.

## Code and build
- [ ] Feature-first architecture is merged to main.
- [ ] Flutter analyzer passes without errors.
- [ ] All automated tests pass.
- [ ] Android release App Bundle builds with the production signing key.
- [ ] Debug test APK builds and installs on a physical Android device.
- [ ] Package ID and Play App Signing configuration are confirmed.

## Core product flows
- [ ] Start and finish a solo quiz.
- [ ] Create an MM1 challenge and share its code and fallback URL.
- [ ] Join using a pasted challenge code.
- [ ] Confirm legacy challenge payloads still decode.
- [ ] Complete a friend match and verify score and answer breakdown.
- [ ] Open QR and share result card.
- [ ] Confirm daily challenge rotation and streak persistence.
- [ ] Confirm last 50 history entries persist after restart and can be deleted.

## Quality, privacy and monetization
- [ ] Verify English, Arabic RTL, and French on a physical device.
- [ ] Verify large text and accessibility labels.
- [ ] Verify consent flow and ad privacy options in the EEA.
- [ ] Verify banner/native placements and interstitial timing; no ad interrupts an active quiz.
- [ ] Confirm privacy policy and support pages are reachable.
- [ ] Complete Google Play Data safety, ads declaration, target API, content rating, and store listing.
- [ ] Review crash-free launch and offline behavior.

Do not publish until every applicable item is checked. A successful CI run alone is not production approval.
