import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/components/my_button.dart';
import 'package:chat_app/components/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/material/theme.dart';

class LoginPage extends StatelessWidget {

  //email n pw text controller
  final TextEditingController _emailcontroller = TextEditingController(); //manage state of textfield, handle data that user input
  final TextEditingController _pwcontroller = TextEditingController();

  //ontap func - to go register page
  final void Function()? onTap;


   LoginPage({
    super.key,
   required this.onTap,});

   //login function
   void login(BuildContext context)async{
    //auth service
    final authService = AuthService();

    //try Login
    try {
      await authService.signInWithEmailPassword(_emailcontroller.text, _pwcontroller.text,
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
    return  Scaffold(

      /*here due to const Scaffold, Theme.of(context) was giving error 
      so revomed const as
      const - compile time constant
      but Theme.of(context) - depends on runtime state of app 
      */

      backgroundColor: Theme.of(context).colorScheme.surface,    // this line access surface color defined in ThemeData  
      body:  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            //L O G O
            Icon(                                                //icon is widget
              Icons.message,                                    //icons.message is const that represent msg icon
              size: 60,
              color:Theme.of(context).colorScheme.primary      //using the primary color we defined
              ), 

              const SizedBox(height:50),                       //add vertical spacing
        
        
            //W E L C O M E   B A C K   M S G
            Text("Guess who's back to spice up the chat?",
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 16,

            ),
            ),

            const SizedBox(height:25),

        
        
            //E M A I L     T E X T     F I E L D
            MyTextfield(                                           //using from components folder
             hintText: "Email",
             obscureText: false,
             controller: _emailcontroller, focusNode: null,

            ), 

            const SizedBox(height:10),

             //P W    T E X T     F I E L D
            MyTextfield(                                           //using from components folder
             hintText: "Password",
             obscureText: true, //so that pw is hidden 
             controller: _pwcontroller, focusNode: null,

            ),

            const SizedBox(height: 25),
        
            //login button
            MyButton(
              text: "Login",
              onTap: () => login(context),
            ),

             const SizedBox(height: 25),
        
            //register now
            Row(                                                     //2 text widget in row
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                "not a member?",
                style:
                   TextStyle(color: Theme.of(context).colorScheme.primary),
                ),

                SizedBox(width: 8),

                GestureDetector(
                  onTap: onTap,
                  child: Text(
                                "register now :)",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                   fontWeight: FontWeight.bold,
                                ),
                                ),
                ),
              ],
            ),
            



        
          ],),
      )

      
    );
  }
}