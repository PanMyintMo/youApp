import 'package:flutter/material.dart';
import 'package:youapp/extension/birth_extension.dart';
import 'package:youapp/util/app_color.dart';

class AppDateTextField extends StatefulWidget {
  final String label;
  final String hint;
  final Function(String string) callBackController;
  final Function(String string) horoscopeSign;
  final Function(String string) zodiacSign;
  const AppDateTextField(
      {super.key,
      required this.label,
      required this.hint,
      required this.callBackController,
      required this.horoscopeSign,
      required this.zodiacSign});

  @override
  State<AppDateTextField> createState() => _AppDateTextFieldState();
}

class _AppDateTextFieldState extends State<AppDateTextField> {
  TextEditingController textEditingController = TextEditingController();
  String horoscopeSign = "";
  String zodizcSign = "";

  Future<void> selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != DateTime.now()) {
      setState(() {
        textEditingController.text = "${picked.toLocal()}".split(' ')[0];
        widget.callBackController("${picked.toLocal()}".split(' ')[0]);
        widget.horoscopeSign(picked.getHoroscopeSign());
        widget.zodiacSign(picked.getZodiacSign());
      });
    }
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
              onTap: () {
                selectDate();
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
