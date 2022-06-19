import 'package:flutter/material.dart';

class CustomTextFeild extends StatelessWidget {
  const CustomTextFeild({
    Key? key,
    this.textFieldController,
    required this.hintText,
    this.iconWidget,
    this.keyboardType,
    this.isObscure,
    this.validator,
  }) : super(key: key);

  final TextEditingController? textFieldController;
  final String hintText;
  final Widget? iconWidget;
  final TextInputType? keyboardType;
  final bool? isObscure;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textFieldController,
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        contentPadding: const EdgeInsets.all(12),
        fillColor: Colors.grey[800],
        filled: true,
        suffixIcon: iconWidget,
      ),
      keyboardType: keyboardType,
      obscureText: isObscure ?? false,
      validator: validator ??
          (value) {
            if (value == null) {
              return 'vlaue should not be null';
            }
            return null;
          },
    );
  }
}
