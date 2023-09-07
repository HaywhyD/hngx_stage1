import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const MyApp(),
  );
}

ThemeMode _themeMode = ThemeMode.system;

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
  // ignore: library_private_types_in_public_api
  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  MaterialColor buildMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = {};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }

  void changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(411.4, 868.6),
        minTextAdapt: true,
        builder: (context, child) {
          return MaterialApp(
            themeMode: _themeMode,
            theme: ThemeData(
              scaffoldBackgroundColor: const Color(0xFFEFEFEF),
              checkboxTheme: CheckboxThemeData(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25))),
              visualDensity: VisualDensity.adaptivePlatformDensity,
              primarySwatch: buildMaterialColor(
                const Color(0xFFEC7E43),
              ),
            ),
            darkTheme: ThemeData(
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ButtonStyle(
                  backgroundColor: MaterialStateColor.resolveWith(
                    (states) => states.isEmpty
                        ? const Color(0xFFF6AE74)
                        : Colors.grey.shade400,
                  ),
                ),
              ),
              scaffoldBackgroundColor: const Color(0xFF111111),
              checkboxTheme: CheckboxThemeData(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25))),
              colorScheme: const ColorScheme.light(
                background: Color(0xFF001025),
                brightness: Brightness.dark,
              ),
              textTheme: const TextTheme(
                titleLarge: TextStyle(color: Colors.white),
                labelLarge: TextStyle(color: Colors.white),
                bodySmall: TextStyle(color: Colors.white),
              ),
              primaryColor: const Color(0xFFEC7E43),
              brightness: Brightness.dark,
              primarySwatch: buildMaterialColor(
                const Color(0xFFEC7E43),
              ),
            ),
            home: const SplashScreen(),
            debugShowCheckedModeBanner: false,
          );
        });
  }
}
