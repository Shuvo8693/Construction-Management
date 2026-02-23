import 'package:charteur/features/views/admin/home/remarks/widgets/bottom_input_bar.dart';
import 'package:charteur/features/views/admin/home/remarks/widgets/chat_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class ChatMessage {
  final String senderName;
  final String? avatarUrl;
  final String? imageUrl;
  final String text;
  final String time;
  final bool isMe;

  const ChatMessage({
    required this.senderName,
    this.avatarUrl,
    this.imageUrl,
    required this.text,
    required this.time,
    required this.isMe,
  });
}

class RemarksScreen extends StatelessWidget {
  const RemarksScreen({super.key});

  static const _loremText =
      'Applying a smooth or protective layer of cement, lime, or gypsum on a wall or ceiling '
      'Applying a smooth or protective layer of cement, lime, or gypsum on a wall or ceiling '
      'Applying a smooth or protective layer of cement, lime, or gypsum on a wall or';

  static const List<ChatMessage> _messages = [
    ChatMessage(
      senderName: 'John Doe',
      imageUrl: 'https://harrcreative.com/wp-content/uploads/2020/02/Floor-Plan.jpg',
      text: _loremText,
      time: '03:23 PM',
      isMe: false,
    ),
    ChatMessage(
      senderName: 'Marvin McKinney',
      text: _loremText,
      time: '03:23 PM',
      isMe: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F7),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return ChatBubble(message: _messages[index]);
              },
            ),
          ),
          BottomInputBar(),
        ],
      ),
    );
  }
}

