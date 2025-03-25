import 'package:chat_app/components/chat_bubble.dart';
import 'package:chat_app/components/my_textfield.dart';
import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/services/chat/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String receiverEmail;
  final String receiverID;

   ChatPage({
    super.key,
    required this.receiverEmail,
    required this.receiverID,
    });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
    //text controller
    final TextEditingController _messageController = TextEditingController();

    //chat n auth service
    final ChatService _chatService = ChatService();
    final AuthService _authService = AuthService();

    //for textfield focus
    FocusNode myFocusNode = FocusNode();

    @override
  void initState() {
    super.initState();

    //add listener to focus node
    myFocusNode.addListener(() {
      if (myFocusNode.hasFocus) {
        /*cause delay so keyboard has time to show up
        then amt of remaining space will be calculated
        the scroll down
        */
        Future.delayed(
          const Duration(milliseconds: 500),
          () => scrollDown(),
        );

      }
    });

    //wait a bit for listview to built, then scroll to bottom
    Future.delayed(
      const Duration(milliseconds: 500),
      () => scrollDown(),
    );
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    _messageController.dispose();
    super.dispose();
  }

  //scroll controller 
  final ScrollController _scrollController = ScrollController();
  void scrollDown(){
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(seconds: 1),
       curve: Curves.fastOutSlowIn,
       ); 
    
  }

    //send msg
    void sendMessage() async{
      //if there is smth inside textfield
      if (_messageController.text.isNotEmpty) {
        //send msg
        await _chatService.sendMessage(widget.receiverID, _messageController.text);

        //clear text controller
        _messageController.clear();
      }
      scrollDown();
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: Text(widget.receiverEmail),
        backgroundColor: Colors.transparent ,
        foregroundColor: Colors.grey,
        elevation: 0,
     
    ),
      body: Column(
        children: [
          //display all msg
          Expanded(child: _buildMessageList(),
          ),
          //user input
          _buildUserInput(),

        ],
      ),
    );
  }

  //build msg list
  Widget _buildMessageList() {
    String senderID = _authService.getCurrentUser()!.uid;
    return StreamBuilder(stream: _chatService.getMessages(widget.receiverID, senderID), 
    builder: (context, snapshot){
      //errors
      if (snapshot.hasError){
        return const Text("Error");
      }

      //loading
      if (snapshot.connectionState == ConnectionState.waiting){
        return const Text("Loading..");
      }

      //return  list view
      return ListView(
        controller: _scrollController,
        children: snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
      );

    },
    );
  }

  //build message item
  Widget _buildMessageItem(DocumentSnapshot doc){
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    //is current user
    bool isCurrentUser = data['sender ID'] == _authService.getCurrentUser()!.uid;

    //align msg to right if sender is current user , otherwise left
    var alignment = 
           isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Column(
        crossAxisAlignment: isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          ChatBubble(
            message:data["message"],
            isCurrentUser: isCurrentUser,
            )
        ],
      ));
  }

  //build msg input
  Widget _buildUserInput(){
    return Padding(
      padding: const EdgeInsets.only(bottom: 50.0),
      child: Row(
        children: [
          //textfield should take up most space
          Expanded(child: MyTextfield(
            hintText: "Type something",
            obscureText: false,
            controller: _messageController,
            focusNode: myFocusNode ,

              ),
              ),
      
              //send button
              Container(
                decoration: const BoxDecoration(
                  color: Colors.blueGrey,
                  shape: BoxShape.circle,
                ),
                margin: const EdgeInsets.only(right: 25),
                child: IconButton(
                  onPressed: sendMessage, 
                  icon: const Icon(Icons.arrow_upward),
                  ),
              ),
      
      ],),
    );
  }
}