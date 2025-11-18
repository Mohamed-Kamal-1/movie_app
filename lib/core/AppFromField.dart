import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors/app_color.dart';

typedef Validator = String? Function(String? text);

class AppFormField extends StatefulWidget {
  String label;
  final Widget? icon;
  TextInputType keyboardType;
  bool isPassword;
  Validator? validator;
  TextEditingController? controller;
  int lines;

  AppFormField({
    required this.label,
    this.icon,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.validator,
    this.controller,
    this.lines = 1,
    super.key,
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
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
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
