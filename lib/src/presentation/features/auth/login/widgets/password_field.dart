import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({super.key, required this.controller});
  final TextEditingController controller;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  final ValueNotifier<bool> obsecureText = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: obsecureText,
      builder: (context, value, child) {
        return TextFormField(
          controller: widget.controller,
          obscureText: obsecureText.value,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: Icon(
                obsecureText.value ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () {
                obsecureText.value = !obsecureText.value;
              },
            ),
            border: OutlineInputBorder(),
            hintText: 'Password',
          ),
        );
      },
    );
  }
}
