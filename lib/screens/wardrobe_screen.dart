import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WardrobeScreen extends StatefulWidget {
  const WardrobeScreen({super.key});

  @override
  State<WardrobeScreen> createState() => _WardrobeScreenState();
}

class _WardrobeScreenState extends State<WardrobeScreen> {
  late final WebViewController _ctrl;
  double _progress = 0;

  static const _rpmUrl =
      'https://readyplayer.me/avatar?frameApi=1'; // simple hosted creator

  @override
  void initState() {
    super.initState();
    _ctrl = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onProgress: (p) => setState(() => _progress = p / 100),
      ))
      ..loadRequest(Uri.parse(_rpmUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Wardrobe')),
      body: Stack(
        children: [
          WebViewWidget(controller: _ctrl),
          if (_progress < 1)
            LinearProgressIndicator(value: _progress, minHeight: 2),
        ],
      ),
    );
  }
}
