import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_webview_pro/webview_flutter.dart';
import 'package:defenders/utils/progress_indicator.dart';
import 'package:defenders/widget/appbars/custom_app_bar.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';

class VendorScreen extends StatefulWidget {
  final String url;
  final String? isShowAppbar;
  const VendorScreen({super.key, this.isShowAppbar, required this.url});

  @override
  State<VendorScreen> createState() => _VendorScreenState();
}

class _VendorScreenState extends State<VendorScreen> {
  // final Completer<WebViewController> _controller =
  //     Completer<WebViewController>();
  Circle circle = Circle();
  // late final PlatformWebViewControllerCreationParams params;
  WebViewController _controller = WebViewController.fromPlatformCreationParams(
    const PlatformWebViewControllerCreationParams(),
    onPermissionRequest: (WebViewPermissionRequest request) {
      request.grant();
    },
  );

  @override
  void initState() {
    // if (Platform.isAndroid) WebView.platform = AndroidWebView();
    requestCameraPermission();
    // params = const PlatformWebViewControllerCreationParams();
    super.initState();
  }

  @override
  void dispose() {
    if (circle.isShow == true) {
      Future.delayed(const Duration(seconds: 0), () {
        circle.hide(context);
      });
    }

    super.dispose();
  }

  Future<void> requestCameraPermission() async {
    final status = await Permission.camera.request();
    if (status == PermissionStatus.granted) {
      // Permission granted.
    } else if (status == PermissionStatus.denied) {
      // Permission denied.
    } else if (status == PermissionStatus.permanentlyDenied) {
      // Permission permanently denied.
    }

    final audiostatus = await Permission.audio.request();
    if (audiostatus == PermissionStatus.granted) {
      // Permission granted.
    } else if (audiostatus == PermissionStatus.denied) {
      await Permission.audio.request();
      // Permission denied.
    } else if (audiostatus == PermissionStatus.permanentlyDenied) {
      // Permission permanently denied.
    }

    final microphonestatus = await Permission.microphone.request();
    if (microphonestatus == PermissionStatus.granted) {
      // Permission granted.
    } else if (microphonestatus == PermissionStatus.denied) {
      // Permission denied.
    } else if (microphonestatus == PermissionStatus.permanentlyDenied) {
      // Permission permanently denied.
    }

    // controller = WebViewController.fromPlatformCreationParams(
    //   params,
    //   onPermissionRequest: (WebViewPermissionRequest request) {
    //     request.grant();
    //   },
    // );

    // _controller.loadRequest(Uri.parse(widget.url));

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(
      const PlatformWebViewControllerCreationParams(),
      onPermissionRequest: (WebViewPermissionRequest request) {
        request.grant();
      },
    );

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('''
Page resource error:
  code: ${error.errorCode}
  description: ${error.description}
  errorType: ${error.errorType}
  isForMainFrame: ${error.isForMainFrame}
          ''');
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              debugPrint('blocking navigation to ${request.url}');
              return NavigationDecision.prevent;
            }
            debugPrint('allowing navigation to ${request.url}');
            return NavigationDecision.navigate;
          },
          onUrlChange: (UrlChange change) {
            debugPrint('url change to ${change.url}');
          },
          onHttpAuthRequest: (HttpAuthRequest request) {
            // openDialog(request);
          },
        ),
      )
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          Clipboard.setData(ClipboardData(text: message.message));
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        },
      )
      ..loadRequest(Uri.parse(
          // "https://www.youtube.com/watch?v=SemhJ4daZJk"
          widget.url));

    // #docregion platform_features
    // if (Platform.isAndroid) {
    // }
    if (controller.platform is AndroidWebViewController) {
      final myAndroidController =
          controller.platform as AndroidWebViewController;
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
      myAndroidController.setOnShowFileSelector((params) async {
        // Control and show your picker
        // and return a list of Uris.

        // return _androidFilePicker(params);
        FilePickerResult? result = await FilePicker.platform.pickFiles();

        if (result != null) {
          final result = await FilePicker.platform.pickFiles();

          if (result != null && result.files.single.path != null) {
            final file = File(result.files.single.path!);
            return [file.uri.toString()];
          }
          return [];
        }

        return [];
      });
    }
    // #enddocregion platform_features

    _controller = controller;

    // if (Platform.isAndroid) {
    //   // final myAndroidController = controller.platform as webview_flutter_android.AndroidWebViewController;

    //   // myAndroidController.setOnShowFileSelector(_androidFilePicker);
    // }

    setState(() {});
  }

  Future<List<String>> _androidFilePicker(FileSelectorParams params) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      final result = await FilePicker.platform.pickFiles();

      if (result != null && result.files.single.path != null) {
        final file = File(result.files.single.path!);
        return [file.uri.toString()];
      }
      return [];
    }

    return [];
  }

  // JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
  //   return JavascriptChannel(
  //       name: 'Toaster',
  //       onMessageReceived: (JavascriptMessage message) {
  //         // ignore: deprecated_member_use
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(content: Text(message.message)),
  //         );
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.isShowAppbar != null
          ? CustomAppBar(title: widget.isShowAppbar)
          : null,
      body: WebViewWidget(
        controller: _controller,
        gestureRecognizers: {}..add(
            Factory<LongPressGestureRecognizer>(
              () => LongPressGestureRecognizer(),
            ),
          ),
      ),
      // body: WebView(
      //   initialUrl: widget.url, //'https://mirrorhub.in/seller/dashboard',
      //   javascriptMode: JavascriptMode.unrestricted,
      //   onWebViewCreated: (WebViewController webViewController) {
      //     _controller.complete(webViewController);
      //   },
      //   onProgress: (int progress) {
      //     // print("WebView is loading (progress : $progress%)");
      //   },

      //   javascriptChannels: <JavascriptChannel>{
      //     _toasterJavascriptChannel(context),
      //     JavascriptChannel(
      //       name: 'CopyChannel',
      //       onMessageReceived: (JavascriptMessage message) {
      //         // Perform copy operation
      //         Clipboard.setData(ClipboardData(text: message.message));
      //       },
      //     ),
      //   },

      //   navigationDelegate: (NavigationRequest request) {
      //     if (request.url.startsWith('https://www.youtube.com/')) {
      //       // print('blocking navigation to $request}');
      //       return NavigationDecision.prevent;
      //     }
      //     // print('allowing navigation to $request');
      //     return NavigationDecision.navigate;
      //   },
      //   onPageStarted: (String url) {
      //     circle.show(context);

      //     // print('Page started loading: $url');
      //   },
      //   onPageFinished: (String url) {
      //     if (circle.isShow == true) {
      //       Future.delayed(const Duration(seconds: 1), () {
      //         circle.hide(context);
      //       });
      //     }
      //   },
      //   gestureRecognizers: {}..add(
      //       Factory<LongPressGestureRecognizer>(
      //         () => LongPressGestureRecognizer(),
      //       ),

      //     ),

      //   gestureNavigationEnabled: true,
      //   geolocationEnabled: false,
      // ),
    );
  }
}
