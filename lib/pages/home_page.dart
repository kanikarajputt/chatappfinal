import 'package:chat_app/components/user_tile.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/components/my_drawer.dart';
import 'package:chat_app/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
   HomePage({super.key});

 //chat n auth service
 final ChatService _chatService = ChatService();
 final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        backgroundColor: Colors.transparent ,
        foregroundColor: Colors.grey,
        elevation: 0,
     
    ),
    drawer:const MyDrawer(),
    body: _buildUserList(),
    );
  }

  // build list of users except for current logged in user
  Widget _buildUserList() {
    return StreamBuilder(stream: _chatService.getUsersStream(),
     builder: (context, snapshot){
      //error
      if (snapshot.hasError) {
        return const Text("Error");
      }

      //loading..
      if (snapshot.connectionState == ConnectionState.waiting){
        return const Text("Loading");
      }


      //return list view
      return ListView(
        children: snapshot.data!
        .map<Widget>((userData) => _buildUserListItem(userData, context))
        .toList(),
        );
     },
      );

    
  }
  //build individual list tile for user
  Widget _buildUserListItem(
    Map<String, dynamic> userData, BuildContext context) {
      //display all user, except current 
      if (userData["email"] != _authService.getCurrentUser()){
         return UserTile(
      text: userData["email"],
      onTap: () {
        //tapped on a user - go to chat page
        Navigator.push(
          context,
           MaterialPageRoute(
            builder: (context) => ChatPage(
              receiverEmail: userData["email"],
              receiverID: userData["uid"],
            ),
            ),
        );

      },
    );


      } else {
       return Container();
      }
        
      }
      
   
  }


     