import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../models/article_model.dart';

class CustomInAppBrowser extends StatefulWidget {
  final ArticleModel article;

  const CustomInAppBrowser({Key? key, required this.article}) : super(key: key);

  @override
  State<CustomInAppBrowser> createState() => _CustomInAppBrowserState();
}

class _CustomInAppBrowserState extends State<CustomInAppBrowser> {
  final GlobalKey webViewKey = GlobalKey();

  String url = '';
  String title = '';
  double progress = 0;
  bool? isSecure;
  InAppWebViewController? webViewController;

  @override
  void initState() {
    super.initState();
    url = widget.article.url;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            FutureBuilder<bool>(
              future: webViewController?.canGoBack() ?? Future.value(false),
              builder: (context, snapshot) {
                final canGoBack = snapshot.hasData ? snapshot.data! : false;
                return IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: !canGoBack
                      ? null
                      : () {
                          webViewController?.goBack();
                        },
                );
              },
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    overflow: TextOverflow.fade,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (isSecure != null)
                        Icon(
                          isSecure == true ? Icons.lock : Icons.lock_open,
                          color: isSecure == true ? Colors.green : Colors.red,
                          size: 12,
                        ),
                      const SizedBox(
                        width: 5,
                      ),
                      Flexible(
                        child: Text(
                          url,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white70,
                          ),
                          overflow: TextOverflow.fade,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            FutureBuilder<bool>(
              future: webViewController?.canGoForward() ?? Future.value(false),
              builder: (context, snapshot) {
                final canGoForward = snapshot.hasData ? snapshot.data! : false;
                return IconButton(
                  icon: const Icon(Icons.arrow_forward_ios),
                  onPressed: !canGoForward
                      ? null
                      : () {
                          webViewController?.goForward();
                        },
                );
              },
            )
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Stack(
              children: [
                InAppWebView(
                  key: webViewKey,
                  initialUrlRequest:
                      URLRequest(url: WebUri(widget.article.url)),
                  initialSettings: InAppWebViewSettings(
                    transparentBackground: true,
                    safeBrowsingEnabled: true,
                    isFraudulentWebsiteWarningEnabled: true,
                  ),
                  onWebViewCreated: (controller) async {
                    webViewController = controller;
                    if (!kIsWeb &&
                        defaultTargetPlatform == TargetPlatform.android) {
                      await controller.startSafeBrowsing();
                    }
                  },
                  onLoadStart: (controller, url) {
                    if (url != null) {
                      setState(() {
                        this.url = url.toString();
                        isSecure = urlIsSecure(url);
                      });
                    }
                  },
                  onLoadStop: (controller, url) async {
                    if (url != null) {
                      setState(() {
                        this.url = url.toString();
                      });
                    }

                    final sslCertificate = await controller.getCertificate();
                    setState(() {
                      isSecure = sslCertificate != null ||
                          (url != null && urlIsSecure(url));
                    });
                  },
                  onUpdateVisitedHistory: (controller, url, isReload) {
                    if (url != null) {
                      setState(() {
                        this.url = url.toString();
                      });
                    }
                  },
                  onTitleChanged: (controller, title) {
                    if (title != null) {
                      setState(() {
                        this.title = title;
                      });
                    }
                  },
                  onProgressChanged: (controller, progress) {
                    setState(() {
                      this.progress = progress / 100;
                    });
                  },
                  shouldOverrideUrlLoading:
                      (controller, navigationAction) async {
                    final url = navigationAction.request.url;
                    if (navigationAction.isForMainFrame &&
                        url != null &&
                        ![
                          'http',
                          'https',
                          'file',
                          'chrome',
                          'data',
                          'javascript',
                          'about'
                        ].contains(url.scheme)) {
                      if (await canLaunchUrl(url)) {
                        launchUrl(url);
                        return NavigationActionPolicy.CANCEL;
                      }
                    }
                    return NavigationActionPolicy.ALLOW;
                  },
                ),
                if (progress < 1.0)
                  LinearProgressIndicator(value: progress)
                else
                  Container(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.share),
              onPressed: () {
                Share.share(url, subject: title);
              },
            ),
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                webViewController?.reload();
              },
            ),
            PopupMenuButton<int>(
              onSelected: (item) => handleClick(item),
              itemBuilder: (context) => [
                PopupMenuItem<int>(
                  enabled: false,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            "images/Logo.png",
                            height: ScreenUtil().setHeight(100),
                            width: ScreenUtil().setWidth(100),
                          ),
                          const Expanded(
                            child: Center(
                              child: Text(
                                'Other options',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Divider(),
                    ],
                  ),
                ),
                const PopupMenuItem<int>(
                  value: 0,
                  child: Row(
                    children: [
                      Icon(Icons.open_in_browser),
                      SizedBox(
                        width: 5,
                      ),
                      Text('Open in the Browser'),
                    ],
                  ),
                ),
                const PopupMenuItem<int>(
                  value: 1,
                  child: Row(
                    children: [
                      Icon(Icons.clear_all),
                      SizedBox(
                        width: 5,
                      ),
                      Text('Clear your browsing data'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void handleClick(int item) async {
    switch (item) {
      case 0:
        await InAppBrowser.openWithSystemBrowser(url: WebUri(url));
        break;
      case 1:
        await webViewController?.clearHistory();
        if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
          await webViewController?.clearHistory();
        }
        setState(() {});
        break;
    }
  }

  static bool urlIsSecure(Uri url) {
    return (url.scheme == "https") || isLocalizedContent(url);
  }

  static bool isLocalizedContent(Uri url) {
    return (url.scheme == "file" ||
        url.scheme == "chrome" ||
        url.scheme == "data" ||
        url.scheme == "javascript" ||
        url.scheme == "about");
  }
}
