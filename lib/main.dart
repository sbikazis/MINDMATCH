import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:mindmatch/app/mindmatch_app.dart';
import 'package:mindmatch/features/ads/data/mindmatch_ads.dart';
import 'package:mindmatch/features/daily/data/mindmatch_retention.dart';
import 'package:mindmatch/features/history/data/mindmatch_history.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  unawaited(MindMatchAds.instance.initialize());
  unawaited(MindMatchRetention.instance.load());
  unawaited(MindMatchHistory.instance.load());
  runApp(const MindMatchApp());
}
