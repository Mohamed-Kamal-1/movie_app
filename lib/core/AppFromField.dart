import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors/app_color.dart';

typedef Validator = String? Function(String? text);
typedef OnChange = void Function(String? text);

class AppFormField extends StatefulWidget {
  final String label;
  final OnChange? onChange;
  final Widget? icon;
  final TextInputType keyboardType;
  final bool isPassword;
  final Validator? validator;
  final TextEditingController? controller;
  final int lines;
  final FocusNode? focusNode;

  final TextInputAction? textInputAction;

  const AppFormField({
    required this.label,
    this.icon,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.validator,
    this.controller,
    this.lines = 1,
    super.key,
    this.textInputAction = TextInputAction.next,
    this.onChange,
    this.focusNode
  });

  @override
  State<AppFormField> createState() => _AppFormFieldState();
}

class _AppFormFieldState extends State<AppFormField> {
  late bool secureText;

  @override
  void initState() {
    secureText = widget.isPassword;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        focusNode: widget.focusNode,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onChanged: widget.onChange,
        textInputAction: widget.textInputAction,
        controller: widget.controller,
        maxLines: widget.lines,
        style: GoogleFonts.inter(fontSize: 16, color: AppColor.white),
        validator: widget.validator,
        obscureText: widget.isPassword && secureText,
        keyboardType: widget.keyboardType,
        decoration: InputDecoration(
          labelText: widget.label,
          labelStyle: GoogleFonts.inter(fontSize: 16, color: AppColor.white),
          filled: true,
          fillColor: AppColor.gray,
          prefixIcon: widget.icon != null
              ? Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                  child: widget.icon,
                )
              : null,
          suffixIcon: widget.isPassword
              ? InkWell(
                  onTap: () => setState(() => secureText = !secureText),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Icon(
                      secureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                      color: AppColor.white,
                    ),
                  ),
                )
              : null,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: AppColor.white, width: 1),
          ),
        ),
      ),
    );
  }
}
