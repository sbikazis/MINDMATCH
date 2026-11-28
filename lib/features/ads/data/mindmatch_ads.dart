import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class MindMatchAds {
  MindMatchAds._();

  static final MindMatchAds instance = MindMatchAds._();

  static const appId = 'ca-app-pub-3303379299409244~1340438065';
  static const _productionBanner = 'ca-app-pub-3303379299409244/2669831609';
  static const _productionInterstitial = 'ca-app-pub-3303379299409244/1245069294';
  static const _productionNative = 'ca-app-pub-3303379299409244/4992742613';
  static const _productionRewarded = 'ca-app-pub-3303379299409244/6058412276';

  static const _testBanner = 'ca-app-pub-3940256099942544/6300978111';
  static const _testInterstitial = 'ca-app-pub-3940256099942544/1033173712';
  static const _testNative = 'ca-app-pub-3940256099942544/2247696110';
  static const _testRewarded = 'ca-app-pub-3940256099942544/5224354917';

  Future<void>? _initialization;
  bool _adsReady = false;
  bool _privacyOptionsRequired = false;
  int _completedRounds = 0;
  InterstitialAd? _interstitialAd;
  RewardedAd? _rewardedAd;

  final ValueNotifier<bool> privacyOptionsVisible = ValueNotifier(false);

  bool get isReady => _adsReady;
  bool get privacyOptionsRequired => _privacyOptionsRequired;

  String get bannerAdUnitId =>
      kDebugMode ? _testBanner : _productionBanner;
  String get interstitialAdUnitId =>
      kDebugMode ? _testInterstitial : _productionInterstitial;
  String get nativeAdUnitId => kDebugMode ? _testNative : _productionNative;
  String get rewardedAdUnitId =>
      kDebugMode ? _testRewarded : _productionRewarded;

  Future<void> initialize() => _initialization ??= _initialize();

  Future<void> _initialize() async {
    if (defaultTargetPlatform != TargetPlatform.android) return;

    try {
      final consentUpdate = Completer<void>();
      ConsentInformation.instance.requestConsentInfoUpdate(
        ConsentRequestParameters(),
        () {
          if (!consentUpdate.isCompleted) consentUpdate.complete();
        },
        (FormError error) {
          if (!consentUpdate.isCompleted) consentUpdate.complete();
        },
      );

      try {
        await consentUpdate.future.timeout(const Duration(seconds: 12));
      } on TimeoutException {
        // Ads remain disabled unless UMP confirms that requests are allowed.
      }

      final formCompleted = Completer<void>();
      ConsentForm.loadAndShowConsentFormIfRequired((FormError? error) {
        if (!formCompleted.isCompleted) formCompleted.complete();
      });
      try {
        await formCompleted.future.timeout(const Duration(seconds: 45));
      } on TimeoutException {
        // A missing consent form must never block the offline quiz experience.
      }

      _privacyOptionsRequired =
          await ConsentInformation.instance.getPrivacyOptionsRequirementStatus() ==
              PrivacyOptionsRequirementStatus.required;
      privacyOptionsVisible.value = _privacyOptionsRequired;

      if (!await ConsentInformation.instance.canRequestAds()) return;

      await MobileAds.instance.initialize();
      _adsReady = true;
      _loadInterstitial();
      _loadRewarded();
    } catch (error, stackTrace) {
      // UMP and AdMob are optional. Any plugin/platform failure disables ads,
      // but must not escape into the app's startup flow.
      _adsReady = false;
      debugPrint('MINDMATCH ads initialization failed: $error');
      debugPrintStack(stackTrace: stackTrace);
    }
  }

  Future<void> showPrivacyOptions() async {
    if (!_privacyOptionsRequired) return;
    final completed = Completer<void>();
    ConsentForm.showPrivacyOptionsForm((FormError? error) {
      if (!completed.isCompleted) completed.complete();
    });
    await completed.future.timeout(
      const Duration(seconds: 45),
      onTimeout: () {},
    );
  }

  void _loadInterstitial() {
    if (!_adsReady || _interstitialAd != null) return;
    InterstitialAd.load(
      adUnitId: interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) => _interstitialAd = ad,
        onAdFailedToLoad: (error) => _interstitialAd = null,
      ),
    );
  }

  Future<void> showInterstitialBetweenRounds() async {
    if (!_adsReady) return;
    _completedRounds++;
    // Keep interruptions occasional: show after every third completed quiz.
    if (_completedRounds % 3 != 0) return;

    final ad = _interstitialAd;
    if (ad == null) {
      _loadInterstitial();
      return;
    }
    _interstitialAd = null;

    final dismissed = Completer<void>();
    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        _loadInterstitial();
        if (!dismissed.isCompleted) dismissed.complete();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        ad.dispose();
        _loadInterstitial();
        if (!dismissed.isCompleted) dismissed.complete();
      },
    );
    ad.show();
    await dismissed.future.timeout(
      const Duration(seconds: 45),
      onTimeout: () {},
    );
  }

  void _loadRewarded() {
    if (!_adsReady || _rewardedAd != null) return;
    RewardedAd.load(
      adUnitId: rewardedAdUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) => _rewardedAd = ad,
        onAdFailedToLoad: (error) => _rewardedAd = null,
      ),
    );
  }

  /// Returns true only when the user actually earns the reward.
  /// Call this only from a clearly labelled, optional reward action.
  Future<bool> showRewardedAd({
    required void Function(RewardItem reward) onRewardEarned,
  }) async {
    if (!_adsReady) return false;
    final ad = _rewardedAd;
    if (ad == null) {
      _loadRewarded();
      return false;
    }
    _rewardedAd = null;

    final result = Completer<bool>();
    var earned = false;
    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        _loadRewarded();
        if (!result.isCompleted) result.complete(earned);
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        ad.dispose();
        _loadRewarded();
        if (!result.isCompleted) result.complete(false);
      },
    );
    ad.show(onUserEarnedReward: (adWithoutView, reward) {
      earned = true;
      onRewardEarned(reward);
    });
    return result.future.timeout(
      const Duration(minutes: 2),
      onTimeout: () => earned,
    );
  }

  void dispose() {
    _interstitialAd?.dispose();
    _rewardedAd?.dispose();
    privacyOptionsVisible.dispose();
  }
}

