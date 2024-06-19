import 'package:flutter/material.dart';
import 'package:youapp/util/app_color.dart';

class AppDropDownFiled extends StatefulWidget {
  final String label;
  final String hint;
  final Function(String changeValue) returnChangeValue;
  final BuildContext context;
  const AppDropDownFiled(
      {super.key,
      required this.label,
      required this.hint,
      required this.context,
      required this.returnChangeValue});

  @override
  State<AppDropDownFiled> createState() => _AppDropDownFiledState();
}

class _AppDropDownFiledState extends State<AppDropDownFiled> {
  String dropDownValue = "Male";

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
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                widget.label,
                style: TextStyle(
                    fontSize: 16,
                    color: YouAppColor.whiteColor.withOpacity(0.33)),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: dropDownValue,
                  dropdownColor: Colors.grey[800],
                  hint: Text(
                    widget.hint,
                    style: TextStyle(
                        color: YouAppColor.whiteColor.withOpacity(0.3)),
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: 'Male',
                      child: Text(
                        'Male',
                        style: TextStyle(color: YouAppColor.whiteColor),
                      ),
                    ),
                    DropdownMenuItem(
                      value: 'Female',
                      child: Text(
                        'Female',
                        style: TextStyle(color: YouAppColor.whiteColor),
                      ),
                    ),
                    DropdownMenuItem(
                      value: 'Other',
                      child: Text(
                        'Other',
                        style: TextStyle(color: YouAppColor.whiteColor),
                      ),
                    ),
                  ],
                  onChanged: (value) {
                    // Handle change
                    setState(() {
                      dropDownValue = value.toString();
                      widget.returnChangeValue(value.toString());
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
