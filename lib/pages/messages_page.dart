import 'package:flutter/material.dart';
import '../Model/ChatUser.dart';
import '../Model/chatitem.dart';
import '../Service/Chats/UserList.dart';
import '../widgets/bottom_nav_bar.dart';
import '../utils/notification_helper.dart';
import 'package:flutter/material.dart';

import 'dart:math';
import 'package:flutter/material.dart';


class MessagesPage extends StatefulWidget {
  const MessagesPage({super.key});

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  int _currentIndex = 1;
  final TextEditingController _searchController = TextEditingController();
  final UserList _chatService = UserList();

  List<ChatUser> _users = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  void fetchUsers() async {
    try {
      final users = await _chatService.getAvailableUsers();
      setState(() {
        _users = users.map<ChatUser>((json) => ChatUser.fromJson(json)).toList();
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      print("❌ Error: $e");
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final baseSize = min(size.width, size.height);
    final padding = baseSize * 0.04;
    final avatarSize = baseSize * 0.12;
    final fontSize = baseSize * 0.045;

    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pushNamedAndRemoveUntil(
            context,
            '/dashboard',
                (route) => false,
          ),
        ),
        title: Text(
          'Messages',
          style: TextStyle(
            color: Colors.white,
            fontSize: fontSize,
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            margin: EdgeInsets.all(padding),
            decoration: BoxDecoration(
              color: const Color(0xFF2A2A2A),
              borderRadius: BorderRadius.circular(baseSize * 0.03),
            ),
            child: TextField(
              controller: _searchController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Discover Your Hive',
                hintStyle: TextStyle(color: Colors.grey, fontSize: baseSize * 0.035),
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: baseSize * 0.04,
                  vertical: baseSize * 0.015,
                ),
              ),
            ),
          ),

          // User List with last message + time
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator(color: Colors.orange))
                : ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: padding),
              itemCount: _users.length,
              itemBuilder: (context, index) {
                final user = _users[index];
                return _buildChatItem(user, avatarSize, fontSize, baseSize);
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
      ),
    );
  }

  Widget _buildChatItem(ChatUser user, double avatarSize, double fontSize, double baseSize) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/chat_conversation',
          arguments: user, // ✅ Pass the selected user to chat screen
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: baseSize * 0.02),
        padding: EdgeInsets.all(baseSize * 0.04),
        decoration: BoxDecoration(
          color: const Color(0xFF2A2A2A),
          borderRadius: BorderRadius.circular(baseSize * 0.03),
        ),
        child: Row(
          children: [
            // Avatar
            Stack(
              children: [
                Container(
                  width: avatarSize,
                  height: avatarSize,
                  decoration: BoxDecoration(
                    color: user.avatarColor,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      user.initials,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: avatarSize * 0.4,
                      ),
                    ),
                  ),
                ),
                // ✅ Online dot (dummy)
                Positioned(
                  right: 2,
                  bottom: 2,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFF2A2A2A), width: 2),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(width: baseSize * 0.03),

            // Chat Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name + Time
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        user.displayName,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: fontSize,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        "10:24 AM", // ✅ Dummy time
                        style: TextStyle(color: Colors.grey, fontSize: fontSize * 0.7),
                      ),
                    ],
                  ),
                  SizedBox(height: baseSize * 0.01),

                  // Last message + Unread
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Hey there! 😊", // ✅ Dummy last message
                          style: TextStyle(color: Colors.grey, fontSize: fontSize * 0.8),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 8),
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: const BoxDecoration(
                          color: Color(0xFFFF9500),
                          shape: BoxShape.circle,
                        ),
                        child: const Text(
                          "2", // ✅ Dummy unread count
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class MessagesPage extends StatefulWidget {
//   const MessagesPage({super.key});
//
//   @override
//   State<MessagesPage> createState() => _MessagesPageState();
// }
//
// class _MessagesPageState extends State<MessagesPage> {
//   int _currentIndex = 1; // Messages is index 1
//   final TextEditingController _searchController = TextEditingController();
//
//   final List<ChatItem> _chats = [
//     ChatItem(
//       name: 'Sophia Carter',
//       message: 'Hey there! 😊',
//       time: '10:24 AM',
//       avatar: 'SC',
//       isOnline: true,
//       unreadCount: 2,
//       avatarColor: const Color(0xFF8B5CF6),
//     ),
//     ChatItem(
//       name: 'Ethan Bennett',
//       message: 'Just sent you the files',
//       time: '10:24 AM',
//       avatar: 'EB',
//       isOnline: false,
//       unreadCount: 0,
//       avatarColor: const Color(0xFF06B6D4),
//     ),
//     ChatItem(
//       name: 'Olivia Hayes',
//       message: 'Thanks for the feedback!',
//       time: '9:30 PM',
//       avatar: 'OH',
//       isOnline: true,
//       unreadCount: 1,
//       avatarColor: const Color(0xFF10B981),
//     ),
//     ChatItem(
//       name: 'Liam Foster',
//       message: 'Let\'s schedule a call',
//       time: '3:30 PM',
//       avatar: 'LF',
//       isOnline: false,
//       unreadCount: 2,
//       avatarColor: const Color(0xFFF59E0B),
//     ),
//   ];
//
//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF1A1A1A),
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF1A1A1A),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () => Navigator.pushNamedAndRemoveUntil(
//             context,
//             '/dashboard',
//             (route) => false,
//           ),
//         ),
//         title: const Text(
//           'Messages',
//           style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
//         ),
//         actions: [],
//         elevation: 0,
//       ),
//       body: Column(
//         children: [
//           // Search Bar
//           Container(
//             margin: const EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               color: const Color(0xFF2A2A2A),
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: TextField(
//               controller: _searchController,
//               style: const TextStyle(color: Colors.white),
//               decoration: InputDecoration(
//                 hintText: 'Discover Your Hive',
//                 hintStyle: const TextStyle(color: Colors.grey),
//                 prefixIcon: const Icon(Icons.search, color: Colors.grey),
//                 border: InputBorder.none,
//                 contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//               ),
//             ),
//           ),
//
//           // Chat List
//           Expanded(
//             child: ListView.builder(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               itemCount: _chats.length,
//               itemBuilder: (context, index) {
//                 final chat = _chats[index];
//                 return _buildChatItem(chat, index);
//               },
//             ),
//           ),
//         ],
//       ),
//       bottomNavigationBar: BottomNavBar(
//         currentIndex: _currentIndex,
//         onTap: (index) {
//           setState(() {
//             _currentIndex = index;
//           });
//         },
//       ),
//     );
//   }
//
//   Widget _buildChatItem(ChatItem chat, int index) {
//     return Dismissible(
//       key: Key(chat.name + index.toString()),
//       direction: DismissDirection.endToStart,
//       background: Container(
//         margin: const EdgeInsets.only(bottom: 8),
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         decoration: BoxDecoration(
//           color: Colors.red,
//           borderRadius: BorderRadius.circular(12),
//         ),
//         alignment: Alignment.centerRight,
//         child: const Icon(
//           Icons.delete,
//           color: Colors.white,
//           size: 28,
//         ),
//       ),
//       confirmDismiss: (direction) async {
//         return await showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return AlertDialog(
//               backgroundColor: const Color(0xFF2A2A2A),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               title: const Text(
//                 'Delete Chat',
//                 style: TextStyle(color: Colors.white),
//               ),
//               content: Text(
//                 'Are you sure you want to delete this chat with ${chat.name}?',
//                 style: const TextStyle(color: Colors.grey),
//               ),
//               actions: [
//                 TextButton(
//                   onPressed: () => Navigator.of(context).pop(false),
//                   child: const Text(
//                     'Cancel',
//                     style: TextStyle(color: Color(0xFFFF9500)),
//                   ),
//                 ),
//                 TextButton(
//                   onPressed: () => Navigator.of(context).pop(true),
//                   child: const Text(
//                     'Delete',
//                     style: TextStyle(color: Colors.red),
//                   ),
//                 ),
//               ],
//             );
//           },
//         );
//       },
//       onDismissed: (direction) {
//         setState(() {
//           _chats.removeAt(index);
//         });
//         NotificationHelper.showDeleteNotification(context, 'Chat with ${chat.name} deleted');
//       },
//       child: GestureDetector(
//         onTap: () {
//           Navigator.pushNamed(context, '/chat_conversation', arguments: chat);
//         },
//         child: Container(
//           margin: const EdgeInsets.only(bottom: 8),
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: const Color(0xFF2A2A2A),
//             borderRadius: BorderRadius.circular(12),
//           ),
//         child: Row(
//           children: [
//             // Avatar with online indicator
//             Stack(
//               children: [
//                 Container(
//                   width: 50,
//                   height: 50,
//                   decoration: BoxDecoration(
//                     color: chat.avatarColor,
//                     shape: BoxShape.circle,
//                   ),
//                   child: Center(
//                     child: Text(
//                       chat.avatar,
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.w600,
//                         fontSize: 16,
//                       ),
//                     ),
//                   ),
//                 ),
//                 if (chat.isOnline)
//                   Positioned(
//                     right: 2,
//                     bottom: 2,
//                     child: Container(
//                       width: 12,
//                       height: 12,
//                       decoration: BoxDecoration(
//                         color: const Color(0xFF10B981),
//                         shape: BoxShape.circle,
//                         border: Border.all(color: const Color(0xFF2A2A2A), width: 2),
//                       ),
//                     ),
//                   ),
//               ],
//             ),
//
//             const SizedBox(width: 12),
//
//             // Chat info
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         chat.name,
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.w600,
//                           fontSize: 16,
//                         ),
//                       ),
//                       Text(
//                         chat.time,
//                         style: const TextStyle(
//                           color: Colors.grey,
//                           fontSize: 12,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 4),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: Text(
//                           chat.message,
//                           style: const TextStyle(
//                             color: Colors.grey,
//                             fontSize: 14,
//                           ),
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                       if (chat.unreadCount > 0)
//                         Container(
//                           margin: const EdgeInsets.only(left: 8),
//                           padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
//                           decoration: const BoxDecoration(
//                             color: Color(0xFFFF9500),
//                             shape: BoxShape.circle,
//                           ),
//                           child: Text(
//                             chat.unreadCount.toString(),
//                             style: const TextStyle(
//                               color: Colors.white,
//                               fontSize: 12,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildBottomBar() {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//       decoration: const BoxDecoration(
//         color: Color(0xFF2A2A2A),
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(20),
//           topRight: Radius.circular(20),
//         ),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           _buildBottomBarItem(Icons.home_outlined, false),
//           _buildBottomBarItem(Icons.email_outlined, false),
//           _buildBottomBarItem(Icons.phone_outlined, false),
//           _buildBottomBarItem(Icons.grid_view_outlined, false),
//           GestureDetector(
//             onTap: () => Navigator.pushNamed(context, '/new_post'),
//             child: Container(
//               padding: const EdgeInsets.all(12),
//               decoration: const BoxDecoration(
//                 color: Color(0xFFFF9500),
//                 shape: BoxShape.circle,
//               ),
//               child: const Icon(
//                 Icons.add,
//                 color: Colors.white,
//                 size: 24,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildBottomBarItem(IconData icon, bool isActive) {
//     return Container(
//       padding: const EdgeInsets.all(8),
//       child: Icon(
//         icon,
//         color: isActive ? const Color(0xFFFF9500) : Colors.grey,
//         size: 24,
//       ),
//     );
//   }
// }

