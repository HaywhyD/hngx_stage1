import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:hngx_stage1/web_view_screen.dart';

import 'main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isAgreed = false;

  @override
  Widget build(BuildContext context) {
    Theme.of(context).brightness == Brightness.dark
        ? SystemChrome.setSystemUIOverlayStyle(
            const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.light,
              systemNavigationBarContrastEnforced: true,
              systemNavigationBarColor: Colors.transparent,
              systemNavigationBarIconBrightness: Brightness.light,
            ),
          )
        : SystemChrome.setSystemUIOverlayStyle(
            const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.dark,
              systemNavigationBarContrastEnforced: true,
              systemNavigationBarColor: Colors.transparent,
              systemNavigationBarIconBrightness: Brightness.dark,
            ),
          );

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50.h,
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.25,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        bottom: -10,
                        right: 0,
                        top: -10,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.grey.shade600
                                  : Colors.grey.shade300,
                            ),
                            shape: BoxShape.circle,
                          ),
                          height: 200.h,
                          width: 200.w,
                        ),
                      ),
                      Positioned(
                        left: 0,
                        bottom: -45,
                        right: 0,
                        top: -45,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.grey.shade600
                                  : Colors.grey.shade300,
                            ),
                            shape: BoxShape.circle,
                          ),
                          height: 240,
                          width: 240,
                        ),
                      ),
                      Center(
                        child: Hero(
                          flightShuttleBuilder: (
                            flightContext,
                            animation,
                            flightDirection,
                            fromHeroContext,
                            toHeroContext,
                          ) {
                            switch (flightDirection) {
                              case HeroFlightDirection.push:
                                return Material(
                                  color: Colors.transparent,
                                  child: ScaleTransition(
                                    scale: animation.drive(Tween<double>(
                                      begin: 0,
                                      end: 1,
                                    ).chain(CurveTween(
                                      curve: Curves.fastOutSlowIn,
                                    ))),
                                    child: toHeroContext.widget,
                                  ),
                                );

                              case HeroFlightDirection.pop:
                                return Material(
                                  color: Colors.transparent,
                                  child: toHeroContext.widget,
                                );
                            }
                          },
                          tag: 'profile',
                          child: Container(
                            alignment: Alignment.center,
                            width: 170.w,
                            height: 170.h,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? const Color(0xFFD4D4D4)
                                    : Colors.grey.shade300,
                              ),
                              shape: BoxShape.circle,
                              image: const DecorationImage(
                                image: AssetImage(
                                  'assets/icon/icon.png',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 40,
                        left: 122,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                const Color(0xFFB7B2F2),
                                const Color(0xFFB7B2F2).withOpacity(.5),
                              ],
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight,
                            ),
                            shape: BoxShape.circle,
                          ),
                          height: 15,
                          width: 15,
                        ),
                      ),
                      Positioned(
                        top: 40,
                        right: 127,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                const Color(0xFFF6AE74),
                                const Color(0xFFF6AE74).withOpacity(.5),
                              ],
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight,
                            ),
                            shape: BoxShape.circle,
                          ),
                          height: 10,
                          width: 10,
                        ),
                      ),
                      Positioned(
                        bottom: -2,
                        right: 140,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Color(0xFF79656E),
                            shape: BoxShape.circle,
                          ),
                          height: 7,
                          width: 7,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Text(
                  "Oreoluwa Adejumo",
                  style: GoogleFonts.poppins(fontSize: 30.w),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  "Mobile Developer Track",
                  style: GoogleFonts.poppins(
                    fontSize: 18.w,
                    color: Colors.grey.shade600,
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        CupertinoPageRoute(
                          builder: (context) => const WebViewScreen(
                              url: 'https://github.com/haywhyd'),
                        ),
                      );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 50.h,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEC7E43),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        'Open GitHub',
                        style: GoogleFonts.poppins(
                          fontSize: 18.w,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                SizedBox(
                  height: 30.h,
                ),
                Row(
                  children: [
                    Text(
                      'Change theme',
                      textAlign: TextAlign.start,
                      style: GoogleFonts.poppins(
                        fontSize: 18.w,
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        width: 1.w,
                      ),
                    ),
                    Switch(
                        activeColor: const Color(0xFFEC7E43),
                        value: _isAgreed,
                        onChanged: (val) {
                          if (Theme.of(context).brightness == Brightness.dark) {
                            changeTheme(ThemeMode.light);
                          } else {
                            changeTheme(ThemeMode.dark);
                          }
                          setState(() {
                            _isAgreed = !_isAgreed;
                          });
                        })
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  changeTheme(ThemeMode mode) {
    MyApp.of(context).changeTheme(mode);
  }
}
