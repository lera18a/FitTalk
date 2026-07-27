// import 'package:flutter/material.dart';

// class FormTextField extends StatelessWidget {
//   const FormTextField({
//     super.key,
//     required this.controller,
//     required this.label,
//     this.hintText,
//     this.validator,
//     this.prefixIcon,
//     this.onChanged,
//   });

//   final TextEditingController controller;
//   final String label;
//   final String? hintText;
//   final String? Function(String?)? validator;
//   final Widget? prefixIcon;
//   final String? errorText;
//   final void Function(String)? onChanged;

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       controller: controller,
//       onChanged: onChanged,
//       validator: validator,
//       textInputAction: TextInputAction.next,
//       decoration: InputDecoration(
//         labelText: label,
//         hintText: hintText,
//         prefixIcon: prefixIcon,
//         border: const OutlineInputBorder(),
//       ),
//     );
//   }
// }
