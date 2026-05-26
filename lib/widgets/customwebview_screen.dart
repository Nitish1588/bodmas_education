import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomWebViewScreen extends StatefulWidget {
  final String url;
  final String title;
  final bool enableCleaner;

  const CustomWebViewScreen({
    super.key,
    required this.url,
    required this.title,
    this.enableCleaner = true,
  });

  @override
  State<CustomWebViewScreen> createState() => _CustomWebViewScreenState();
}

class _CustomWebViewScreenState extends State<CustomWebViewScreen> {
  late final WebViewController controller;

  bool isLoading = true;
  late bool cleanerEnabled;

  @override
  void initState() {
    super.initState();

    cleanerEnabled = widget.enableCleaner;

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            setState(() => isLoading = true);
          },
          onPageFinished: (url) async {
            setState(() => isLoading = false);

            if (cleanerEnabled) {
              await removeUnwantedElements();
            }
          },

          // 🌐 External link handling
          onNavigationRequest: (request) async {
            final uri = Uri.parse(request.url);
            final currentHost = Uri.parse(widget.url).host;

            // allow same domain inside WebView
            if (uri.host == currentHost) {
              return NavigationDecision.navigate;
            }

            // external open in browser
            await launchUrl(
              uri,
              mode: LaunchMode.externalApplication,
            );

            return NavigationDecision.prevent;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  // 🧹 Cleaner JS
  Future<void> removeUnwantedElements() async {
    await controller.runJavaScript("""
(function() {

  if (window.cleanerInjected) return;
  window.cleanerInjected = true;

  const style = document.createElement('style');
  style.id = "customCleanerStyle";

  style.innerHTML = \`
    header, footer,
    .header, .footer,
    .navbar, .top-bar, .bottom-bar,
    .ads, .ad, .ad-container,
    .ad-wrapper, .adsbygoogle,
    .advertisement, .banner,
    .sponsored {
      display: none !important;
      visibility: hidden !important;
    }
  \`;

  document.head.appendChild(style);

  function cleanPage() {
    const selectors = [
      'header','footer',
      '.header','.footer',
      '.navbar','.top-bar','.bottom-bar',
      '.ads','.ad','.ad-container',
      '.ad-wrapper','.adsbygoogle',
      '.advertisement','.banner',
      '.sponsored'
    ];

    selectors.forEach(selector => {
      document.querySelectorAll(selector).forEach(el => el.remove());
    });
  }

  cleanPage();

  window.cleanerInterval = setInterval(cleanPage, 1000);

})();
""");
  }

  Future<void> disableCleaner() async {
    await controller.runJavaScript("""
(function() {

  const style = document.getElementById("customCleanerStyle");
  if (style) style.remove();

  if (window.cleanerInterval) {
    clearInterval(window.cleanerInterval);
  }

  window.cleanerInjected = false;

})();
""");
  }

  Future<void> toggleCleaner() async {
    setState(() {
      cleanerEnabled = !cleanerEnabled;
    });

    if (cleanerEnabled) {
      await removeUnwantedElements();
    } else {
      await disableCleaner();
      await controller.reload();
    }
  }

  // ⬅️ BACK BUTTON HANDLING
  Future<bool> handleBack() async {
    if (await controller.canGoBack()) {
      controller.goBack();
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: handleBack,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),

        body: Stack(
          children: [
            WebViewWidget(controller: controller),

            if (isLoading)
              Center(
                child: TweenAnimationBuilder(
                  tween: Tween<double>(begin: 0, end: 1),
                  duration: const Duration(seconds: 1),
                  builder: (_, double value, child) {
                    return Transform.rotate(
                      angle: value * 6.3,
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: SweepGradient(
                            colors: [
                              Colors.blue,
                              Colors.purple,
                              Colors.pink,
                              Colors.blue,
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}