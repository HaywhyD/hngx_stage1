import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hngx_stage1/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
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
    Future.delayed(
      const Duration(
        milliseconds: 3000,
      ),
      () => Navigator.of(context).pushAndRemoveUntil(
          CupertinoPageRoute(
            builder: (context) => const HomeScreen(),
          ),
          (route) => false),
    );
    return Scaffold(
      body: Center(
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
          width: 100.w,
          height: 100.h,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage(
                'assets/icon/icon.png',
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
      )),
    );
  }
}
