import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BlogWebViewScreen extends StatefulWidget {
  final String url;
  final String title;

  const BlogWebViewScreen({super.key, required this.url, required this.title});

  @override
  State<BlogWebViewScreen> createState() => _BlogWebViewScreenState();
}

class _BlogWebViewScreenState extends State<BlogWebViewScreen> {
  late final WebViewController controller;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            setState(() {
              isLoading = true;
            });
          },

          onPageFinished: (url) async {
            setState(() {
              isLoading = false;
            });

            await injectCleaner();
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  Future<void> injectCleaner() async {
    await controller.runJavaScript("""

(function() {

  // CSS FORCE HIDE
  const style = document.createElement('style');

  style.innerHTML = `

    header,
    footer,
    nav,
    aside,
    iframe,

    .header,
    .footer,
    .navbar,
    .bottom-bar,

    .ads,
    .ad,
    .ad-container,
    .ad-wrapper,
    .adsbygoogle,
    .advertisement,
    .popup,
    .sponsored,

    [id*="ad"],
    [class*="ad"],
    [class*="ads"],
    [class*="popup"],
    [class*="sticky"],
    [class*="sponsor"]

    {
      display: none !important;
      visibility: hidden !important;
      opacity: 0 !important;
      height: 0 !important;
      width: 0 !important;
      max-height: 0 !important;
      min-height: 0 !important;
      overflow: hidden !important;
      pointer-events: none !important;
    }

    body{
      margin-top:0 !important;
      padding-top:0 !important;
    }

  `;

  document.head.appendChild(style);

  // REMOVE FUNCTION
  function cleanPage() {

    const selectors = [

      'header',
      'footer',
      'nav',
      'aside',
      'iframe',

      '.header',
      '.footer',
      '.navbar',

      '.ads',
      '.ad',
      '.adsbygoogle',
      '.advertisement',
      '.popup',
      '.sponsored',

      '[id*="ad"]',
      '[class*="ad"]',
      '[class*="ads"]',
      '[class*="popup"]',
      '[class*="sticky"]'

    ];

    selectors.forEach(selector => {

      document.querySelectorAll(selector)
      .forEach(el => el.remove());

    });

    // REMOVE FIXED ELEMENTS
    document.querySelectorAll("*").forEach(el => {

      const style = getComputedStyle(el);

      if (
        style.position === "fixed" ||
        style.position === "sticky"
      ) {

        if (
          el.offsetHeight < 400
        ) {
          el.remove();
        }
      }
    });

  }

  // RUN MANY TIMES
  cleanPage();

  setInterval(() => {
    cleanPage();
  }, 500);

})();

""");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),

      body: Stack(
        children: [
          WebViewWidget(controller: controller),

          if (isLoading)
            Center(
              child: TweenAnimationBuilder(
                tween: Tween<double>(begin: 0, end: 1),
                duration: Duration(seconds: 1),
                builder: (_, double value, child) {
                  return Transform.rotate(
                    angle: value * 6.3,
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
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
    );
  }
}
