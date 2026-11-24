# Native platform setup

The Flutter application now includes native Android and iOS host projects.

## Application identifiers

- Android application ID / namespace: `com.sbikazis.mindmatch`
- iOS bundle identifier: `com.sbikazis.mindmatch`
- Display name: `MINDMATCH`
- Android minimum SDK: 24 (Android 7.0)
- Android target SDK: 36
- iOS deployment target: 15.0

The identifier is a default based on the repository owner namespace. Before the first store submission, confirm it is available and reserve the same identifier in Google Play Console and Apple Developer.

## Android

Open the repository root in Android Studio, or run:

```sh
flutter pub get
flutter build appbundle --release
```

Flutter injects the Gradle wrapper scripts and wrapper JAR from the installed Flutter SDK when needed. The current release build uses debug signing so it can be built for local verification. Configure a private release keystore and signing properties before publishing. Never commit keystores or passwords.

## iOS

On macOS with Xcode and CocoaPods installed:

```sh
flutter pub get
cd ios
pod install
cd ..
flutter build ios --release --no-codesign
```

Open `ios/Runner.xcworkspace` in Xcode. Select your Apple Developer Team and configure signing before archiving or distributing.

## Still required before store release

- Create final production launcher/app icons for Android and iOS.
- Confirm the application identifier is available and reserve it in both stores.
- Configure Android release signing and Apple signing/team.
- Build and test on physical devices.
- Complete store listing, privacy URL, age/content rating, and platform policy declarations.

No signing keys, Apple Team ID, AdMob IDs, or store credentials are included in this repository.
