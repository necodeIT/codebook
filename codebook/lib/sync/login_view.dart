import 'package:codebook/main.dart';
import 'package:codebook/sync/sync.dart';
import 'package:flutter/material.dart';
import 'package:nekolib.ui/ui.dart';
import 'package:webview_windows/webview_windows.dart';
import 'package:desktop_window/desktop_window.dart';

class GitHubLoginPrompt extends StatefulWidget {
  const GitHubLoginPrompt({Key? key, required this.onSuccess, required this.finalRedirectUrl, required this.onFailed, required this.validateSuccess, required this.authUrl}) : super(key: key);

  final Function(String) onSuccess;
  final Function() onFailed;
  final Function(String) validateSuccess;
  final String finalRedirectUrl;
  final String authUrl;

  @override
  State<GitHubLoginPrompt> createState() => _GitHubLoginPromptState();
}

class _GitHubLoginPromptState extends State<GitHubLoginPrompt> {
  final WebviewController _controller = WebviewController();

  _initWebView() async {
    // Size size = await DesktopWindow.getWindowSize();
    // await DesktopWindow.setMinWindowSize(size);
    // await DesktopWindow.setMaxWindowSize(size);

    if (_controller.value.isInitialized) return;
    await _controller.initialize();
    _controller.loadUrl(widget.authUrl);

    _controller.url.listen((url) {
      if (url != widget.authUrl || !url.startsWith(widget.finalRedirectUrl)) {
        _controller.loadUrl(widget.authUrl);
        return;
      }

      // ignore: void_checks
      if (widget.validateSuccess(url)) return widget.onSuccess(url);

      widget.onFailed();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: NcThemes.current.secondaryColor,
      child: _controller.value.isInitialized
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
            ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    print("Dispose");
  }
}
