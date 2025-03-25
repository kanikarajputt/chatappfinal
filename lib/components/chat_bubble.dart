import 'package:chat_app/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;

  
  const ChatBubble({
    super.key,
    required this.message,
    required this.isCurrentUser,
    });

  @override
  Widget build(BuildContext context) {
    // light vs dark mode for correct bubble colors
    bool isDarkMode = 
            Provider.of<ThemeProvider>(context, listen: false).isDarkMode;


    return Container(
      decoration: BoxDecoration(
        color: isCurrentUser
         ? (isDarkMode ? const Color.fromARGB(255, 13, 73, 106) :  const Color.fromARGB(255, 50, 105, 160))
          : (isDarkMode ?  Colors.grey.shade800 : Colors.grey.shade200) ,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      margin: const  EdgeInsets.symmetric(vertical: 2.5, horizontal: 25 ),
      child: Text(
        message,
        style: TextStyle(
          color: isCurrentUser
         
          ? Colors.white
           : (isDarkMode ? Colors.white : Colors.black)),
        ),
    );
  }
}