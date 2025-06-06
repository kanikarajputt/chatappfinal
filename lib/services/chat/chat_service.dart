import 'package:chat_app/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {
   
   //get instance of firebase
   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
   final FirebaseAuth _auth = FirebaseAuth.instance;


   //get user stream
   Stream<List<Map<String,dynamic>>>getUsersStream(){
    return _firestore.collection("Users").snapshots().map((snapshot){
      return snapshot.docs.map((doc){
        //go through individual user
        final user = doc.data();

        //return user
        return user;

      }).toList();
    });

   }

   //send message
   Future<void> sendMessage(String receiverID, message) async {
    //get current user info 
    final String currentUserID = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();


    // create new msg
    Message newMessage = Message( 
      senderID: currentUserID,
      senderEmail: currentUserEmail,
      receiverID: receiverID,
      message: message,
      timestamp: timestamp,

    );

    //construct chat room ID for 2 user (sorted to ensure uniqueness)
    List<String> ids = [currentUserID, receiverID];
    ids.sort(); //sort ids (ensure chatroomID is same for 2 ppl)
    String chatroomID = ids.join('_');

    //add new message to database
    await _firestore
            .collection("chat_rooms")
            .doc(chatroomID)
            .collection("messages")
            .add(newMessage.toMap());

   }


   // get message
   Stream<QuerySnapshot> getMessages(String userID, otherUserID) {
    //const chatroom id for 2 user
    List<String> ids = [userID, otherUserID];
    ids.sort();
    String chatroomID = ids.join('_');

    return _firestore
        .collection("chat_rooms")
        .doc(chatroomID)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
       
   }
}