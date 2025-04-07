import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/components/my_button.dart';
import 'package:chat_app/components/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/material/theme.dart';

class LoginPage extends StatelessWidget {
  // email n pw text controller
  final TextEditingController _emailcontroller = TextEditingController(); // manage state of textfield, handle data that user input
  final TextEditingController _pwcontroller = TextEditingController();

  // ontap func - to go register page
  final void Function()? onTap;

  LoginPage({
    super.key,
    required this.onTap,
  });

  // login function
  void login(BuildContext context) async {
    // auth service
    final authService = AuthService();

    // try Login
    try {
      await authService.signInWithEmailPassword(
        _emailcontroller.text,
        _pwcontroller.text,
      );
      print("Login Successful");
    }

    // catch error
    catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(e.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* here due to const Scaffold, Theme.of(context) was giving error 
      so removed const as
      const - compile time constant
      but Theme.of(context) - depends on runtime state of app 
      */
      backgroundColor: Theme.of(context).colorScheme.surface, // this line access surface color defined in ThemeData  
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 100),

              // L O G I N   H E A D I N G
              Text(
                "Login",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),

              const SizedBox(height: 40),

              // U S E R N A M E   I C O N
              Icon(
                Icons.lock,
                size: 60,
                color: Theme.of(context).colorScheme.primary.withOpacity(0.8),
              ),

              const SizedBox(height: 40),

              // U S E R N A M E   L A B E L
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Username",
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // E M A I L     T E X T     F I E L D
              MyTextfield(
                hintText: "Enter your username",
                obscureText: false,
                controller: _emailcontroller,
                focusNode: null,
              ),

              const SizedBox(height: 20),

              // P A S S W O R D   L A B E L
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Password",
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // P W    T E X T     F I E L D
              MyTextfield(
                hintText: "Enter your password",
                obscureText: true, // so that pw is hidden 
                controller: _pwcontroller,
                focusNode: null,
              ),

              const SizedBox(height: 45), // smoother spacing

              // login button
              MyButton(
                text: "Login",
                onTap: () => login(context),
                height: 45,
                width: 200,
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),

              const SizedBox(height: 30),

              // register now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Not a member?",
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(width: 6),
                  GestureDetector(
                    onTap: onTap,
                    child: Text(
                      "Register now :)",
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
