import 'package:flutter/material.dart';
import 'package:youapp/util/app_color.dart';
import 'package:youapp/util/youapp_text_style.dart';

TextFormField youAppTextFormField({
  required TextEditingController controller,
  required FocusNode focusNode,
  required String hintText,
  required TextInputType keyboardType,
  required FormFieldValidator<String>? validator,
  required void Function(String)? onFieldSubmitted,
  bool obscureText = false,
  Widget? suffixIcon,
}) {
  return TextFormField(
    controller: controller,
    focusNode: focusNode,
    validator: validator,
    cursorColor: YouAppColor.whiteColor,
    keyboardType: keyboardType,
    obscureText: obscureText,
    style: authTextStyle,
    textInputAction:
        onFieldSubmitted != null ? TextInputAction.done : TextInputAction.next,
    onFieldSubmitted: onFieldSubmitted,
    decoration: _getInputDec(
      hintText,
      suffixIcon: suffixIcon,
    ),
  );
}

InputDecoration _getInputDec(String label, {Widget? suffixIcon}) {
  return InputDecoration(
    hintText: label,
    suffixIcon: suffixIcon,
    fillColor: const Color.fromRGBO(255, 255, 255, 0.06),
    hintStyle: TextStyle(color: YouAppColor.whiteColor.withOpacity(0.4)),
    border: const OutlineInputBorder(
      borderSide: BorderSide(
        color: Color.fromRGBO(255, 255, 255, 0.06),
      ),
      borderRadius: BorderRadius.all(Radius.circular(9.0)),
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: Color.fromRGBO(255, 255, 255, 0.06),
      ),
      borderRadius: BorderRadius.all(Radius.circular(9.0)),
    ),
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: Color.fromRGBO(255, 255, 255, 0.06),
      ),
      borderRadius: BorderRadius.all(Radius.circular(9.0)),
    ),
  );
}

void fieldFocusChange(
    BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
  currentFocus.unfocus();
  FocusScope.of(context).requestFocus(nextFocus);
}
