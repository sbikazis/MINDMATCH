# AdMob release checklist

## Integrated in the app
- [x] Google Mobile Ads Flutter SDK (9.2.0).
- [x] MINDMATCH AdMob application ID in the Android manifest.
- [x] Production ad unit IDs stored in the app's ad service.
- [x] Google's sample test ad unit IDs are used in debug builds.
- [x] UMP consent information is refreshed at app startup.
- [x] Ads are requested only when UMP reports that ads may be requested.
- [x] Banner placement on Home and Result screens; no banner in the quiz flow.
- [x] Native ad placement on Home.
- [x] Interstitial frequency limited to every third completed quiz, at the transition to results.
- [x] Rewarded-ad API is prepared, but must not be shown until a real optional reward is implemented.
- [x] In-app privacy-options entry point appears when UMP says it is required.
- [x] Privacy policy updated for Google Mobile Ads and UMP.

## Required before Google Play production release
1. In AdMob, open **Privacy & messaging** and publish the appropriate consent messages for the regions where the app is distributed (including EEA/UK/Switzerland where applicable).
2. Confirm the MINDMATCH app is correctly linked/configured in AdMob and review the app's ad serving status.
3. In Play Console, complete the **Data safety** form for Google Mobile Ads. Account for IP-derived approximate location, app interactions, diagnostics, and device identifiers/advertising ID as applicable to the SDK and settings actually shipped.
4. Complete the Play Console **Ads** declaration and the app's target-audience/content-rating declarations accurately. Do not mark the app as child-directed unless it is genuinely designed for children; follow Google's Families policy if it is.
5. Test on a physical Android device using debug builds only; verify test ads, consent form behavior, banner/native placement, and that interstitials do not interrupt a quiz.
6. Do not click production ads during testing. Do not use production ad unit IDs in debug builds.
7. Verify the published privacy policy URL after deployment.

## Ad unit IDs
- App ID: `ca-app-pub-3303379299409244~1340438065`
- Banner: `ca-app-pub-3303379299409244/2669831609`
- Interstitial: `ca-app-pub-3303379299409244/1245069294`
- Native advanced: `ca-app-pub-3303379299409244/4992742613`
- Rewarded: `ca-app-pub-3303379299409244/6058412276`

## Platform compatibility
The current Google Mobile Ads Android SDK 25.5.0 requires Android API level 24 or higher. The app's Android minSdk is therefore set to at least 24.
