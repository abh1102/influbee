import 'package:flutter/material.dart';
import 'messages_page.dart';

class ChatConversationPage extends StatefulWidget {
  const ChatConversationPage({super.key});

  @override
  State<ChatConversationPage> createState() => _ChatConversationPageState();
}

class _ChatConversationPageState extends State<ChatConversationPage> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late ChatItem chatUser;
  
  List<ChatMessage> messages = [
    ChatMessage(
      text: "Hey there! I'm excited to collaborate with you on this project. Let's discuss the details and get started!",
      isMe: false,
      time: "Today",
      timestamp: "10:00 AM",
    ),
    ChatMessage(
      text: "Hi Sophia, I'm thrilled too! I've reviewed the project brief and have some ideas. When are you available for a quick call?",
      isMe: true,
      time: "",
      timestamp: "10:01 AM",
    ),
    ChatMessage(
      text: "I'm free tomorrow afternoon. How about 2 PM?",
      isMe: false,
      time: "",
      timestamp: "10:02 AM",
    ),
    ChatMessage(
      text: "Perfect! 2 PM it is. Looking forward to it.",
      isMe: true,
      time: "",
      timestamp: "10:03 AM",
    ),
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    chatUser = ModalRoute.of(context)?.settings.arguments as ChatItem? ?? 
        ChatItem(
          name: 'Sophia Bee',
          message: '',
          time: '',
          avatar: 'SB',
          isOnline: true,
          unreadCount: 0,
          avatarColor: const Color(0xFF8B5CF6),
        );
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      setState(() {
        messages.add(ChatMessage(
          text: _messageController.text.trim(),
          isMe: true,
          time: "",
          timestamp: "10:05 AM",
        ));
      });
      _messageController.clear();
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Row(
          children: [
            Stack(
              children: [
                Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                    color: chatUser.avatarColor,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      chatUser.avatar,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                if (chatUser.isOnline)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: const Color(0xFF10B981),
                        shape: BoxShape.circle,
                        border: Border.all(color: const Color(0xFF1A1A1A), width: 2),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  chatUser.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (chatUser.isOnline)
                  const Text(
                    '• Online',
                    style: TextStyle(
                      color: Color(0xFF10B981),
                      fontSize: 12,
                    ),
                  ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.phone, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_horiz, color: Colors.white),
            onPressed: () {},
          ),
        ],
        elevation: 0,
      ),
      body: Column(
        children: [
          // Messages List
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return _buildMessageBubble(message, index);
              },
            ),
          ),
          
          // Message Input
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message, int index) {
    final showTime = message.time.isNotEmpty;
    final isFirstInGroup = index == 0 || 
        messages[index - 1].isMe != message.isMe ||
        messages[index - 1].time.isNotEmpty;

    return Column(
      children: [
        if (showTime)
          Container(
            margin: const EdgeInsets.symmetric(vertical: 16),
            child: Text(
              message.time,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
          ),
        Container(
          margin: EdgeInsets.only(
            bottom: 8,
            top: isFirstInGroup ? 8 : 2,
          ),
          child: Row(
            mainAxisAlignment: message.isMe 
                ? MainAxisAlignment.end 
                : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (!message.isMe && isFirstInGroup)
                Container(
                  width: 24,
                  height: 24,
                  margin: const EdgeInsets.only(right: 8, bottom: 4),
                  decoration: BoxDecoration(
                    color: chatUser.avatarColor,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      chatUser.avatar.substring(0, 1),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 10,
                      ),
                    ),
                  ),
                )
              else if (!message.isMe)
                const SizedBox(width: 32),
              
              Flexible(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: message.isMe 
                        ? const Color(0xFFFF9500) 
                        : const Color(0xFF2A2A2A),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Text(
                    message.text,
                    style: TextStyle(
                      color: message.isMe ? Colors.white : Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              
              if (message.isMe)
                Container(
                  margin: const EdgeInsets.only(left: 8, bottom: 4),
                  child: Text(
                    message.timestamp,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 10,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Color(0xFF2A2A2A),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.grey),
            onPressed: () {},
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A1A),
                borderRadius: BorderRadius.circular(25),
              ),
              child: TextField(
                controller: _messageController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: 'Type a message...',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
                onSubmitted: (_) => _sendMessage(),
              ),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.camera_alt_outlined, color: Colors.grey),
            onPressed: () {},
          ),
          GestureDetector(
            onTap: _sendMessage,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: Color(0xFFFF9500),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.send,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChatMessage {
  final String text;
  final bool isMe;
  final String time;
  final String timestamp;

  ChatMessage({
    required this.text,
    required this.isMe,
    required this.time,
    required this.timestamp,
  });
}
