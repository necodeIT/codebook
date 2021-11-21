import 'package:codebook/sync/sync.dart';
import 'package:flutter/material.dart';
import 'package:nekolib.ui/ui.dart';
import 'package:webview_windows/webview_windows.dart';

class GitHubLoginPrompt extends StatefulWidget {
  const GitHubLoginPrompt({Key? key, required this.onSuccess, required this.finalRedirectUrl, required this.onFailed, required this.validateSuccess}) : super(key: key);

  final Function(String) onSuccess;
  final Function() onFailed;
  final Function(String) validateSuccess;
  final String finalRedirectUrl;

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
      if (!event.startsWith(widget.finalRedirectUrl)) return;

      if (widget.validateSuccess(event)) {
        widget.onSuccess(event);
      } else {
        widget.onFailed();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
  }
}
