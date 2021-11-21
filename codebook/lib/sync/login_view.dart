import 'package:codebook/sync/sync.dart';
import 'package:flutter/material.dart';
import 'package:nekolib.ui/ui.dart';
import 'package:webview_windows/webview_windows.dart';

class GitHubLoginPrompt extends StatefulWidget {
  const GitHubLoginPrompt({Key? key, required this.onSuccess, required this.sucessKeyWord}) : super(key: key);

  final Function(String) onSuccess;
  final String sucessKeyWord;

  @override
  State<GitHubLoginPrompt> createState() => _GitHubLoginPromptState();
}

class _GitHubLoginPromptState extends State<GitHubLoginPrompt> {
  final WebviewController _controller = WebviewController();

  _initWebView() async {
    if (_controller.value.isInitialized) return;
    await _controller.initialize();
    _controller.loadUrl(Sync.authUrl);

    _controller.url.listen((event) {
      if (event.contains(widget.sucessKeyWord)) widget.onSuccess(event);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return _controller.value.isInitialized
          ? Webview(_controller)
          : FutureBuilder(
              future: _initWebView(),
              builder: (context, state) {
                return state.connectionState == ConnectionState.done
                    ? Webview(_controller)
                    : Center(
                        child: CircularProgressIndicator(
                          color: NcThemes.current.accentColor,
                        ),
                      );
              },
            );
    });
  }
}
