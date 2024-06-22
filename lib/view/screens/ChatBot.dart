import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:onboard/core/constants/AppColors.dart';

class ChatBot extends StatefulWidget {
  const ChatBot({super.key});

  @override
  State<ChatBot> createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  final Gemini gemini = Gemini.instance;
  List<ChatMessage> messages = [];
  List<ChatUser> _typing = <ChatUser>[];
  ChatUser currentUser = ChatUser(id: "0", firstName: "User");
  ChatUser geminiUser = ChatUser(
      id: "1",
      firstName: "onBoard",
      profileImage: "assets/icons/logo.png"
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('onBoard Chat'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          child: _buildUI()
          ),
      ),
    );
  }

  Widget _buildUI() {
    return DashChat(
      typingUsers: _typing,
      currentUser: currentUser, 
      onSend: _sendMessage,
      messages: messages,
      inputOptions: const InputOptions(
        inputDecoration: InputDecoration(
          focusColor: AppColors.Secondary,
          hintText: "Ask me anything...",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(50)),
          ),
        ),
        alwaysShowSend: true,
        cursorStyle: CursorStyle(
          color: AppColors.Secondary,
          width: 2,
        ),
      ),
      messageOptions: MessageOptions(
        currentUserContainerColor: AppColors.Secondary,
        avatarBuilder: yourAvatarBuilder,
      ),
    );
  }

  void _sendMessage(ChatMessage chatMessage) {
    setState(() {
      messages = [chatMessage, ...messages];
      _typing = [geminiUser];
    });

    try {
      String question = chatMessage.text;
      question="QUERY FROM USER: "+question;
      question+="\nINSTRUCTIONS FOR RESPONSE: Do not reply in Markdown syntax. ";
      gemini.streamGenerateContent(question).listen((event) {
        ChatMessage? lastMessage = messages.firstOrNull;
        if (lastMessage != null && lastMessage.user == geminiUser) {
          lastMessage = messages.removeAt(0);
          String? response = event.content?.parts?.fold(
                  "", (previous, current) => "$previous ${current.text}") ??
              "";
          lastMessage.text += response;
          setState(() {
            _typing = [];
            messages = [lastMessage!, ...messages];
          });
        } else {
          String? response = event.content?.parts?.fold(
                  "", (previous, current) => "$previous ${current.text}") ??
              "";
          ChatMessage message = ChatMessage(
              user: geminiUser, createdAt: DateTime.now(), text: response);
          setState(() {
            _typing = [];
            messages = [message, ...messages];
          });
        }
      });
    } catch (e) {
      print(e);
    }
  }
  Widget yourAvatarBuilder(ChatUser user, Function? onTap, Function? onLongPress) {
    return Center(
      child: Image.asset("assets/icons/logo-icon.png",height: 50,width: 50,),
    );
  }
}