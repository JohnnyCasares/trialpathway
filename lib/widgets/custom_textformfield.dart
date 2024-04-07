import 'package:flutter/material.dart';
class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    this.hintText,
    this.controller,
    this.helperText,
    this.validator,
    this.textAlign = TextAlign.start,
    this.isPassword = false, this.keyboardType, this.onChanged,
  });
  final String? hintText;
  final TextEditingController? controller;
  final String? helperText;
  final TextAlign textAlign;
  final String? Function(String?)? validator;
  final bool isPassword;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}
class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool visibility;
  IconData visibilityIcon = Icons.visibility;
  @override
  void initState() {
    visibility = widget.isPassword;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        keyboardType: widget.keyboardType,
        textAlign: widget.textAlign,
        validator: widget.validator ?? defaultValidator,
        controller: widget.controller,
        obscureText: visibility,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
            suffixIcon: widget.isPassword
                ? IconButton(
              onPressed: visibilityToggle,
              icon: Icon(visibilityIcon),
            )
                : null,
            helperMaxLines: 3,
            helperText: widget.helperText,
            label: widget.hintText!=null?Text(widget.hintText!):null,
            hintText: widget.hintText,
            border:
            OutlineInputBorder(borderRadius: BorderRadius.circular(16))),

      ),
    );
  }

  String? defaultValidator(value) {
    if (value == null || value.isEmpty) return 'Please fill this field';
    return null;
  }

  visibilityToggle() {
    if (visibility) {
      setState(() {
        visibility = false;
        visibilityIcon = Icons.visibility_off;
      });
    } else {
      setState(() {
        visibility = true;
        visibilityIcon = Icons.visibility;
      });
    }
  }
}