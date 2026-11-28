import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:mindmatch/app/mindmatch_app.dart';
import 'package:mindmatch/features/ads/data/mindmatch_ads.dart';
import 'package:mindmatch/features/daily/data/mindmatch_retention.dart';
import 'package:mindmatch/features/history/data/mindmatch_history.dart';

Future<void> _runStartupTask(
  String name,
  Future<void> Function() task,
) async {
  try {
    await task();
  } catch (error, stackTrace) {
    // Startup conveniences must never prevent the core quiz from opening.
    FlutterError.reportError(
      FlutterErrorDetails(
        exception: error,
        stack: stackTrace,
        library: 'MINDMATCH startup',
        context: ErrorDescription('while initializing $name'),
      ),
    );
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Render the actual app before invoking optional plugins or local storage.
  // This keeps a slow or unavailable platform channel off the cold-start path.
  runApp(const MindMatchApp());

  WidgetsBinding.instance.addPostFrameCallback((_) {
    unawaited(_runStartupTask(
      'daily challenge history',
      MindMatchRetention.instance.load,
    ));
    unawaited(_runStartupTask(
      'private quiz history',
      MindMatchHistory.instance.load,
    ));
    unawaited(_runStartupTask(
      'ad consent and SDK',
      MindMatchAds.instance.initialize,
    ));
  });
}
