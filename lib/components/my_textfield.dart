import 'package:flutter/material.dart';

class MyTextfield extends StatelessWidget {
  final String hintText;                          //By passing hintText and obscureText as parameters when creating a MyTextfield instance, we can reuse the widget in different contexts with varying behavior or appearance
  final bool obscureText;                         //final ensures that these properties are immutable after the widget is created
  final TextEditingController controller;
  final FocusNode? focusNode;

  const MyTextfield({
    super.key,
    required this.hintText,
    required this.obscureText,
    required this.controller,
    required this.focusNode,
    });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        obscureText: obscureText,
        controller: controller,
        focusNode: focusNode,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).colorScheme.tertiary),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
          ),
          fillColor: Theme.of(context).colorScheme.secondary,
          filled: true,            //color inside textfield box
          hintText: hintText,
          hintStyle: TextStyle(color:Theme.of(context).colorScheme.primary)
        ),
      ),
    );
  }
}