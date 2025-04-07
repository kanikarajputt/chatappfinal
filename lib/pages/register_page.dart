import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/components/my_button.dart';
import 'package:chat_app/components/my_textfield.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {

  //email n pw text controller
  final TextEditingController _emailcontroller = TextEditingController(); //manage state of textfield, handle data that user input
  final TextEditingController _pwcontroller = TextEditingController();
  final TextEditingController _confirmpwcontroller = TextEditingController();

  //tap to go to login page
  final void Function()? onTap;

  RegisterPage({
    super.key,
    required this.onTap,
  });

  //register method
  void register(BuildContext context){
    print("register button hu mai");
    //get auth service
    final _auth = AuthService();

    //pass match - create user 
    if (_pwcontroller.text == _confirmpwcontroller.text){
      try{
        _auth.signUpWithEmailAndPassword(
          _emailcontroller.text,
          _pwcontroller.text,
        );
      } catch (e){
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(e.toString()),
          ),
        );
      }
    }

    //pass dont match - show error - user need to fix
    else{
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text("pass dont match"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Theme.of(context).colorScheme.surface,    // this line access surface color defined in ThemeData  
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              const SizedBox(height: 80),

              //R E G I S T E R   H E A D I N G
              Text(
                "Register",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),

              const SizedBox(height: 30),

              //L O G O
              Icon(                                                //icon is widget
                Icons.message,                                    //icons.message is const that represent msg icon
                size: 60,
                color:Theme.of(context).colorScheme.primary      //using the primary color we defined
              ), 

              const SizedBox(height:30),                       //add vertical spacing

              //W E L C O M E   M S G
              Text(
                "Your account awaits you!",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height:25),

              //E M A I L     L A B E L
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Email",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              const SizedBox(height: 8),

              //E M A I L     T E X T     F I E L D
              MyTextfield(                                           //using from components folder
                hintText: "Email",
                obscureText: false,
                controller: _emailcontroller, focusNode: null,
              ), 

              const SizedBox(height:20),

              //P W     L A B E L
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Password",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              const SizedBox(height: 8),

              //P W    T E X T     F I E L D
              MyTextfield(                                           //using from components folder
                hintText: "Password",
                obscureText: true, //so that pw is hidden 
                controller: _pwcontroller, focusNode: null,
              ),

              const SizedBox(height:20),

              //CONFIRM P W    L A B E L
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Confirm Password",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              const SizedBox(height: 8),

              //CONFIRM PASS
              MyTextfield(                                           //using from components folder
                hintText: "Confirm Password",
                obscureText: true, //so that pw is hidden 
                controller: _confirmpwcontroller, focusNode: null,
              ),

              const SizedBox(height: 30),

              //register button
              MyButton(
                text: "Register",
                onTap: () => register(context),
                height: 45,
                width: 200,
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),

              const SizedBox(height: 25),

              //register now
              Row(                                                     //2 text widget in row
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "already have an account?",
                    style: TextStyle(color: Theme.of(context).colorScheme.primary),
                  ), 
                  SizedBox(width: 8),
                  GestureDetector(
                    onTap: onTap,
                    child: Text(
                      "login now :)",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,                
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

            ],
          ),
        ),
      ),
    );
  }
}
