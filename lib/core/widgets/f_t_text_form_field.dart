import 'package:flutter/material.dart';

class FTTextFormField extends StatefulWidget {
  const FTTextFormField({
    super.key,
    required this.onChanged,
    required this.hintText,
    required this.errorText,
    required this.prefixIcon,
    this.keyboardType,
    this.obscureText = false,
    this.isPasswordField = false,
    this.label,
  });

  final bool isPasswordField;
  final Widget? prefixIcon;
  final ValueChanged<String>? onChanged;
  final String hintText;
  final TextInputType? keyboardType;
  final String? errorText;
  final bool obscureText;
  final String? label;

  @override
  State<FTTextFormField> createState() => _FTTextFormFieldState();
}

class _FTTextFormFieldState extends State<FTTextFormField> {
  // @override
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: widget.onChanged,
      // autofocus: true,
      obscureText: widget.isPasswordField ? _obscure : false,
      keyboardType: widget.keyboardType,

      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        suffixIcon: widget.isPasswordField
            ? IconButton(
                icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility),
                onPressed: () {
                  setState(() => _obscure = !_obscure);
                },
              )
            : null,
        border: InputBorder.none,
        prefixIcon: widget.prefixIcon,
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
        hintText: widget.hintText,
        hintStyle: TextStyle(color: Colors.grey[500]),
        errorText: widget.errorText,
        labelText: widget.label,
      ),
    );
  }
}
