import 'package:flutter/material.dart';

class FTTextField extends StatelessWidget {
  const FTTextField({
    super.key,
    required this.onChanged,
    required this.hintText,
    required this.errorText,
    required this.prefixIcon,
    required this.keyboardType,
  });

  final Widget? prefixIcon;
  final ValueChanged<String>? onChanged;
  final String hintText;
  final TextInputType keyboardType;
  final String? errorText;

  // @override
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      autofocus: true,
      // obscureText: false,
      keyboardType: keyboardType,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        border: InputBorder.none,
        prefixIcon: prefixIcon,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: const BorderSide(color: Colors.red),
        ),
        fillColor: Colors.grey.shade100,
        filled: true,
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey[500]),
        errorText: errorText,
      ),
    );
  }
}
