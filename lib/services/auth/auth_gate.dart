import 'package:chat_app/services/auth/login_or_register.dart';
import 'package:chat_app/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(),  //listenin to authgate changes
       builder: (context, snapshot){
        //user logged in

        if (snapshot.hasData){
          return  HomePage();
        }

        //user NOT logged in
        else {
          return const LoginOrRegister();
        }
       },
       ),
    );
  }
}