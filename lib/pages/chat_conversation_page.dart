import 'package:flutter/material.dart';
import 'messages_page.dart';
import '../utils/notification_helper.dart';

class ChatConversationPage extends StatefulWidget {
  const ChatConversationPage({super.key});

  @override
  State<ChatConversationPage> createState() => _ChatConversationPageState();
}

class _ChatConversationPageState extends State<ChatConversationPage> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late ChatItem chatUser;
  bool _isTyping = false;
  
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
  void initState() {
    super.initState();
    _messageController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _messageController.removeListener(_onTextChanged);
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {
      _isTyping = _messageController.text.trim().isNotEmpty;
    });
  }



  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      final now = DateTime.now();
      final timeString = "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')} ${now.hour >= 12 ? 'PM' : 'AM'}";
      
      setState(() {
        messages.add(ChatMessage(
          text: _messageController.text.trim(),
          isMe: true,
          time: "",
          timestamp: timeString,
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
        actions: [],
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
            bottom: 4,
            top: isFirstInGroup ? 4 : 1,
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Text(
                              message.text,
                              style: TextStyle(
                                color: message.isMe ? Colors.white : Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                message.timestamp,
                                style: TextStyle(
                                  color: message.isMe 
                                      ? Colors.white.withOpacity(0.7)
                                      : Colors.grey.withOpacity(0.8),
                                  fontSize: 11,
                                ),
                              ),
                              if (message.isMe) ...[
                                const SizedBox(width: 4),
                                Icon(
                                  Icons.done_all,
                                  size: 16,
                                  color: Colors.white.withOpacity(0.7),
                                ),
                              ],
                            ],
                          ),
                        ],
                      ),
                    ],
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
          // Emoji icon (moved to first position)
          IconButton(
            icon: const Icon(Icons.emoji_emotions_outlined, color: Colors.grey),
            onPressed: _showEmojiPicker,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A1A),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        hintText: 'Type a message...',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                      ),
                      onSubmitted: (_) => _sendMessage(),
                      maxLines: null,
                    ),
                  ),
                  // Star icon for exclusive content (moved inside text field)
                  IconButton(
                    icon: const Icon(Icons.star, color: Color(0xFFFF9500)),
                    onPressed: () {
                      Navigator.pushNamed(context, '/content_library');
                    },
                  ),
                  // Camera icon
                  IconButton(
                    icon: const Icon(Icons.camera_alt_outlined, color: Colors.grey),
                    onPressed: _showCameraOptions,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          // WhatsApp-style send/audio button
          GestureDetector(
            onTap: _isTyping ? _sendMessage : _startVoiceRecording,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: Color(0xFFFF9500),
                shape: BoxShape.circle,
              ),
              child: Icon(
                _isTyping ? Icons.send : Icons.mic,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showEmojiPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF2A2A2A),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        final emojis = [
          '😀', '😃', '😄', '😁', '😆', '😅', '😂', '🤣',
          '😊', '😇', '🙂', '🙃', '😉', '😌', '😍', '🥰',
          '😘', '😗', '😙', '😚', '😋', '😛', '😝', '😜',
          '🤪', '🤨', '🧐', '🤓', '😎', '🤩', '🥳', '😏',
          '😒', '😞', '😔', '😟', '😕', '🙁', '☹️', '😣',
          '😖', '😫', '😩', '🥺', '😢', '😭', '😤', '😠',
          '👍', '👎', '👌', '✌️', '🤞', '🤟', '🤘', '🤙',
          '👈', '👉', '👆', '🖕', '👇', '☝️', '👋', '🤚',
          '❤️', '🧡', '💛', '💚', '💙', '💜', '🖤', '🤍',
          '💔', '❣️', '💕', '💞', '💓', '💗', '💖', '💘',
        ];
        
        return Container(
          height: 300,
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Select Emoji',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 8,
                    childAspectRatio: 1,
                  ),
                  itemCount: emojis.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        _messageController.text += emojis[index];
                        _messageController.selection = TextSelection.fromPosition(
                          TextPosition(offset: _messageController.text.length),
                        );
                        Navigator.pop(context);
                      },
                      child: Container(
                        margin: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            emojis[index],
                            style: const TextStyle(fontSize: 24),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _startVoiceRecording() {
    // Show voice recording UI
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF2A2A2A),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.mic,
                color: Color(0xFFFF9500),
                size: 64,
              ),
              const SizedBox(height: 16),
              const Text(
                'Recording Voice Message...',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Tap to stop recording',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      setState(() {
                        messages.add(ChatMessage(
                          text: "🎵 Voice message",
                          isMe: true,
                          time: "",
                          timestamp: "10:05 AM",
                        ));
                      });
                      _scrollToBottom();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF9500),
                    ),
                    child: const Text(
                      'Send',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _showCameraOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF2A2A2A),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Add Photo',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Camera option
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      _takePhoto();
                    },
                    child: Column(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFF9500),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Camera',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Gallery option
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      _pickFromGallery();
                    },
                    child: Column(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: const Color(0xFF8B5CF6),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Icon(
                            Icons.photo_library,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Gallery',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  void _takePhoto() {
    // Simulate taking a photo
    setState(() {
      messages.add(ChatMessage(
        text: "📷 Photo captured",
        isMe: true,
        time: "",
        timestamp: DateTime.now().hour.toString().padLeft(2, '0') + 
                   ':' + DateTime.now().minute.toString().padLeft(2, '0') + ' AM',
      ));
    });
    _scrollToBottom();
    
    NotificationHelper.showSuccessNotification(context, 'Photo captured and sent!');
  }

  void _pickFromGallery() {
    // Simulate picking from gallery
    setState(() {
      messages.add(ChatMessage(
        text: "🖼️ Photo from gallery",
        isMe: true,
        time: "",
        timestamp: DateTime.now().hour.toString().padLeft(2, '0') + 
                   ':' + DateTime.now().minute.toString().padLeft(2, '0') + ' AM',
      ));
    });
    _scrollToBottom();
    
    NotificationHelper.showSuccessNotification(context, 'Photo selected from gallery!');
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
