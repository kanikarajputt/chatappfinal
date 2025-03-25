import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {                                            //custom class created to manage authentication functionality
  //instance of auth n firebase
  final FirebaseAuth _auth = FirebaseAuth.instance;       // (1)
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //get current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }


  //sign in
  Future<UserCredential> signInWithEmailPassword( String email, password) async {       //this bro does the actual work     (2)

  
    try {
      //sign user in
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(          // 3
        email: email,
         password: password,
         );
          //save user info if doesnt already exist
         _firestore.collection("Users").doc(userCredential.user!.uid).set(
          {
            'uid': userCredential.user!.uid,
            'email': email,
          },

         );
         return userCredential;

    } on FirebaseAuthException catch (e) {         //4
      throw Exception(e.code);
    }
  }


  //sign up
  Future<UserCredential> signUpWithEmailAndPassword(String email, password) async {
    try {
      // create user
      UserCredential userCredential =
       await _auth.createUserWithEmailAndPassword(
        email: email,
         password: password,
         );

         //save user info in sep doc
         _firestore.collection("Users").doc(userCredential.user!.uid).set(
          {
            'uid': userCredential.user!.uid,
            'email': email,
          },

         );


         return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }


  //sign out
  Future<void> signOut() async {
    return await _auth.signOut(); 
  }


  //errors if any







}




/*   (1)
  FirebaseAuth.instance connects our app to Firebase's authentication service
_auth is the name we give to this connection, so we can use it later in the code

(2)
Future<UserCredential>: This means the function will take some time (it’s async) and then return a UserCredential, which contains information about the user.
email and password: These are the details the user enters when they try to log in

3 (pura func)
await: This tells the app, “Wait until Firebase finishes checking the email and password.”
signInWithEmailAndPassword: This function sends the user’s email and password to Firebase.
If the email and password are correct, Firebase signs in the user and returns a UserCredential, which holds information about the user (like their email).

4
If something goes wrong (like the email isn’t registered or the password is wrong), Firebase gives an error.
FirebaseAuthException is a special error type that tells you what went wrong (e.g., wrong-password, user-not-found).
The code throws the error back so the app can show a helpful message to the user.

*/