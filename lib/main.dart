import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'screens/home_screen.dart';

const mindBackground = Color(0xFF090812);
const mindSurface = Color(0xFF171326);
const mindSurfaceRaised = Color(0xFF211A35);
const mindPurple = Color(0xFF9B7BFF);
const mindLilac = Color(0xFFD0C0FF);
const mindGold = Color(0xFFFFD58A);
const mindMuted = Color(0xFFAAA2BC);
final ValueNotifier<Locale> mindLocale = ValueNotifier(const Locale('en'));

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MindMatchApp());
}

class MindMatchApp extends StatelessWidget {
  const MindMatchApp({super.key});
  @override
  Widget build(BuildContext context) {
    const outline = Color(0xFF352B4A);
    return ValueListenableBuilder<Locale>(
      valueListenable: mindLocale,
      builder: (context, locale, _) => MaterialApp(
        title: 'MINDMATCH',
        debugShowCheckedModeBanner: false,
        locale: locale,
        supportedLocales: const [Locale('en'), Locale('ar'), Locale('fr')],
        localizationsDelegates: GlobalMaterialLocalizations.delegates,
        theme: ThemeData(
          useMaterial3: true, brightness: Brightness.dark,
          scaffoldBackgroundColor: mindBackground,
          colorScheme: ColorScheme.fromSeed(seedColor: mindPurple, brightness: Brightness.dark, surface: mindSurface),
          appBarTheme: const AppBarTheme(backgroundColor: mindBackground, foregroundColor: Colors.white, centerTitle: false, elevation: 0, surfaceTintColor: Colors.transparent),
          snackBarTheme: SnackBarThemeData(behavior: SnackBarBehavior.floating, backgroundColor: mindSurfaceRaised, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
          inputDecorationTheme: InputDecorationTheme(
            filled: true, fillColor: mindSurface, hintStyle: const TextStyle(color: mindMuted),
            contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: const BorderSide(color: outline)),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: const BorderSide(color: outline)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: const BorderSide(color: mindLilac, width: 1.5)),
          ),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
