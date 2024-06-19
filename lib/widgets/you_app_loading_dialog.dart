import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:youapp/util/app_color.dart';

class YouAppLoadingDialog extends StatefulWidget {
  final LoadingDialogController controller;
  final Function onLoading;
  const YouAppLoadingDialog({
    super.key,
    required this.controller,
    required this.onLoading,
  });

  @override
  YouAppLoadingDialogState createState() => YouAppLoadingDialogState();
}

class YouAppLoadingDialogState extends State<YouAppLoadingDialog> {
  ProgressStatus status = ProgressStatus.loading;
  String errorMessage = "";
  String errorTitle = "";
  String title = "";

  @override
  void initState() {
    errorTitle = "";
    widget.controller._addShowErrorListener((String message, [String? title]) {
      setState(() {
        status = ProgressStatus.failed;
        errorMessage = message;
        errorTitle =
            title ?? 'Default Title'; // Provide a default title if null
      });
    });
    widget.onLoading();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      content:
          status == ProgressStatus.loading ? _loadingWidget() : _errorWidget(),
    );
  }

  Widget _loadingWidget() {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  width: 30,
                  height: 30,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(YouAppColor.mainColor),
                  ),
                ),
                SizedBox(width: 12),
                Text('Loading...'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _errorWidget() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                errorTitle,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Text(errorMessage),
            ],
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 60,
              child: MaterialButton(
                padding: const EdgeInsets.all(0),
                onPressed: () {
                  Modular.to.pop();
                },
                child: const Text(
                  'OK',
                  style: TextStyle(color: YouAppColor.mainColor),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

enum ProgressStatus {
  loading,
  success,
  failed,
}

class LoadingDialogController {
  late Function(String title, String message) _onFailed;

  void _addShowErrorListener(Function(String title, String message) onFailed) {
    _onFailed = onFailed;
  }

  void showMessage(String msg, [String? title]) {
    _onFailed.call(title ?? 'Default Title', msg);
  }
}
