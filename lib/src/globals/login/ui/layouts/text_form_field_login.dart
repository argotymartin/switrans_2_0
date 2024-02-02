import 'package:flutter/material.dart';

class TextFormFieldLogin extends StatefulWidget {
  final IconData icon;
  final String placeHoder;
  final TextEditingController textController;
  final TextInputType textInputType;
  final bool isPassword;
  final Function(String) onFieldSubmitted;
  final String? Function(String?) onValidator;
  const TextFormFieldLogin({
    Key? key,
    required this.icon,
    required this.placeHoder,
    required this.textController,
    required this.onFieldSubmitted,
    required this.onValidator,
    this.textInputType = TextInputType.text,
    this.isPassword = false,
  }) : super(key: key);

  @override
  State<TextFormFieldLogin> createState() => _TextFormFieldLoginState();
}

class _TextFormFieldLoginState extends State<TextFormFieldLogin> {
  bool isObscured = true;

  @override
  Widget build(BuildContext context) {
    final colorWhite = Colors.white.withOpacity(0.6);
    return TextFormField(
      style: const TextStyle(color: Colors.white),
      validator: widget.onValidator,
      onFieldSubmitted: widget.onFieldSubmitted,
      controller: widget.textController,
      obscureText: widget.isPassword && isObscured,
      autocorrect: false,
      keyboardType: widget.textInputType,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 0.3),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 2),
        ),
        hintText: widget.placeHoder,
        labelText: widget.placeHoder,
        prefixIcon: Icon(widget.icon, color: colorWhite),
        labelStyle: TextStyle(color: colorWhite),
        hintStyle: TextStyle(color: colorWhite),
        errorStyle: TextStyle(color: Colors.red.shade200),
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: isObscured ? Icon(Icons.visibility, color: colorWhite) : Icon(Icons.visibility_off_outlined, color: colorWhite),
                onPressed: () => setState(() => isObscured = !isObscured),
              )
            : const SizedBox(width: 1, height: 1),
      ),
    );
  }
}
