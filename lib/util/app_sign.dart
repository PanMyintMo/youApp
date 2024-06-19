import 'package:flutter/material.dart';
import 'package:youapp/util/app_color.dart';

class AppSign extends StatefulWidget {
  final String label;
  final String text;
  const AppSign({super.key, required this.label, required this.text});

  @override
  State<AppSign> createState() => _AppSignState();
}

class _AppSignState extends State<AppSign> {
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
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      width: 1.0,
                      color: YouAppColor.whiteColor.withOpacity(0.22))),
              child: Padding(
                padding: const EdgeInsets.only(right: 16.0, top: 16.0),
                child: Text(
                  textAlign: TextAlign.end,
                  widget.text.isEmpty ? "--" : widget.text,
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: YouAppColor.whiteColor.withOpacity(0.3)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
