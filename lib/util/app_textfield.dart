import 'package:flutter/material.dart';
import 'package:youapp/util/app_color.dart';

class AppTextField extends StatefulWidget {
  final String label;
  final String hint;
  final Function(String string) callBackController;
  const AppTextField(
      {super.key,
      required this.label,
      required this.hint,
      required this.callBackController});

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Text(
                widget.label,
                style: TextStyle(
                    fontSize: 16,
                    color: YouAppColor.whiteColor.withOpacity(0.33)),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: TextField(
              controller: textEditingController,
              onChanged: (value) {
                widget.callBackController(value);
              },
              style: const TextStyle(color: YouAppColor.whiteColor),
              decoration: InputDecoration(
                hintText: widget.hint,
                isDense: true,
                hintStyle:
                    TextStyle(color: YouAppColor.whiteColor.withOpacity(0.3)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[800],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
