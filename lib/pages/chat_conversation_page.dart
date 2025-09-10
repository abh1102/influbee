import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

import 'package:voice_message_package/voice_message_package.dart';
import '../Model/ChatUser.dart';
import '../Model/chatitem.dart';
import '../Service/Chats/SendMessages.dart';
import 'messages_page.dart';
import '../utils/notification_helper.dart';
import '../widgets/influbee_coin.dart';
//
// class ChatConversationPage extends StatefulWidget {
//   const ChatConversationPage({super.key});
//
//   @override
//   State<ChatConversationPage> createState() => _ChatConversationPageState();
// }
//
// class _ChatConversationPageState extends State<ChatConversationPage> {
//   final TextEditingController _messageController = TextEditingController();
//   final ScrollController _scrollController = ScrollController();
//   late ChatItem chatUser;
//   bool _isTyping = false;
//
//   List<ChatMessage> messages = [
//     ChatMessage(
//       text: "Hey there! I'm excited to collaborate with you on this project. Let's discuss the details and get started!",
//       isMe: false,
//       time: "Today",
//       timestamp: "10:00 AM",
//     ),
//     ChatMessage(
//       text: "Hi Sophia, I'm thrilled too! I've reviewed the project brief and have some ideas. When are you available for a quick call?",
//       isMe: true,
//       time: "",
//       timestamp: "10:01 AM",
//     ),
//     ChatMessage(
//       text: "I'm free tomorrow afternoon. How about 2 PM?",
//       isMe: false,
//       time: "",
//       timestamp: "10:02 AM",
//     ),
//     ChatMessage(
//       text: "Perfect! 2 PM it is. Looking forward to it.",
//       isMe: true,
//       time: "",
//       timestamp: "10:03 AM",
//     ),
//   ];
//
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     chatUser = ModalRoute.of(context)?.settings.arguments as ChatItem? ??
//         ChatItem(
//           name: 'Sophia Bee',
//           message: '',
//           time: '',
//           avatar: 'SB',
//           isOnline: true,
//           unreadCount: 0,
//           avatarColor: const Color(0xFF8B5CF6),
//         );
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _messageController.addListener(_onTextChanged);
//   }
//
//   @override
//   void dispose() {
//     _messageController.removeListener(_onTextChanged);
//     _messageController.dispose();
//     _scrollController.dispose();
//     super.dispose();
//   }
//
//   void _onTextChanged() {
//     setState(() {
//       _isTyping = _messageController.text.trim().isNotEmpty;
//     });
//   }
//
//   void _handleSharedContent(Map<String, dynamic> result) {
//     if (result['action'] == 'share' && result['sharedContent'] != null) {
//       final content = result['sharedContent'] as ExclusiveContent;
//       // Add the shared content as a message
//       setState(() {
//         messages.add(ChatMessage(
//           text: "📎 Shared: ${content.title} (${content.price} coins)",
//           isMe: true,
//           time: "",
//           timestamp: DateTime.now().hour.toString().padLeft(2, '0') +
//                      ':' + DateTime.now().minute.toString().padLeft(2, '0') + ' AM',
//         ));
//       });
//       _scrollToBottom();
//
//       // Show success notification
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('${content.title} shared successfully!'),
//           backgroundColor: const Color(0xFF10B981),
//           duration: const Duration(seconds: 2),
//         ),
//       );
//     }
//   }
//
//
//
//   void _sendMessage() {
//     if (_messageController.text.trim().isNotEmpty) {
//       final now = DateTime.now();
//       final timeString = "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')} ${now.hour >= 12 ? 'PM' : 'AM'}";
//
//       setState(() {
//         messages.add(ChatMessage(
//           text: _messageController.text.trim(),
//           isMe: true,
//           time: "",
//           timestamp: timeString,
//         ));
//       });
//       _messageController.clear();
//       _scrollToBottom();
//     }
//   }
//
//   void _scrollToBottom() {
//     Future.delayed(const Duration(milliseconds: 100), () {
//       if (_scrollController.hasClients) {
//         _scrollController.animateTo(
//           _scrollController.position.maxScrollExtent,
//           duration: const Duration(milliseconds: 300),
//           curve: Curves.easeOut,
//         );
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF1A1A1A),
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF1A1A1A),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//         title: Row(
//           children: [
//             Stack(
//               children: [
//                 Container(
//                   width: 35,
//                   height: 35,
//                   decoration: BoxDecoration(
//                     color: chatUser.avatarColor,
//                     shape: BoxShape.circle,
//                   ),
//                   child: Center(
//                     child: Text(
//                       chatUser.avatar,
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.w600,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ),
//                 ),
//                 if (chatUser.isOnline)
//                   Positioned(
//                     right: 0,
//                     bottom: 0,
//                     child: Container(
//                       width: 10,
//                       height: 10,
//                       decoration: BoxDecoration(
//                         color: const Color(0xFF10B981),
//                         shape: BoxShape.circle,
//                         border: Border.all(color: const Color(0xFF1A1A1A), width: 2),
//                       ),
//                     ),
//                   ),
//               ],
//             ),
//             const SizedBox(width: 12),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   chatUser.name,
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 if (chatUser.isOnline)
//                   const Text(
//                     '• Online',
//                     style: TextStyle(
//                       color: Color(0xFF10B981),
//                       fontSize: 12,
//                     ),
//                   ),
//               ],
//             ),
//           ],
//         ),
//         actions: [
//           // User Balance Display
//           Container(
//             margin: const EdgeInsets.only(right: 16),
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//             decoration: BoxDecoration(
//               color: const Color(0xFFFF9500).withOpacity(0.2),
//               borderRadius: BorderRadius.circular(20),
//               border: Border.all(
//                 color: const Color(0xFFFF9500).withOpacity(0.3),
//                 width: 1,
//               ),
//             ),
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 const InflubeeCoin(size: 16),
//                 const SizedBox(width: 6),
//                 Text(
//                   '2,450',
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 14,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//         elevation: 0,
//       ),
//       body: Column(
//         children: [
//           // Messages List
//           Expanded(
//             child: ListView.builder(
//               controller: _scrollController,
//               padding: const EdgeInsets.all(16),
//               itemCount: messages.length,
//               itemBuilder: (context, index) {
//                 final message = messages[index];
//                 return _buildMessageBubble(message, index);
//               },
//             ),
//           ),
//
//           // Message Input
//           _buildMessageInput(),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildMessageBubble(ChatMessage message, int index) {
//     final showTime = message.time.isNotEmpty;
//     final isFirstInGroup = index == 0 ||
//         messages[index - 1].isMe != message.isMe ||
//         messages[index - 1].time.isNotEmpty;
//
//     return Column(
//       children: [
//         if (showTime)
//           Container(
//             margin: const EdgeInsets.symmetric(vertical: 16),
//             child: Text(
//               message.time,
//               style: const TextStyle(
//                 color: Colors.grey,
//                 fontSize: 12,
//               ),
//             ),
//           ),
//         Container(
//           margin: EdgeInsets.only(
//             bottom: 4,
//             top: isFirstInGroup ? 4 : 1,
//           ),
//           child: Row(
//             mainAxisAlignment: message.isMe
//                 ? MainAxisAlignment.end
//                 : MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               if (!message.isMe && isFirstInGroup)
//                 Container(
//                   width: 24,
//                   height: 24,
//                   margin: const EdgeInsets.only(right: 8, bottom: 4),
//                   decoration: BoxDecoration(
//                     color: chatUser.avatarColor,
//                     shape: BoxShape.circle,
//                   ),
//                   child: Center(
//                     child: Text(
//                       chatUser.avatar.substring(0, 1),
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.w600,
//                         fontSize: 10,
//                       ),
//                     ),
//                   ),
//                 )
//               else if (!message.isMe)
//                 const SizedBox(width: 32),
//
//               Flexible(
//                 child: Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                   decoration: BoxDecoration(
//                     color: message.isMe
//                         ? const Color(0xFFFF9500)
//                         : const Color(0xFF2A2A2A),
//                     borderRadius: BorderRadius.circular(18),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           Expanded(
//                             child: Text(
//                               message.text,
//                               style: TextStyle(
//                                 color: message.isMe ? Colors.white : Colors.white,
//                                 fontSize: 14,
//                               ),
//                             ),
//                           ),
//                           const SizedBox(width: 8),
//                           Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Text(
//                                 message.timestamp,
//                                 style: TextStyle(
//                                   color: message.isMe
//                                       ? Colors.white.withOpacity(0.7)
//                                       : Colors.grey.withOpacity(0.8),
//                                   fontSize: 11,
//                                 ),
//                               ),
//                               if (message.isMe) ...[
//                                 const SizedBox(width: 4),
//                                 Icon(
//                                   Icons.done_all,
//                                   size: 16,
//                                   color: Colors.white.withOpacity(0.7),
//                                 ),
//                               ],
//                             ],
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildMessageInput() {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: const BoxDecoration(
//         color: Color(0xFF2A2A2A),
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(20),
//           topRight: Radius.circular(20),
//         ),
//       ),
//       child: Row(
//         children: [
//           // Star icon for exclusive content (moved to first position)
//           IconButton(
//             icon: const Icon(Icons.star, color: Color(0xFFFF9500)),
//             onPressed: () async {
//               final result = await Navigator.pushNamed(
//                 context,
//                 '/exclusive_content_gallery',
//               );
//               if (result != null && result is Map<String, dynamic>) {
//                 _handleSharedContent(result);
//               }
//             },
//           ),
//           Expanded(
//             child: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               decoration: BoxDecoration(
//                 color: const Color(0xFF1A1A1A),
//                 borderRadius: BorderRadius.circular(25),
//               ),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: TextField(
//                       controller: _messageController,
//                       style: const TextStyle(color: Colors.white),
//                       decoration: const InputDecoration(
//                         hintText: 'Type a message...',
//                         hintStyle: TextStyle(color: Colors.grey),
//                         border: InputBorder.none,
//                       ),
//                       onSubmitted: (_) => _sendMessage(),
//                       maxLines: null,
//                     ),
//                   ),
//                   // Emoji icon (moved to right side)
//                   IconButton(
//                     icon: const Icon(Icons.emoji_emotions_outlined, color: Colors.grey),
//                     onPressed: _showEmojiPicker,
//                   ),
//                   // Camera icon
//                   IconButton(
//                     icon: const Icon(Icons.camera_alt_outlined, color: Colors.grey),
//                     onPressed: _showCameraOptions,
//                   ),
//                   // Gift icon for premium emojis/GIFs
//                   IconButton(
//                     icon: const Icon(Icons.card_giftcard, color: Color(0xFFFF9500)),
//                     onPressed: _showPremiumGifts,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           const SizedBox(width: 8),
//           // WhatsApp-style send/audio button
//           GestureDetector(
//             onTap: _isTyping ? _sendMessage : _startVoiceRecording,
//             child: Container(
//               padding: const EdgeInsets.all(12),
//               decoration: const BoxDecoration(
//                 color: Color(0xFFFF9500),
//                 shape: BoxShape.circle,
//               ),
//               child: Icon(
//                 _isTyping ? Icons.send : Icons.mic,
//                 color: Colors.white,
//                 size: 20,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _showEmojiPicker() {
//     showModalBottomSheet(
//       context: context,
//       backgroundColor: const Color(0xFF2A2A2A),
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (context) {
//         final emojis = [
//           '😀', '😃', '😄', '😁', '😆', '😅', '😂', '🤣',
//           '😊', '😇', '🙂', '🙃', '😉', '😌', '😍', '🥰',
//           '😘', '😗', '😙', '😚', '😋', '😛', '😝', '😜',
//           '🤪', '🤨', '🧐', '🤓', '😎', '🤩', '🥳', '😏',
//           '😒', '😞', '😔', '😟', '😕', '🙁', '☹️', '😣',
//           '😖', '😫', '😩', '🥺', '😢', '😭', '😤', '😠',
//           '👍', '👎', '👌', '✌️', '🤞', '🤟', '🤘', '🤙',
//           '👈', '👉', '👆', '🖕', '👇', '☝️', '👋', '🤚',
//           '❤️', '🧡', '💛', '💚', '💙', '💜', '🖤', '🤍',
//           '💔', '❣️', '💕', '💞', '💓', '💗', '💖', '💘',
//         ];
//
//         return Container(
//           height: 300,
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             children: [
//               Container(
//                 width: 40,
//                 height: 4,
//                 decoration: BoxDecoration(
//                   color: Colors.grey,
//                   borderRadius: BorderRadius.circular(2),
//                 ),
//               ),
//               const SizedBox(height: 16),
//               const Text(
//                 'Select Emoji',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 18,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               const SizedBox(height: 16),
//               Expanded(
//                 child: GridView.builder(
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 8,
//                     childAspectRatio: 1,
//                   ),
//                   itemCount: emojis.length,
//                   itemBuilder: (context, index) {
//                     return GestureDetector(
//                       onTap: () {
//                         _messageController.text += emojis[index];
//                         _messageController.selection = TextSelection.fromPosition(
//                           TextPosition(offset: _messageController.text.length),
//                         );
//                         Navigator.pop(context);
//                       },
//                       child: Container(
//                         margin: const EdgeInsets.all(4),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: Center(
//                           child: Text(
//                             emojis[index],
//                             style: const TextStyle(fontSize: 24),
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   void _startVoiceRecording() {
//     // Show voice recording UI
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           backgroundColor: const Color(0xFF2A2A2A),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const Icon(
//                 Icons.mic,
//                 color: Color(0xFFFF9500),
//                 size: 64,
//               ),
//               const SizedBox(height: 16),
//               const Text(
//                 'Recording Voice Message...',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               const SizedBox(height: 8),
//               const Text(
//                 'Tap to stop recording',
//                 style: TextStyle(
//                   color: Colors.grey,
//                   fontSize: 14,
//                 ),
//               ),
//               const SizedBox(height: 24),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   TextButton(
//                     onPressed: () => Navigator.pop(context),
//                     child: const Text(
//                       'Cancel',
//                       style: TextStyle(color: Colors.grey),
//                     ),
//                   ),
//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                       setState(() {
//                         messages.add(ChatMessage(
//                           text: "🎵 Voice message",
//                           isMe: true,
//                           time: "",
//                           timestamp: "10:05 AM",
//                         ));
//                       });
//                       _scrollToBottom();
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFFFF9500),
//                     ),
//                     child: const Text(
//                       'Send',
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   void _showCameraOptions() {
//     showModalBottomSheet(
//       context: context,
//       backgroundColor: const Color(0xFF2A2A2A),
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (context) {
//         return Container(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Container(
//                 width: 40,
//                 height: 4,
//                 decoration: BoxDecoration(
//                   color: Colors.grey,
//                   borderRadius: BorderRadius.circular(2),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               const Text(
//                 'Add Photo',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 18,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   // Camera option
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.pop(context);
//                       _takePhoto();
//                     },
//                     child: Column(
//                       children: [
//                         Container(
//                           width: 60,
//                           height: 60,
//                           decoration: BoxDecoration(
//                             color: const Color(0xFFFF9500),
//                             borderRadius: BorderRadius.circular(30),
//                           ),
//                           child: const Icon(
//                             Icons.camera_alt,
//                             color: Colors.white,
//                             size: 30,
//                           ),
//                         ),
//                         const SizedBox(height: 8),
//                         const Text(
//                           'Camera',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 14,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   // Gallery option
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.pop(context);
//                       _pickFromGallery();
//                     },
//                     child: Column(
//                       children: [
//                         Container(
//                           width: 60,
//                           height: 60,
//                           decoration: BoxDecoration(
//                             color: const Color(0xFF8B5CF6),
//                             borderRadius: BorderRadius.circular(30),
//                           ),
//                           child: const Icon(
//                             Icons.photo_library,
//                             color: Colors.white,
//                             size: 30,
//                           ),
//                         ),
//                         const SizedBox(height: 8),
//                         const Text(
//                           'Gallery',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 14,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   void _takePhoto() {
//     // Simulate taking a photo
//     setState(() {
//       messages.add(ChatMessage(
//         text: "📷 Photo captured",
//         isMe: true,
//         time: "",
//         timestamp: DateTime.now().hour.toString().padLeft(2, '0') +
//                    ':' + DateTime.now().minute.toString().padLeft(2, '0') + ' AM',
//       ));
//     });
//     _scrollToBottom();
//
//     NotificationHelper.showSuccessNotification(context, 'Photo captured and sent!');
//   }
//
//   void _pickFromGallery() {
//     // Simulate picking from gallery
//     setState(() {
//       messages.add(ChatMessage(
//         text: "🖼️ Photo from gallery",
//         isMe: true,
//         time: "",
//         timestamp: DateTime.now().hour.toString().padLeft(2, '0') +
//                    ':' + DateTime.now().minute.toString().padLeft(2, '0') + ' AM',
//       ));
//     });
//     _scrollToBottom();
//
//     NotificationHelper.showSuccessNotification(context, 'Photo selected from gallery!');
//   }
//
//   void _showPremiumGifts() {
//     showModalBottomSheet(
//       context: context,
//       backgroundColor: const Color(0xFF2A2A2A),
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       isScrollControlled: true,
//       builder: (context) {
//         return Container(
//           height: MediaQuery.of(context).size.height * 0.7,
//           padding: const EdgeInsets.all(24),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 width: 40,
//                 height: 4,
//                 decoration: BoxDecoration(
//                   color: Colors.grey,
//                   borderRadius: BorderRadius.circular(2),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Row(
//                 children: [
//                   Container(
//                     width: 48,
//                     height: 48,
//                     decoration: BoxDecoration(
//                       color: const Color(0xFFFF9500).withOpacity(0.2),
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: const Icon(
//                       Icons.card_giftcard,
//                       color: Color(0xFFFF9500),
//                       size: 24,
//                     ),
//                   ),
//                   const SizedBox(width: 16),
//                   const Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Request Premium Gifts',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 20,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                         Text(
//                           'Request gifts from your audience',
//                           style: TextStyle(
//                             color: Colors.grey,
//                             fontSize: 14,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 24),
//
//               // Premium Gifts Grid
//               Expanded(
//                 child: GridView.builder(
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 3,
//                     childAspectRatio: 0.8,
//                     crossAxisSpacing: 16,
//                     mainAxisSpacing: 16,
//                   ),
//                   itemCount: _premiumGifts.length,
//                   itemBuilder: (context, index) {
//                     final gift = _premiumGifts[index];
//                     return _buildGiftItem(gift);
//                   },
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   Widget _buildGiftItem(PremiumGift gift) {
//     return GestureDetector(
//       onTap: () => _requestPremiumGift(gift),
//       child: Container(
//         decoration: BoxDecoration(
//           color: const Color(0xFF1A1A1A),
//           borderRadius: BorderRadius.circular(16),
//           border: Border.all(
//             color: Colors.white.withOpacity(0.1),
//             width: 1,
//           ),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Gift Icon/Emoji
//             Container(
//               width: 48,
//               height: 48,
//               decoration: BoxDecoration(
//                 color: const Color(0xFFFF9500).withOpacity(0.2),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Center(
//                 child: Text(
//                   gift.emoji,
//                   style: const TextStyle(fontSize: 24),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 12),
//
//             // Gift Name
//             Text(
//               gift.name,
//               style: const TextStyle(
//                 color: Colors.white,
//                 fontSize: 12,
//                 fontWeight: FontWeight.w500,
//               ),
//               textAlign: TextAlign.center,
//               maxLines: 2,
//               overflow: TextOverflow.ellipsis,
//             ),
//             const SizedBox(height: 8),
//
//             // Price
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//               decoration: BoxDecoration(
//                 color: const Color(0xFFFF9500).withOpacity(0.2),
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   const InflubeeCoin(size: 12),
//                   const SizedBox(width: 4),
//                   Text(
//                     gift.price.toString(),
//                     style: const TextStyle(
//                       color: Color(0xFFFF9500),
//                       fontSize: 10,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//             const SizedBox(height: 4),
//
//             // Request Label
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
//               decoration: BoxDecoration(
//                 color: const Color(0xFF10B981).withOpacity(0.2),
//                 borderRadius: BorderRadius.circular(6),
//               ),
//               child: const Text(
//                 'REQUEST',
//                 style: TextStyle(
//                   color: Color(0xFF10B981),
//                   fontSize: 8,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _requestPremiumGift(PremiumGift gift) {
//     Navigator.pop(context);
//
//     // Add gift request message to chat
//     setState(() {
//       messages.add(ChatMessage(
//         text: "🎁 Requested ${gift.emoji} ${gift.name} (${gift.price} coins)",
//         isMe: true,
//         time: "",
//         timestamp: DateTime.now().hour.toString().padLeft(2, '0') +
//                    ':' + DateTime.now().minute.toString().padLeft(2, '0') + ' AM',
//       ));
//     });
//     _scrollToBottom();
//
//     // Show success notification
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('${gift.name} requested! User needs to pay ${gift.price} coins to unlock.'),
//         backgroundColor: const Color(0xFF10B981),
//         duration: const Duration(seconds: 3),
//       ),
//     );
//   }
// }
//
// class ChatMessage {
//   final String text;
//   final bool isMe;
//   final String time;
//   final String timestamp;
//
//   ChatMessage({
//     required this.text,
//     required this.isMe,
//     required this.time,
//     required this.timestamp,
//   });
// }
import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:permission_handler/permission_handler.dart';
class ChatConversationPage extends StatefulWidget {
  const ChatConversationPage({super.key});

  @override
  State<ChatConversationPage> createState() => _ChatConversationPageState();
}

class _ChatConversationPageState extends State<ChatConversationPage> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final ImagePicker _imagePicker = ImagePicker();
  final ChatService _chatService = ChatService(); // Initialize ChatService
  late ChatUser chatUser;
  bool _isTyping = false;
  bool _isRecording = false;
  Timer? _recordingTimer;
  int _recordingSeconds = 0;
  AudioRecorder? _audioRecorder;
  String? _audioPath;

  // Agora variables
  bool _isCalling = false;
  bool _isInCall = false;
  int? _remoteUid;
  RtcEngine? _agoraEngine;
  String channelName = "test_channel";
  String appId = "YOUR_AGORA_APP_ID";

  List<ChatMessage> messages = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    chatUser = ModalRoute.of(context)?.settings.arguments as ChatUser? ??
        ChatUser(
          id: 'u1',
          username: 'Sophia Bee',
          avatar: 'SB',
          displayName: 'Sophia Bee',
          role: 'Creator',
          isOnline: true,
        );
    _fetchMessages(); // Fetch messages when page loads
  }

  @override
  void initState() {
    super.initState();
    _messageController.addListener(_onTextChanged);
    _initAgora();
    _initAudioRecorder();
  }

  @override
  void dispose() {
    _messageController.removeListener(_onTextChanged);
    _messageController.dispose();
    _scrollController.dispose();
    _disposeAgora();
    _stopRecording();
    _audioRecorder?.dispose();
    super.dispose();
  }

  Future<void> _initAudioRecorder() async {
    _audioRecorder = AudioRecorder();
  }

  Future<void> _fetchMessages() async {
    try {
      final fetchedMessages = await _chatService.getPersonalMessages(chatUser.id);
      setState(() {
        messages = fetchedMessages.map((msg) => ChatMessage(
          text: msg['content'],
          isMe: msg['isOwn'],
          time: "", // You might want to format createdAt for display
          timestamp: _formatTimestamp(msg['createdAt']),
        )).toList();
      });
      _scrollToBottom();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to load messages: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  String _formatTimestamp(String timestamp) {
    final dateTime = DateTime.parse(timestamp).toLocal();
    return "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')} ${dateTime.hour >= 12 ? 'PM' : 'AM'}";
  }

  // Agora initialization and other methods remain unchanged
  Future<void> _initAgora() async {
    _agoraEngine = createAgoraRtcEngine();
    await _agoraEngine!.initialize(RtcEngineContext(appId: appId));

    _agoraEngine!.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          debugPrint("Local user ${connection.localUid} joined");
          setState(() {
            _isInCall = true;
          });
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          debugPrint("Remote user $remoteUid joined");
          setState(() {
            _remoteUid = remoteUid;
          });
        },
        onUserOffline: (RtcConnection connection, int remoteUid, UserOfflineReasonType reason) {
          debugPrint("Remote user $remoteUid left channel");
          setState(() {
            _remoteUid = null;
          });
        },
        onError: (ErrorCodeType err, String msg) {
          debugPrint("Error: $err, $msg");
        },
      ),
    );
  }

  Future<void> _disposeAgora() async {
    await _agoraEngine?.leaveChannel();
    await _agoraEngine?.release();
  }

  Future<void> _startCall(bool isVideoCall) async {
    await [Permission.microphone, if (isVideoCall) Permission.camera].request();
    if (isVideoCall) {
      await _agoraEngine!.enableVideo();
    } else {
      await _agoraEngine!.enableAudio();
    }
    await _agoraEngine!.setChannelProfile(ChannelProfileType.channelProfileCommunication);
    await _agoraEngine!.joinChannel(
      token: "null",
      channelId: channelName,
      uid: 0,
      options: const ChannelMediaOptions(),
    );
    setState(() {
      _isCalling = true;
    });
  }

  Future<void> _endCall() async {
    await _agoraEngine!.leaveChannel();
    setState(() {
      _isInCall = false;
      _isCalling = false;
      _remoteUid = null;
    });
    setState(() {
      messages.add(ChatMessage(
        text: "📞 Call ended",
        isMe: true,
        time: "",
        timestamp: _getCurrentTime(),
      ));
    });
    _scrollToBottom();
  }

  void _onTextChanged() {
    setState(() {
      _isTyping = _messageController.text.trim().isNotEmpty;
    });
  }

  void _handleSharedContent(Map<String, dynamic> result) {
    if (result['action'] == 'share' && result['sharedContent'] != null) {
      final content = result['sharedContent'] as ExclusiveContent;
      setState(() {
        messages.add(ChatMessage(
          text: "📎 Shared: ${content.title} (${content.price} coins)",
          isMe: true,
          time: "",
          timestamp: _getCurrentTime(),
        ));
      });
      _scrollToBottom();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${content.title} shared successfully!'),
          backgroundColor: const Color(0xFF10B981),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  void _sendMessage() async {
    if (_messageController.text.trim().isNotEmpty) {
      try {
        await _chatService.sendPersonalMessage(
          receiverId: chatUser.id,
          content: _messageController.text.trim(),
        );
        setState(() {
          messages.add(ChatMessage(
            text: _messageController.text.trim(),
            isMe: true,
            time: "",
            timestamp: _getCurrentTime(),
          ));
        });
        _messageController.clear();
        _scrollToBottom();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to send message: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
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

  String _getCurrentTime() {
    final now = DateTime.now();
    return "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')} ${now.hour >= 12 ? 'PM' : 'AM'}";
  }

  Widget _buildCallButton() {
    return IconButton(
      icon: Icon(
        _isInCall ? Icons.call_end : Icons.call,
        color: _isInCall ? Colors.red : Colors.white,
      ),
      onPressed: _isInCall ? _endCall : _showCallOptions,
    );
  }

  void _showCallOptions() {
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
                'Start a Call',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      _startCall(false);
                      setState(() {
                        messages.add(ChatMessage(
                          text: "📞 Voice call started",
                          isMe: true,
                          time: "",
                          timestamp: _getCurrentTime(),
                        ));
                      });
                      _scrollToBottom();
                    },
                    child: Column(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: const Color(0xFF10B981),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Icon(
                            Icons.call,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Voice Call',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      _startCall(true);
                      setState(() {
                        messages.add(ChatMessage(
                          text: "📹 Video call started",
                          isMe: true,
                          time: "",
                          timestamp: _getCurrentTime(),
                        ));
                      });
                      _scrollToBottom();
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
                            Icons.videocam,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Video Call',
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

  Widget _buildCallOverlay() {
    return Container(
      color: Colors.black.withOpacity(0.8),
      child: Column(
        children: [
          AppBar(
            backgroundColor: Colors.transparent,
            leading: Container(),
            actions: [
              IconButton(
                icon: const Icon(Icons.call_end, color: Colors.red, size: 30),
                onPressed: _endCall,
              ),
            ],
          ),
          Expanded(
            child: Center(
              child: _remoteUid != null
                  ? AgoraVideoView(
                controller: VideoViewController.remote(
                  rtcEngine: _agoraEngine!,
                  canvas: VideoCanvas(uid: _remoteUid),
                  connection: RtcConnection(channelId: channelName),
                ),
              )
                  : const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFF9500)),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Calling...',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
          if (_isCalling)
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                width: 100,
                height: 150,
                margin: const EdgeInsets.all(16),
                child: AgoraVideoView(
                  controller: VideoViewController(
                    rtcEngine: _agoraEngine!,
                    canvas: const VideoCanvas(uid: 0),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

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
                      chatUser.avatar!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                if (chatUser.isOnline==true)
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
                  chatUser.displayName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (chatUser.isOnline==true)
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
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFFF9500).withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: const Color(0xFFFF9500).withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.monetization_on, color: Color(0xFFFF9500), size: 16),
                const SizedBox(width: 6),
                Text(
                  '2,450',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
        elevation: 0,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(16),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    return _buildMessageBubble(message, index, screenWidth);
                  },
                ),
              ),
              _buildMessageInput(screenWidth),
            ],
          ),
          if (_isInCall) _buildCallOverlay(),
          if (_isRecording) _buildRecordingOverlay(),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message, int index, double screenWidth) {
    final showTime = message.time.isNotEmpty;
    final isFirstInGroup = index == 0 ||
        messages[index - 1].isMe != message.isMe ||
        messages[index - 1].time.isNotEmpty;

    final maxBubbleWidth = screenWidth * 0.8;

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
                      chatUser.avatar!.substring(0, 1),
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

              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: maxBubbleWidth),
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
                      if (message.imagePath != null)
                        Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(
                              File(message.imagePath!),
                              width: maxBubbleWidth - 32,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                      if (message.audioPath != null)
                        Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          child: VoiceMessageView(
                            controller: VoiceController(
                              audioSrc: message.audioPath!,
                              maxDuration: message.time != null
                                  ? Duration(seconds: int.tryParse(message.time!) ?? 60)
                                  : const Duration(seconds: 60),
                              isFile: true,
                              onComplete: () {},
                              onPause: () {},
                              onPlaying: () {},
                              onError: (err) {},
                            ),
                            innerPadding: 12,
                            cornerRadius: 20,
                          ),
                        ),

                      if (message.isGiftRequest)
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFF9500).withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                message.giftName ?? "Gift",
                                style: const TextStyle(
                                  color: Color(0xFFFF9500),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 4),
                              const Icon(Icons.card_giftcard, color: Color(0xFFFF9500), size: 16),
                              const SizedBox(width: 4),
                              Text(
                                "${message.giftPrice} coins",
                                style: const TextStyle(
                                  color: Color(0xFFFF9500),
                                ),
                              ),
                            ],
                          ),
                        ),

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

  Widget _buildMessageInput(double screenWidth) {
    return SafeArea(
      bottom: true,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        color: const Color(0xFF2A2A2A),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1A1A),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.emoji_emotions_outlined,
                          color: Colors.grey, size: 22),
                      onPressed: _showEmojiPicker,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                    Expanded(
                      child: TextField(
                        controller: _messageController,
                        style: const TextStyle(color: Colors.white, fontSize: 16),
                        decoration: const InputDecoration(
                          hintText: 'Type a message...',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 8),
                        ),
                        onSubmitted: (_) => _sendMessage(),
                        maxLines: null,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.camera_alt_outlined,
                          color: Colors.grey, size: 22),
                      onPressed: _showCameraOptions,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                    IconButton(
                      icon: const Icon(Icons.card_giftcard, color: Color(0xFFFF9500)),
                      onPressed: _showPremiumGifts,
                    ),
                    IconButton(
                      icon: const Icon(Icons.star, color: Color(0xFFFF9500)),
                      onPressed: () async {
                        final result = await Navigator.pushNamed(
                          context,
                          '/exclusive_content_gallery',
                        );
                        if (result != null && result is Map<String, dynamic>) {
                          _handleSharedContent(result);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: _isTyping ? _sendMessage : _startVoiceRecording,
              onLongPress: _startVoiceRecording,
              child: Container(
                width: 44,
                height: 44,
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
      ),
    );
  }

  Widget _buildRecordingOverlay() {
    return Positioned(
      bottom: 80,
      left: 0,
      right: 0,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF2A2A2A),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          children: [
            const Icon(
              Icons.mic,
              color: Color(0xFFFF9500),
              size: 36,
            ),
            const SizedBox(height: 8),
            Text(
              'Recording... $_recordingSeconds seconds',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: _stopRecordingAndSend,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFFFF9500),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Send',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
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

  void _startVoiceRecording() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Microphone permission is required to record audio'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      final directory = await getTemporaryDirectory();
      final path = '${directory.path}/voice_message_${DateTime.now().millisecondsSinceEpoch}.m4a';
      await _audioRecorder?.start(RecordConfig(), path: path);
      setState(() {
        _isRecording = true;
        _recordingSeconds = 0;
        _audioPath = path;
      });
      _recordingTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          _recordingSeconds++;
        });
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to start recording: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _stopRecording() {
    _recordingTimer?.cancel();
    _audioRecorder?.stop();
    setState(() {
      _isRecording = false;
    });
  }

  void _stopRecordingAndSend() async {
    _stopRecording();
    if (_audioPath != null) {
      setState(() {
        messages.add(ChatMessage(
          text: "Voice message",
          isMe: true,
          time: "",
          timestamp: _getCurrentTime(),
          audioPath: _audioPath!,
        ));
      });
      _scrollToBottom();
    }
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

  void _showAttachmentOptions() {
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
                'Send Attachment',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 20,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      _pickDocument();
                    },
                    child: Column(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: const Color(0xFF10B981),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Icon(
                            Icons.description,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Document',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      _sendLocation();
                    },
                    child: Column(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: const Color(0xFFEF4444),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Icon(
                            Icons.location_on,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Location',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      _sendContact();
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
                            Icons.contact_page,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Contact',
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

  void _takePhoto() async {
    final status = await Permission.camera.request();
    if (status != PermissionStatus.granted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Camera permission is required to take photos'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      final XFile? photo = await _imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
      );

      if (photo != null) {
        setState(() {
          messages.add(ChatMessage(
            text: "Photo",
            isMe: true,
            time: "",
            timestamp: _getCurrentTime(),
            imagePath: photo.path,
          ));
        });
        _scrollToBottom();
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to take photo: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _pickFromGallery() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (image != null) {
        setState(() {
          messages.add(ChatMessage(
            text: "Photo",
            isMe: true,
            time: "",
            timestamp: _getCurrentTime(),
            imagePath: image.path,
          ));
        });
        _scrollToBottom();
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to pick image: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _pickDocument() async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Document picker would open here'),
        backgroundColor: Colors.blue,
      ),
    );
  }

  void _sendLocation() async {
    setState(() {
      messages.add(ChatMessage(
        text: "📍 My Location",
        isMe: true,
        time: "",
        timestamp: _getCurrentTime(),
      ));
    });
    _scrollToBottom();
  }

  void _sendContact() async {
    setState(() {
      messages.add(ChatMessage(
        text: "👤 Contact Shared",
        isMe: true,
        time: "",
        timestamp: _getCurrentTime(),
      ));
    });
    _scrollToBottom();
  }

  final List<PremiumGift> _premiumGifts = [
    PremiumGift('Rose', '🌹', 10),
    PremiumGift('Chocolate', '🍫', 20),
    PremiumGift('Diamond', '💎', 50),
    PremiumGift('Crown', '👑', 100),
    PremiumGift('Car', '🚗', 200),
    PremiumGift('Yacht', '🛥️', 500),
  ];

  void _showPremiumGifts() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF2A2A2A),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.7,
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF9500).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.card_giftcard,
                      color: Color(0xFFFF9500),
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Request Premium Gifts',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'Request gifts from your audience',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize : 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 0.8,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: _premiumGifts.length,
                  itemBuilder: (context, index) {
                    final gift = _premiumGifts[index];
                    return _buildGiftItem(gift);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildGiftItem(PremiumGift gift) {
    return GestureDetector(
      onTap: () => _requestPremiumGift(gift),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.white.withOpacity(0.1),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xFFFF9500).withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  gift.emoji,
                  style: const TextStyle(fontSize: 24),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              gift.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFFF9500).withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.monetization_on, color: Color(0xFFFF9500), size: 12),
                  const SizedBox(width: 4),
                  Text(
                    gift.price.toString(),
                    style: const TextStyle(
                      color: Color(0xFFFF9500),
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: const Color(0xFF10B981).withOpacity(0.2),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Text(
                'REQUEST',
                style: TextStyle(
                  color: Color(0xFF10B981),
                  fontSize: 8,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _requestPremiumGift(PremiumGift gift) {
    Navigator.pop(context);
    setState(() {
      messages.add(ChatMessage(
        text: "Gift request",
        isMe: true,
        time: "",
        timestamp: _getCurrentTime(),
        isGiftRequest: true,
        giftName: gift.name,
        giftPrice: gift.price,
      ));
    });
    _scrollToBottom();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${gift.name} requested! User needs to pay ${gift.price} coins to unlock.'),
        backgroundColor: const Color(0xFF10B981),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
///11 sept
// class ChatConversationPage extends StatefulWidget {
//   const ChatConversationPage({super.key});
//
//   @override
//   State<ChatConversationPage> createState() => _ChatConversationPageState();
// }
//
// class _ChatConversationPageState extends State<ChatConversationPage> {
//   final TextEditingController _messageController = TextEditingController();
//   final ScrollController _scrollController = ScrollController();
//   final ImagePicker _imagePicker = ImagePicker();
//   late ChatUser chatUser;
//   bool _isTyping = false;
//   bool _isRecording = false;
//   Timer? _recordingTimer;
//   int _recordingSeconds = 0;
//   AudioRecorder? _audioRecorder;
//   String? _audioPath;
//
//   // Agora variables
//   bool _isCalling = false;
//   bool _isInCall = false;
//   int? _remoteUid;
//   RtcEngine? _agoraEngine;
//   String channelName = "test_channel";
//   String appId = "YOUR_AGORA_APP_ID";
//
//   List<ChatMessage> messages = [
//     ChatMessage(
//       text: "Hey there! I'm excited to collaborate with you on this project. Let's discuss the details and get started!",
//       isMe: false,
//       time: "Today",
//       timestamp: "10:00 AM",
//     ),
//     ChatMessage(
//       text: "Hi Sophia, I'm thrilled too! I've reviewed the project brief and have some ideas. When are you available for a quick call?",
//       isMe: true,
//       time: "",
//       timestamp: "10:01 AM",
//     ),
//     ChatMessage(
//       text: "I'm free tomorrow afternoon. How about 2 PM?",
//       isMe: false,
//       time: "",
//       timestamp: "10:02 AM",
//     ),
//     ChatMessage(
//       text: "Perfect! 2 PM it is. Looking forward to it.",
//       isMe: true,
//       time: "",
//       timestamp: "10:03 AM",
//     ),
//   ];
//
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     chatUser = ModalRoute.of(context)?.settings.arguments as ChatUser? ??
//         ChatUser(
//           id: 'u1',
//           username: 'Sophia Bee',
//           avatar: 'SB',
//           displayName: 'Sophia Bee',
//           role: 'Creator',
//           // avatar: "const Color(0xFF8B5CF6)",
//           isOnline: true,
//         );
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _messageController.addListener(_onTextChanged);
//     _initAgora();
//     _initAudioRecorder();
//   }
//
//   @override
//   void dispose() {
//     _messageController.removeListener(_onTextChanged);
//     _messageController.dispose();
//     _scrollController.dispose();
//     _disposeAgora();
//     _stopRecording();
//     _audioRecorder?.dispose();
//     super.dispose();
//   }
//
//   Future<void> _initAudioRecorder() async {
//     _audioRecorder = AudioRecorder();
//   }
//
//   // Agora initialization
//   Future<void> _initAgora() async {
//     // Create the engine
//     _agoraEngine = createAgoraRtcEngine();
//     await _agoraEngine!.initialize(RtcEngineContext(appId: appId));
//
//     // Register the event handler
//     _agoraEngine!.registerEventHandler(
//       RtcEngineEventHandler(
//         onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
//           debugPrint("Local user ${connection.localUid} joined");
//           setState(() {
//             _isInCall = true;
//           });
//         },
//         onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
//           debugPrint("Remote user $remoteUid joined");
//           setState(() {
//             _remoteUid = remoteUid;
//           });
//         },
//         onUserOffline: (RtcConnection connection, int remoteUid, UserOfflineReasonType reason) {
//           debugPrint("Remote user $remoteUid left channel");
//           setState(() {
//             _remoteUid = null;
//           });
//         },
//         onError: (ErrorCodeType err, String msg) {
//           debugPrint("Error: $err, $msg");
//         },
//       ),
//     );
//   }
//
//   Future<void> _disposeAgora() async {
//     await _agoraEngine?.leaveChannel();
//     await _agoraEngine?.release();
//   }
//
//   // Call management methods
//   Future<void> _startCall(bool isVideoCall) async {
//     // Request microphone and camera permissions
//     await [Permission.microphone, if (isVideoCall) Permission.camera].request();
//
//     // Enable video if it's a video call
//     if (isVideoCall) {
//       await _agoraEngine!.enableVideo();
//     } else {
//       await _agoraEngine!.enableAudio();
//     }
//
//     // Set channel profile
//     await _agoraEngine!.setChannelProfile(ChannelProfileType.channelProfileCommunication);
//
//     // Join channel
//     await _agoraEngine!.joinChannel(
//       token: "null",
//       channelId: channelName,
//       uid: 0,
//       options: const ChannelMediaOptions(),
//     );
//
//     setState(() {
//       _isCalling = true;
//     });
//   }
//
//   Future<void> _endCall() async {
//     await _agoraEngine!.leaveChannel();
//     setState(() {
//       _isInCall = false;
//       _isCalling = false;
//       _remoteUid = null;
//     });
//
//     // Add call ended message to chat
//     setState(() {
//       messages.add(ChatMessage(
//         text: "📞 Call ended",
//         isMe: true,
//         time: "",
//         timestamp: _getCurrentTime(),
//       ));
//     });
//     _scrollToBottom();
//   }
//
//   void _onTextChanged() {
//     setState(() {
//       _isTyping = _messageController.text.trim().isNotEmpty;
//     });
//   }
//
//   void _handleSharedContent(Map<String, dynamic> result) {
//     if (result['action'] == 'share' && result['sharedContent'] != null) {
//       final content = result['sharedContent'] as ExclusiveContent;
//       // Add the shared content as a message
//       setState(() {
//         messages.add(ChatMessage(
//           text: "📎 Shared: ${content.title} (${content.price} coins)",
//           isMe: true,
//           time: "",
//           timestamp: _getCurrentTime(),
//         ));
//       });
//       _scrollToBottom();
//
//       // Show success notification
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('${content.title} shared successfully!'),
//           backgroundColor: const Color(0xFF10B981),
//           duration: const Duration(seconds: 2),
//         ),
//       );
//     }
//   }
//
//   void _sendMessage() {
//     if (_messageController.text.trim().isNotEmpty) {
//       setState(() {
//         messages.add(ChatMessage(
//           text: _messageController.text.trim(),
//           isMe: true,
//           time: "",
//           timestamp: _getCurrentTime(),
//         ));
//       });
//       _messageController.clear();
//       _scrollToBottom();
//     }
//   }
//
//   void _scrollToBottom() {
//     Future.delayed(const Duration(milliseconds: 100), () {
//       if (_scrollController.hasClients) {
//         _scrollController.animateTo(
//           _scrollController.position.maxScrollExtent,
//           duration: const Duration(milliseconds: 300),
//           curve: Curves.easeOut,
//         );
//       }
//     });
//   }
//
//   String _getCurrentTime() {
//     final now = DateTime.now();
//     return "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')} ${now.hour >= 12 ? 'PM' : 'AM'}";
//   }
//
//   // Add call button to your app bar
//   Widget _buildCallButton() {
//     return IconButton(
//       icon: Icon(
//         _isInCall ? Icons.call_end : Icons.call,
//         color: _isInCall ? Colors.red : Colors.white,
//       ),
//       onPressed: _isInCall ? _endCall : _showCallOptions,
//     );
//   }
//
//   void _showCallOptions() {
//     showModalBottomSheet(
//       context: context,
//       backgroundColor: const Color(0xFF2A2A2A),
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (context) {
//         return Container(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Container(
//                 width: 40,
//                 height: 4,
//                 decoration: BoxDecoration(
//                   color: Colors.grey,
//                   borderRadius: BorderRadius.circular(2),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               const Text(
//                 'Start a Call',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 18,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   // Voice call option
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.pop(context);
//                       _startCall(false);
//                       // Add call message to chat
//                       setState(() {
//                         messages.add(ChatMessage(
//                           text: "📞 Voice call started",
//                           isMe: true,
//                           time: "",
//                           timestamp: _getCurrentTime(),
//                         ));
//                       });
//                       _scrollToBottom();
//                     },
//                     child: Column(
//                       children: [
//                         Container(
//                           width: 60,
//                           height: 60,
//                           decoration: BoxDecoration(
//                             color: const Color(0xFF10B981),
//                             borderRadius: BorderRadius.circular(30),
//                           ),
//                           child: const Icon(
//                             Icons.call,
//                             color: Colors.white,
//                             size: 30,
//                           ),
//                         ),
//                         const SizedBox(height: 8),
//                         const Text(
//                           'Voice Call',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 14,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   // Video call option
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.pop(context);
//                       _startCall(true);
//                       // Add call message to chat
//                       setState(() {
//                         messages.add(ChatMessage(
//                           text: "📹 Video call started",
//                           isMe: true,
//                           time: "",
//                           timestamp: _getCurrentTime(),
//                         ));
//                       });
//                       _scrollToBottom();
//                     },
//                     child: Column(
//                       children: [
//                         Container(
//                           width: 60,
//                           height: 60,
//                           decoration: BoxDecoration(
//                             color: const Color(0xFF8B5CF6),
//                             borderRadius: BorderRadius.circular(30),
//                           ),
//                           child: const Icon(
//                             Icons.videocam,
//                             color: Colors.white,
//                             size: 30,
//                           ),
//                         ),
//                         const SizedBox(height: 8),
//                         const Text(
//                           'Video Call',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 14,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   Widget _buildCallOverlay() {
//     return Container(
//       color: Colors.black.withOpacity(0.8),
//       child: Column(
//         children: [
//           AppBar(
//             backgroundColor: Colors.transparent,
//             leading: Container(),
//             actions: [
//               IconButton(
//                 icon: const Icon(Icons.call_end, color: Colors.red, size: 30),
//                 onPressed: _endCall,
//               ),
//             ],
//           ),
//           Expanded(
//             child: Center(
//               child: _remoteUid != null
//                   ? AgoraVideoView(
//                 controller: VideoViewController.remote(
//                   rtcEngine: _agoraEngine!,
//                   canvas: VideoCanvas(uid: _remoteUid),
//                   connection: RtcConnection(channelId: channelName),
//                 ),
//               )
//                   : const Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   CircularProgressIndicator(
//                     valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFF9500)),
//                   ),
//                   SizedBox(height: 16),
//                   Text(
//                     'Calling...',
//                     style: TextStyle(color: Colors.white, fontSize: 18),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           // Local video preview
//           if (_isCalling)
//             Align(
//               alignment: Alignment.bottomRight,
//               child: Container(
//                 width: 100,
//                 height: 150,
//                 margin: const EdgeInsets.all(16),
//                 child: AgoraVideoView(
//                   controller: VideoViewController(
//                     rtcEngine: _agoraEngine!,
//                     canvas: const VideoCanvas(uid: 0),
//                   ),
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;
//     final screenWidth = MediaQuery.of(context).size.width;
//
//     return Scaffold(
//       backgroundColor: const Color(0xFF1A1A1A),
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF1A1A1A),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//         title: Row(
//           children: [
//             Stack(
//               children: [
//                 Container(
//                   width: 35,
//                   height: 35,
//                   decoration: BoxDecoration(
//                     color: chatUser.avatarColor,
//                     shape: BoxShape.circle,
//                   ),
//                   child: Center(
//                     child: Text(
//                       chatUser.avatar!,
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.w600,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ),
//                 ),
//                 if (chatUser.isOnline==true)
//                   Positioned(
//                     right: 0,
//                     bottom: 0,
//                     child: Container(
//                       width: 10,
//                       height: 10,
//                       decoration: BoxDecoration(
//                         color: const Color(0xFF10B981),
//                         shape: BoxShape.circle,
//                         border: Border.all(color: const Color(0xFF1A1A1A), width: 2),
//                       ),
//                     ),
//                   ),
//               ],
//             ),
//             const SizedBox(width: 12),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   chatUser.displayName,
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 if (chatUser.isOnline==true)
//                   const Text(
//                     '• Online',
//                     style: TextStyle(
//                       color: Color(0xFF10B981),
//                       fontSize: 12,
//                     ),
//                   ),
//               ],
//             ),
//           ],
//         ),
//         actions: [
//           // _buildCallButton(),
//           // User Balance Display
//           Container(
//             margin: const EdgeInsets.only(right: 16),
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//             decoration: BoxDecoration(
//               color: const Color(0xFFFF9500).withOpacity(0.2),
//               borderRadius: BorderRadius.circular(20),
//               border: Border.all(
//                 color: const Color(0xFFFF9500).withOpacity(0.3),
//                 width: 1,
//               ),
//             ),
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 const Icon(Icons.monetization_on, color: Color(0xFFFF9500), size: 16),
//                 const SizedBox(width: 6),
//                 Text(
//                   '2,450',
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 14,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//         elevation: 0,
//       ),
//       body: Stack(
//         children: [
//           Column(
//             children: [
//               // Messages List
//               Expanded(
//                 child: ListView.builder(
//                   controller: _scrollController,
//                   padding: const EdgeInsets.all(16),
//                   itemCount: messages.length,
//                   itemBuilder: (context, index) {
//                     final message = messages[index];
//                     return _buildMessageBubble(message, index, screenWidth);
//                   },
//                 ),
//               ),
//
//               // Message Input
//               _buildMessageInput(screenWidth),
//             ],
//           ),
//
//           // Call overlay
//           if (_isInCall) _buildCallOverlay(),
//
//           // Recording overlay
//           if (_isRecording) _buildRecordingOverlay(),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildMessageBubble(ChatMessage message, int index, double screenWidth) {
//     final showTime = message.time.isNotEmpty;
//     final isFirstInGroup = index == 0 ||
//         messages[index - 1].isMe != message.isMe ||
//         messages[index - 1].time.isNotEmpty;
//
//     // Calculate max width for message bubbles (80% of screen width)
//     final maxBubbleWidth = screenWidth * 0.8;
//
//     return Column(
//       children: [
//         if (showTime)
//           Container(
//             margin: const EdgeInsets.symmetric(vertical: 16),
//             child: Text(
//               message.time,
//               style: const TextStyle(
//                 color: Colors.grey,
//                 fontSize: 12,
//               ),
//             ),
//           ),
//         Container(
//           margin: EdgeInsets.only(
//             bottom: 4,
//             top: isFirstInGroup ? 4 : 1,
//           ),
//           child: Row(
//             mainAxisAlignment: message.isMe
//                 ? MainAxisAlignment.end
//                 : MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               if (!message.isMe && isFirstInGroup)
//                 Container(
//                   width: 24,
//                   height: 24,
//                   margin: const EdgeInsets.only(right: 8, bottom: 4),
//                   decoration: BoxDecoration(
//                     color: chatUser.avatarColor,
//                     shape: BoxShape.circle,
//                   ),
//                   child: Center(
//                     child: Text(
//                       chatUser.avatar!.substring(0, 1),
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.w600,
//                         fontSize: 10,
//                       ),
//                     ),
//                   ),
//                 )
//               else if (!message.isMe)
//                 const SizedBox(width: 32),
//
//               ConstrainedBox(
//                 constraints: BoxConstraints(maxWidth: maxBubbleWidth),
//                 child: Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                   decoration: BoxDecoration(
//                     color: message.isMe
//                         ? const Color(0xFFFF9500)
//                         : const Color(0xFF2A2A2A),
//                     borderRadius: BorderRadius.circular(18),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       if (message.imagePath != null)
//                         Container(
//                           margin: const EdgeInsets.only(bottom: 8),
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(12),
//                             child: Image.file(
//                               File(message.imagePath!),
//                               width: maxBubbleWidth - 32,
//                               height: 200,
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                         ),
//
//                       if (message.audioPath != null)
//                         Container(
//                           margin: const EdgeInsets.only(bottom: 8),
//                           child: VoiceMessageView(
//                             controller: VoiceController(
//                               audioSrc: message.audioPath!,
//                               maxDuration: message.time != null
//                                   ? Duration(seconds: int.tryParse(message.time!) ?? 60)
//                                   : const Duration(seconds: 60),                         isFile: true, // true if it's local file path
//                               onComplete: () {
//                                 // Optional: callback when playback completes
//                               },
//                               onPause: () {},
//                               onPlaying: () {},
//                               onError: (err) {
//                                 // Handle errors
//                               },
//                             ),
//                             innerPadding: 12,
//                             cornerRadius: 20,
//                           ),
//                         ),
//
//                       if (message.isGiftRequest)
//                         Container(
//                           padding: const EdgeInsets.all(8),
//                           decoration: BoxDecoration(
//                             color: const Color(0xFFFF9500).withOpacity(0.2),
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           child: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Text(
//                                 message.giftName ?? "Gift",
//                                 style: const TextStyle(
//                                   color: Color(0xFFFF9500),
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               const SizedBox(width: 4),
//                               const Icon(Icons.card_giftcard, color: Color(0xFFFF9500), size: 16),
//                               const SizedBox(width: 4),
//                               Text(
//                                 "${message.giftPrice} coins",
//                                 style: const TextStyle(
//                                   color: Color(0xFFFF9500),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//
//                       Row(
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           Expanded(
//                             child: Text(
//                               message.text,
//                               style: TextStyle(
//                                 color: message.isMe ? Colors.white : Colors.white,
//                                 fontSize: 14,
//                               ),
//                             ),
//                           ),
//                           const SizedBox(width: 8),
//                           Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Text(
//                                 message.timestamp,
//                                 style: TextStyle(
//                                   color: message.isMe
//                                       ? Colors.white.withOpacity(0.7)
//                                       : Colors.grey.withOpacity(0.8),
//                                   fontSize: 11,
//                                 ),
//                               ),
//                               if (message.isMe) ...[
//                                 const SizedBox(width: 4),
//                                 Icon(
//                                   Icons.done_all,
//                                   size: 16,
//                                   color: Colors.white.withOpacity(0.7),
//                                 ),
//                               ],
//                             ],
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildMessageInput(double screenWidth) {
//     return SafeArea(
//       bottom: true,
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
//         color: const Color(0xFF2A2A2A),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             // Expanded input field
//             Expanded(
//               child: Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                 decoration: BoxDecoration(
//                   color: const Color(0xFF1A1A1A),
//                   borderRadius: BorderRadius.circular(25),
//                 ),
//                 child: Row(
//                   children: [
//                     // Emoji button
//                     IconButton(
//                       icon: const Icon(Icons.emoji_emotions_outlined,
//                           color: Colors.grey, size: 22),
//                       onPressed: _showEmojiPicker,
//                       padding: EdgeInsets.zero,
//                       constraints: const BoxConstraints(),
//                     ),
//
//                     // Text field
//                     Expanded(
//                       child: TextField(
//                         controller: _messageController,
//                         style: const TextStyle(color: Colors.white, fontSize: 16),
//                         decoration: const InputDecoration(
//                           hintText: 'Type a message...',
//                           hintStyle: TextStyle(color: Colors.grey),
//                           border: InputBorder.none,
//                           isDense: true,
//                           contentPadding: EdgeInsets.symmetric(vertical: 8),
//                         ),
//                         onSubmitted: (_) => _sendMessage(),
//                         maxLines: null,
//                       ),
//                     ),
//
//                     // Camera button
//                     IconButton(
//                       icon: const Icon(Icons.camera_alt_outlined,
//                           color: Colors.grey, size: 22),
//                       onPressed: _showCameraOptions,
//                       padding: EdgeInsets.zero,
//                       constraints: const BoxConstraints(),
//                     ),
//
//                     // Attachment button
//                     IconButton(
//                       icon: const Icon(Icons.card_giftcard, color: Color(0xFFFF9500)),
//                       onPressed: _showPremiumGifts,
//                     ),
//
//                     // Exclusive content (Star)
//                     IconButton(
//                       icon: const Icon(Icons.star, color: Color(0xFFFF9500)),
//                       onPressed: () async {
//                         final result = await Navigator.pushNamed(
//                           context,
//                           '/exclusive_content_gallery',
//                         );
//                         if (result != null && result is Map<String, dynamic>) {
//                           _handleSharedContent(result);
//                         }
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//
//             const SizedBox(width: 8),
//
//             // Send / Record
//             GestureDetector(
//               onTap: _isTyping ? _sendMessage : _startVoiceRecording,
//               onLongPress: _startVoiceRecording,
//               child: Container(
//                 width: 44,
//                 height: 44,
//                 decoration: const BoxDecoration(
//                   color: Color(0xFFFF9500),
//                   shape: BoxShape.circle,
//                 ),
//                 child: Icon(
//                   _isTyping ? Icons.send : Icons.mic,
//                   color: Colors.white,
//                   size: 20,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildRecordingOverlay() {
//     return Positioned(
//       bottom: 80,
//       left: 0,
//       right: 0,
//       child: Container(
//         margin: const EdgeInsets.symmetric(horizontal: 20),
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: const Color(0xFF2A2A2A),
//           borderRadius: BorderRadius.circular(16),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.3),
//               blurRadius: 10,
//               spreadRadius: 2,
//             ),
//           ],
//         ),
//         child: Column(
//           children: [
//             const Icon(
//               Icons.mic,
//               color: Color(0xFFFF9500),
//               size: 36,
//             ),
//             const SizedBox(height: 8),
//             Text(
//               'Recording... $_recordingSeconds seconds',
//               style: const TextStyle(
//                 color: Colors.white,
//                 fontSize: 16,
//               ),
//             ),
//             const SizedBox(height: 16),
//             GestureDetector(
//               onTap: _stopRecordingAndSend,
//               child: Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                 decoration: BoxDecoration(
//                   color: const Color(0xFFFF9500),
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: const Text(
//                   'Send',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _showEmojiPicker() {
//     showModalBottomSheet(
//       context: context,
//       backgroundColor: const Color(0xFF2A2A2A),
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (context) {
//         final emojis = [
//           '😀', '😃', '😄', '😁', '😆', '😅', '😂', '🤣',
//           '😊', '😇', '🙂', '🙃', '😉', '😌', '😍', '🥰',
//           '😘', '😗', '😙', '😚', '😋', '😛', '😝', '😜',
//           '🤪', '🤨', '🧐', '🤓', '😎', '🤩', '🥳', '😏',
//           '😒', '😞', '😔', '😟', '😕', '🙁', '☹️', '😣',
//           '😖', '😫', '😩', '🥺', '😢', '😭', '😤', '😠',
//           '👍', '👎', '👌', '✌️', '🤞', '🤟', '🤘', '🤙',
//           '👈', '👉', '👆', '🖕', '👇', '☝️', '👋', '🤚',
//           '❤️', '🧡', '💛', '💚', '💙', '💜', '🖤', '🤍',
//           '💔', '❣️', '💕', '💞', '💓', '💗', '💖', '💘',
//         ];
//
//         return Container(
//           height: 300,
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             children: [
//               Container(
//                 width: 40,
//                 height: 4,
//                 decoration: BoxDecoration(
//                   color: Colors.grey,
//                   borderRadius: BorderRadius.circular(2),
//                 ),
//               ),
//               const SizedBox(height: 16),
//               const Text(
//                 'Select Emoji',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 18,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               const SizedBox(height: 16),
//               Expanded(
//                 child: GridView.builder(
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 8,
//                     childAspectRatio: 1,
//                   ),
//                   itemCount: emojis.length,
//                   itemBuilder: (context, index) {
//                     return GestureDetector(
//                       onTap: () {
//                         _messageController.text += emojis[index];
//                         _messageController.selection = TextSelection.fromPosition(
//                           TextPosition(offset: _messageController.text.length),
//                         );
//                         Navigator.pop(context);
//                       },
//                       child: Container(
//                         margin: const EdgeInsets.all(4),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: Center(
//                           child: Text(
//                             emojis[index],
//                             style: const TextStyle(fontSize: 24),
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   void _startVoiceRecording() async {
//     // Request microphone permission
//     final status = await Permission.microphone.request();
//     if (status != PermissionStatus.granted) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Microphone permission is required to record audio'),
//           backgroundColor: Colors.red,
//         ),
//       );
//       return;
//     }
//
//     try {
//       // Start recording
//       final directory = await getTemporaryDirectory();
//       final path = '${directory.path}/voice_message_${DateTime.now().millisecondsSinceEpoch}.m4a';
//
//       await _audioRecorder?.start(RecordConfig(), path: path);
//
//       setState(() {
//         _isRecording = true;
//         _recordingSeconds = 0;
//         _audioPath = path;
//       });
//
//       // Start timer to update recording duration
//       _recordingTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
//         setState(() {
//           _recordingSeconds++;
//         });
//       });
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Failed to start recording: $e'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }
//
//   void _stopRecording() {
//     _recordingTimer?.cancel();
//     _audioRecorder?.stop();
//     setState(() {
//       _isRecording = false;
//     });
//   }
//
//   void _stopRecordingAndSend() async {
//     _stopRecording();
//
//     if (_audioPath != null) {
//       setState(() {
//         messages.add(ChatMessage(
//           text: "Voice message",
//           isMe: true,
//           time: "",
//           timestamp: _getCurrentTime(),
//           audioPath: _audioPath!,
//         ));
//       });
//       _scrollToBottom();
//     }
//   }
//
//   void _showCameraOptions() {
//     showModalBottomSheet(
//       context: context,
//       backgroundColor: const Color(0xFF2A2A2A),
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (context) {
//         return Container(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Container(
//                 width: 40,
//                 height: 4,
//                 decoration: BoxDecoration(
//                   color: Colors.grey,
//                   borderRadius: BorderRadius.circular(2),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               const Text(
//                 'Add Photo',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 18,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   // Camera option
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.pop(context);
//                       _takePhoto();
//                     },
//                     child: Column(
//                       children: [
//                         Container(
//                           width: 60,
//                           height: 60,
//                           decoration: BoxDecoration(
//                             color: const Color(0xFFFF9500),
//                             borderRadius: BorderRadius.circular(30),
//                           ),
//                           child: const Icon(
//                             Icons.camera_alt,
//                             color: Colors.white,
//                             size: 30,
//                           ),
//                         ),
//                         const SizedBox(height: 8),
//                         const Text(
//                           'Camera',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 14,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   // Gallery option
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.pop(context);
//                       _pickFromGallery();
//                     },
//                     child: Column(
//                       children: [
//                         Container(
//                           width: 60,
//                           height: 60,
//                           decoration: BoxDecoration(
//                             color: const Color(0xFF8B5CF6),
//                             borderRadius: BorderRadius.circular(30),
//                           ),
//                           child: const Icon(
//                             Icons.photo_library,
//                             color: Colors.white,
//                             size: 30,
//                           ),
//                         ),
//                         const SizedBox(height: 8),
//                         const Text(
//                           'Gallery',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 14,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   void _showAttachmentOptions() {
//     showModalBottomSheet(
//       context: context,
//       backgroundColor: const Color(0xFF2A2A2A),
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (context) {
//         return Container(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Container(
//                 width: 40,
//                 height: 4,
//                 decoration: BoxDecoration(
//                   color: Colors.grey,
//                   borderRadius: BorderRadius.circular(2),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               const Text(
//                 'Send Attachment',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 18,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Wrap(
//                 spacing: 20,
//                 children: [
//                   // Document option
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.pop(context);
//                       _pickDocument();
//                     },
//                     child: Column(
//                       children: [
//                         Container(
//                           width: 60,
//                           height: 60,
//                           decoration: BoxDecoration(
//                             color: const Color(0xFF10B981),
//                             borderRadius: BorderRadius.circular(30),
//                           ),
//                           child: const Icon(
//                             Icons.description,
//                             color: Colors.white,
//                             size: 30,
//                           ),
//                         ),
//                         const SizedBox(height: 8),
//                         const Text(
//                           'Document',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 14,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   // Location option
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.pop(context);
//                       _sendLocation();
//                     },
//                     child: Column(
//                       children: [
//                         Container(
//                           width: 60,
//                           height: 60,
//                           decoration: BoxDecoration(
//                             color: const Color(0xFFEF4444),
//                             borderRadius: BorderRadius.circular(30),
//                           ),
//                           child: const Icon(
//                             Icons.location_on,
//                             color: Colors.white,
//                             size: 30,
//                           ),
//                         ),
//                         const SizedBox(height: 8),
//                         const Text(
//                           'Location',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 14,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   // Contact option
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.pop(context);
//                       _sendContact();
//                     },
//                     child: Column(
//                       children: [
//                         Container(
//                           width: 60,
//                           height: 60,
//                           decoration: BoxDecoration(
//                             color: const Color(0xFF8B5CF6),
//                             borderRadius: BorderRadius.circular(30),
//                           ),
//                           child: const Icon(
//                             Icons.contact_page,
//                             color: Colors.white,
//                             size: 30,
//                           ),
//                         ),
//                         const SizedBox(height: 8),
//                         const Text(
//                           'Contact',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 14,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   void _takePhoto() async {
//     // Request camera permission
//     final status = await Permission.camera.request();
//     if (status != PermissionStatus.granted) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Camera permission is required to take photos'),
//           backgroundColor: Colors.red,
//         ),
//       );
//       return;
//     }
//
//     try {
//       final XFile? photo = await _imagePicker.pickImage(
//         source: ImageSource.camera,
//         imageQuality: 80,
//       );
//
//       if (photo != null) {
//         setState(() {
//           messages.add(ChatMessage(
//             text: "Photo",
//             isMe: true,
//             time: "",
//             timestamp: _getCurrentTime(),
//             imagePath: photo.path,
//           ));
//         });
//         _scrollToBottom();
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Failed to take photo: $e'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }
//
//   void _pickFromGallery() async {
//     try {
//       final XFile? image = await _imagePicker.pickImage(
//         source: ImageSource.gallery,
//         imageQuality: 80,
//       );
//
//       if (image != null) {
//         setState(() {
//           messages.add(ChatMessage(
//             text: "Photo",
//             isMe: true,
//             time: "",
//             timestamp: _getCurrentTime(),
//             imagePath: image.path,
//           ));
//         });
//         _scrollToBottom();
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Failed to pick image: $e'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }
//   void _pickDocument() async {
//     // This is a placeholder for document picking functionality
//     // In a real app, you would use a file picker package
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         content: Text('Document picker would open here'),
//         backgroundColor: Colors.blue,
//       ),
//     );
//   }
//
//   void _sendLocation() async {
//     // This is a placeholder for location sharing functionality
//     setState(() {
//       messages.add(ChatMessage(
//         text: "📍 My Location",
//         isMe: true,
//         time: "",
//         timestamp: _getCurrentTime(),
//       ));
//     });
//     _scrollToBottom();
//   }
//
//   void _sendContact() async {
//     // This is a placeholder for contact sharing functionality
//     setState(() {
//       messages.add(ChatMessage(
//         text: "👤 Contact Shared",
//         isMe: true,
//         time: "",
//         timestamp: _getCurrentTime(),
//       ));
//     });
//     _scrollToBottom();
//   }
//
//   final List<PremiumGift> _premiumGifts = [
//     PremiumGift('Rose', '🌹', 10),
//     PremiumGift('Chocolate', '🍫', 20),
//     PremiumGift('Diamond', '💎', 50),
//     PremiumGift('Crown', '👑', 100),
//     PremiumGift('Car', '🚗', 200),
//     PremiumGift('Yacht', '🛥️', 500),
//   ];
//
//   void _showPremiumGifts() {
//     showModalBottomSheet(
//       context: context,
//       backgroundColor: const Color(0xFF2A2A2A),
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       isScrollControlled: true,
//       builder: (context) {
//         return Container(
//           height: MediaQuery.of(context).size.height * 0.7,
//           padding: const EdgeInsets.all(24),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 width: 40,
//                 height: 4,
//                 decoration: BoxDecoration(
//                   color: Colors.grey,
//                   borderRadius: BorderRadius.circular(2),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Row(
//                 children: [
//                   Container(
//                     width: 48,
//                     height: 48,
//                     decoration: BoxDecoration(
//                       color: const Color(0xFFFF9500).withOpacity(0.2),
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: const Icon(
//                       Icons.card_giftcard,
//                       color: Color(0xFFFF9500),
//                       size: 24,
//                     ),
//                   ),
//                   const SizedBox(width: 16),
//                   const Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Request Premium Gifts',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 20,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                         Text(
//                           'Request gifts from your audience',
//                           style: TextStyle(
//                             color: Colors.grey,
//                             fontSize: 14,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 24),
//
//               // Premium Gifts Grid
//               Expanded(
//                 child: GridView.builder(
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 3,
//                     childAspectRatio: 0.8,
//                     crossAxisSpacing: 16,
//                     mainAxisSpacing: 16,
//                   ),
//                   itemCount: _premiumGifts.length,
//                   itemBuilder: (context, index) {
//                     final gift = _premiumGifts[index];
//                     return _buildGiftItem(gift);
//                   },
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   Widget _buildGiftItem(PremiumGift gift) {
//     return GestureDetector(
//       onTap: () => _requestPremiumGift(gift),
//       child: Container(
//         decoration: BoxDecoration(
//           color: const Color(0xFF1A1A1A),
//           borderRadius: BorderRadius.circular(16),
//           border: Border.all(
//             color: Colors.white.withOpacity(0.1),
//             width: 1,
//           ),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Gift Icon/Emoji
//             Container(
//               width: 48,
//               height: 48,
//               decoration: BoxDecoration(
//                 color: const Color(0xFFFF9500).withOpacity(0.2),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Center(
//                 child: Text(
//                   gift.emoji,
//                   style: const TextStyle(fontSize: 24),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 12),
//
//             // Gift Name
//             Text(
//               gift.name,
//               style: const TextStyle(
//                 color: Colors.white,
//                 fontSize: 12,
//                 fontWeight: FontWeight.w500,
//               ),
//               textAlign: TextAlign.center,
//               maxLines: 2,
//               overflow: TextOverflow.ellipsis,
//             ),
//             const SizedBox(height: 8),
//
//             // Price
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//               decoration: BoxDecoration(
//                 color: const Color(0xFFFF9500).withOpacity(0.2),
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   const Icon(Icons.monetization_on, color: Color(0xFFFF9500), size: 12),
//                   const SizedBox(width: 4),
//                   Text(
//                     gift.price.toString(),
//                     style: const TextStyle(
//                       color: Color(0xFFFF9500),
//                       fontSize: 10,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//             const SizedBox(height: 4),
//
//             // Request Label
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
//               decoration: BoxDecoration(
//                 color: const Color(0xFF10B981).withOpacity(0.2),
//                 borderRadius: BorderRadius.circular(6),
//               ),
//               child: const Text(
//                 'REQUEST',
//                 style: TextStyle(
//                   color: Color(0xFF10B981),
//                   fontSize: 8,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _requestPremiumGift(PremiumGift gift) {
//     Navigator.pop(context);
//
//     // Add gift request message to chat
//     setState(() {
//       messages.add(ChatMessage(
//         text: "Gift request",
//         isMe: true,
//         time: "",
//         timestamp: _getCurrentTime(),
//         isGiftRequest: true,
//         giftName: gift.name,
//         giftPrice: gift.price,
//       ));
//     });
//     _scrollToBottom();
//
//     // Show success notification
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('${gift.name} requested! User needs to pay ${gift.price} coins to unlock.'),
//         backgroundColor: const Color(0xFF10B981),
//         duration: const Duration(seconds: 3),
//       ),
//     );
//   }
// }

// Supporting classes
class ChatMessage {
  final String text;
  final bool isMe;
  final String time;
  final String timestamp;
  final String? imagePath;
  final String? audioPath;
  final bool isGiftRequest;
  final String? giftName;
  final int? giftPrice;

  ChatMessage({
    required this.text,
    required this.isMe,
    required this.time,
    required this.timestamp,
    this.imagePath,
    this.audioPath,
    this.isGiftRequest = false,
    this.giftName,
    this.giftPrice,
  });
}
// class ChatItem {
//   final String name;
//   final String message;
//   final String time;
//   final String avatar;
//   final bool isOnline;
//   final int unreadCount;
//   final Color avatarColor;
//
//   ChatItem({
//     required this.name,
//     required this.message,
//     required this.time,
//     required this.avatar,
//     required this.isOnline,
//     required this.unreadCount,
//     required this.avatarColor,
//   });
// }

class ExclusiveContent {
  final String title;
  final int price;

  ExclusiveContent({required this.title, required this.price});
}

class PremiumGift {
  final String name;
  final String emoji;
  final int price;

  PremiumGift(this.name, this.emoji, this.price);
}
// class PremiumGift {
//   final String name;
//   final String emoji;
//   final int price;
//
//   PremiumGift({
//     required this.name,
//     required this.emoji,
//     required this.price,
//   });
// }
//
// // List of premium gifts
// final List<PremiumGift> _premiumGifts = [
//   PremiumGift(name: 'Rose', emoji: '🌹', price: 50),
//   PremiumGift(name: 'Bikini', emoji: '👙', price: 100),
//   PremiumGift(name: 'Kiss', emoji: '💋', price: 75),
//   PremiumGift(name: 'Heart', emoji: '❤️', price: 25),
//   PremiumGift(name: 'Diamond', emoji: '💎', price: 200),
//   PremiumGift(name: 'Crown', emoji: '👑', price: 150),
//   PremiumGift(name: 'Champagne', emoji: '🍾', price: 125),
//   PremiumGift(name: 'Fire', emoji: '🔥', price: 80),
//   PremiumGift(name: 'Star', emoji: '⭐', price: 60),
// ];
//
// // Data model for exclusive content (for sharing)
// class ExclusiveContent {
//   final String id;
//   final String title;
//   final String type;
//   final String thumbnail;
//   final int price;
//   final int views;
//   final int earnings;
//   final DateTime uploadDate;
//
//   ExclusiveContent({
//     required this.id,
//     required this.title,
//     required this.type,
//     required this.thumbnail,
//     required this.price,
//     required this.views,
//     required this.earnings,
//     required this.uploadDate,
//   });
// }