class MindMatchBannerAd extends StatefulWidget {
  const MindMatchBannerAd({super.key});

  @override
  State<MindMatchBannerAd> createState() => _MindMatchBannerAdState();
}

class _MindMatchBannerAdState extends State<MindMatchBannerAd> {
  BannerAd? _banner;

  @override
  void initState() {
    super.initState();
    _prepareBanner();
  }

  Future<void> _prepareBanner() async {
    await Future<void>.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    try {
      await MindMatchAds.instance.initialize();
    } catch (error, stackTrace) {
      debugPrint('MINDMATCH banner initialization failed: $error');
      debugPrintStack(stackTrace: stackTrace);
      return;
    }
    if (!mounted || !MindMatchAds.instance.isReady) return;

    final banner = BannerAd(
      adUnitId: MindMatchAds.instance.bannerAdUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          if (mounted) setState(() {});
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          if (mounted) setState(() => _banner = null);
        },
      ),
    );
    _banner = banner;
    await banner.load();
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _banner?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final banner = _banner;
    if (banner == null) return const SizedBox.shrink();
    return SafeArea(
      top: false,
      child: SizedBox(
        width: banner.size.width.toDouble(),
        height: banner.size.height.toDouble(),
        child: Center(child: AdWidget(ad: banner)),
      ),
    );
  }
}

class MindMatchNativeAd extends StatefulWidget {
  const MindMatchNativeAd({super.key});

  @override
  State<MindMatchNativeAd> createState() => _MindMatchNativeAdState();
}

class _MindMatchNativeAdState extends State<MindMatchNativeAd> {
  NativeAd? _nativeAd;
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    _prepareNativeAd();
  }

  Future<void> _prepareNativeAd() async {
    await Future<void>.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    try {
      await MindMatchAds.instance.initialize();
    } catch (error, stackTrace) {
      debugPrint('MINDMATCH native ad initialization failed: $error');
      debugPrintStack(stackTrace: stackTrace);
      return;
    }
    if (!mounted || !MindMatchAds.instance.isReady) return;

    final ad = NativeAd(
      adUnitId: MindMatchAds.instance.nativeAdUnitId,
      request: const AdRequest(),
      nativeTemplateStyle: NativeTemplateStyle(
        templateType: TemplateType.medium,
        mainBackgroundColor: const Color(0xFF171326),
      ),
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          if (mounted) setState(() => _loaded = true);
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          if (mounted) setState(() {
            _nativeAd = null;
            _loaded = false;
          });
        },
      ),
    );
    _nativeAd = ad;
    await ad.load();
  }

  @override
  void dispose() {
    _nativeAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ad = _nativeAd;
    if (!_loaded || ad == null) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: SizedBox(
          height: 300,
          child: AdWidget(ad: ad),
        ),
      ),
    );
  }
}
