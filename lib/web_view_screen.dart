import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  final String url;
  const WebViewScreen({
    super.key,
    required this.url,
  });

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  double _progress = 0;
  WebViewController _controller = WebViewController();
  bool _goForward = false;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            if (mounted) {
              setState(() {
                _progress = (double.parse((progress / 100).toString()));
              });
            }
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) async {
            _goForward = await _controller.canGoForward();
            if (mounted) {
              setState(() {});
            }
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith(widget.url)) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    Theme.of(context).brightness == Brightness.dark
        ? SystemChrome.setSystemUIOverlayStyle(
            const SystemUiOverlayStyle(
              statusBarColor: Color.fromARGB(0, 10, 3, 3),
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

    return WillPopScope(
      onWillPop: () async {
        if (FocusScope.of(context).hasFocus) {
          FocusScope.of(context).unfocus();

          return false;
        } else {
          Navigator.pop(context);
          return true;
        }
      },
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Column(
            children: [
              Container(
                padding: EdgeInsets.only(
                  left: 15.w,
                  top: 30.h,
                  right: 15.w,
                ),
                color: Theme.of(context).brightness == Brightness.dark
                    ? const Color(0xFF181818)
                    : Colors.white,
                width: double.infinity,
                height: MediaQuery.sizeOf(context).height * 0.10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () async {
                          FocusScope.of(context).unfocus();
                          Navigator.pop(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? const Color(0xFF353945)
                                    : Colors.grey.shade200,
                            shape: BoxShape.circle,
                          ),
                          height: 25.h,
                          width: 25.w,
                          child: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            size: 16,
                            weight: 600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    Hero(
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
                        height: 30.h,
                        width: 30.w,
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
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    const Expanded(
                      child: SizedBox(
                        width: double.infinity,
                      ),
                    ),
                    Text(
                      'Oreoluwa Adejumo',
                      style: GoogleFonts.poppins(
                        fontSize: 16.w,
                      ),
                    ),
                    const Expanded(
                      child: SizedBox(
                        width: double.infinity,
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () async {
                            if (await _controller.currentUrl() != widget.url) {
                              _controller.goBack();
                              setState(() {
                                _goForward = true;
                              });
                            } else {
                              popContext();
                            }
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                          ),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        IconButton(
                          onPressed: _goForward
                              ? () async {
                                  if (await _controller.canGoForward()) {
                                    _controller.goForward();
                                  }
                                }
                              : null,
                          icon: const Icon(
                            Icons.arrow_forward,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: _progress != 1.0,
                child: SizedBox(
                  width: double.infinity,
                  height: 4.h,
                  child: LinearProgressIndicator(
                    value: _progress,
                    color: const Color(0xFFEC7E43),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.88,
                child: Scaffold(
                  body: WebViewWidget(
                    controller: _controller,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  popContext() {
    Navigator.pop(context);
  }
}
