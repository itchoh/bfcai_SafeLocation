import 'package:flutter/material.dart';
class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({super.key, required this.hintText, this.controller, this.validator});
  final String hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
            fontSize: 14,
            color: Colors.grey
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide(
                color: Color(0xff5F33E1)
            )
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
        ) ,
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                color:Colors.red )
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
          ),
          borderRadius: BorderRadius.circular(10)
        )
      ),
    );
  }
}
