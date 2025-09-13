# WebSocket Implementation for Flutter App

This document provides a comprehensive guide for the WebSocket implementation in your Flutter app, enabling real-time messaging between web and mobile users.

## Overview

The WebSocket implementation includes:
- **Real-time chat messaging** between web users and mobile app users
- **Live wallet balance updates** and transaction notifications
- **Typing indicators** and connection status
- **Automatic reconnection** and error handling
- **Provider-based state management** for reactive UI updates

## Architecture

```
┌─────────────────┐    WebSocket    ┌─────────────────┐
│   Web App       │◄──────────────►│   Backend       │
│   (Next.js)     │                 │   (Node.js)     │
└─────────────────┘                 └─────────────────┘
                                            ▲
                                            │ WebSocket
                                            ▼
                                   ┌─────────────────┐
                                   │   Flutter App   │
                                   │   (Mobile)      │
                                   └─────────────────┘
```

## File Structure

```
lib/
├── models/
│   ├── websocket_message.dart      # Message and User models
│   └── wallet_models.dart          # Wallet balance and transaction models
├── services/
│   ├── websocket_service.dart      # Base WebSocket service
│   ├── chat_websocket_service.dart # Chat-specific WebSocket service
│   └── wallet_websocket_service.dart # Wallet-specific WebSocket service
├── providers/
│   ├── chat_websocket_provider.dart    # Chat state management
│   └── wallet_websocket_provider.dart  # Wallet state management
├── utils/
│   └── websocket_constants.dart    # Constants and event names
├── pages/
│   ├── websocket_messages_page.dart        # WebSocket-enabled messages list
│   ├── websocket_chat_conversation_page.dart # WebSocket-enabled chat
│   ├── websocket_wallet_page.dart          # WebSocket-enabled wallet
│   └── websocket_test_page.dart            # Testing interface
└── main.dart & appss.dart          # App initialization with providers
```

## Setup Instructions

### 1. Install Dependencies

The following dependencies have been added to `pubspec.yaml`:

```yaml
dependencies:
  socket_io_client: ^2.0.3+1
  provider: ^6.1.1
  shared_preferences: ^2.2.2
```

Run `flutter pub get` to install the dependencies.

### 2. Configure Backend URLs

Update the URLs in `lib/utils/websocket_constants.dart`:

```dart
class WebSocketConstants {
  // Update these URLs for your environment
  static const String baseUrl = 'http://localhost:3001'; // Development
  static const String socketUrl = 'http://localhost:3001'; // Development
  
  // Production URLs (update when deploying)
  // static const String baseUrl = 'https://your-production-domain.com';
  // static const String socketUrl = 'https://your-production-domain.com';
}
```

### 3. Update User Authentication

In the WebSocket services, replace the hardcoded user ID with your actual authentication system:

```dart
// In websocket_messages_page.dart, websocket_chat_conversation_page.dart, etc.
final currentUserId = "current-user-id"; // Replace with actual user ID from your auth service
```

## Usage

### 1. WebSocket-Enabled Pages

The following pages have been created with WebSocket functionality:

- **`/websocket_messages`** - Messages list with real-time connection status
- **`/websocket_chat_conversation`** - Chat conversation with real-time messaging
- **`/websocket_wallet`** - Wallet with real-time balance updates
- **`/websocket_test`** - Testing interface for WebSocket functionality

### 2. Navigation

To navigate to WebSocket-enabled pages:

```dart
// Navigate to WebSocket messages page
Navigator.pushNamed(context, '/websocket_messages');

// Navigate to WebSocket chat conversation
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const WebSocketChatConversationPage(),
    settings: RouteSettings(arguments: chatUser),
  ),
);

// Navigate to WebSocket wallet page
Navigator.pushNamed(context, '/websocket_wallet');

// Navigate to WebSocket test page
Navigator.pushNamed(context, '/websocket_test');
```

### 3. Using WebSocket Providers

Access WebSocket functionality in your widgets:

```dart
// In your widget
Consumer<ChatWebSocketProvider>(
  builder: (context, chatProvider, child) {
    return Text(
      chatProvider.isConnected ? 'Connected' : 'Disconnected',
      style: TextStyle(
        color: chatProvider.isConnected ? Colors.green : Colors.red,
      ),
    );
  },
)

// Send a message
await context.read<ChatWebSocketProvider>().sendMessage(recipientId, message);

// Get wallet balance
final balance = context.read<WalletWebSocketProvider>().balance;
```

## WebSocket Events

### Chat Events (Namespace: `/chat`)

**Outgoing Events:**
- `user:register` - Register user with WebSocket
- `room:join` - Join a chat room
- `typing:start` - Start typing indicator
- `typing:stop` - Stop typing indicator
- `heartbeat` - Send heartbeat

**Incoming Events:**
- `chat:connected` - Chat service connected
- `message:received` - New message received
- `media:received` - New media message received
- `room:joined` - Successfully joined room
- `typing:start` - User started typing
- `typing:stop` - User stopped typing
- `message:error` - Message error

### Wallet Events (Namespace: `/wallet`)

**Outgoing Events:**
- `user:register` - Register user with WebSocket
- `heartbeat` - Send heartbeat

**Incoming Events:**
- `wallet:connected` - Wallet service connected
- `balance:updated` - Balance updated
- `transaction:added` - New transaction added
- `payment:notification` - Payment notification
- `wallet:updated` - General wallet update

## Testing

### 1. Using the Test Page

Navigate to `/websocket_test` to access the testing interface:

- **Connection Status**: Shows real-time connection status for both chat and wallet
- **User ID Input**: Change the test user ID
- **Chat Test**: Send test messages and load message history
- **Wallet Test**: Fetch balance and transactions
- **Messages Display**: Shows real-time received messages

### 2. Manual Testing

1. **Start your backend server** (Node.js with WebSocket support)
2. **Run the Flutter app** in debug mode
3. **Navigate to `/websocket_test`**
4. **Check connection status** - should show green indicators
5. **Send test messages** and verify they appear in real-time
6. **Test wallet functionality** by fetching balance and transactions

### 3. Integration Testing

1. **Open web app** in browser
2. **Open Flutter app** on device/emulator
3. **Send messages from web to mobile** - should appear instantly
4. **Send messages from mobile to web** - should appear instantly
5. **Test wallet updates** - balance changes should reflect in real-time

## Error Handling

The WebSocket implementation includes comprehensive error handling:

- **Connection errors** are displayed to users
- **Automatic reconnection** on network issues
- **Retry mechanisms** for failed operations
- **User-friendly error messages**

## Performance Considerations

- **Message deduplication** prevents duplicate messages
- **Efficient state management** with Provider
- **Automatic cleanup** on widget disposal
- **Connection pooling** for multiple WebSocket connections

## Security

- **JWT token authentication** for WebSocket connections
- **User session management** with Redis
- **Rate limiting** to prevent abuse
- **Input validation** for all messages

## Troubleshooting

### Common Issues

1. **Connection Failed**
   - Check backend server is running
   - Verify WebSocket URLs are correct
   - Check network connectivity

2. **Messages Not Received**
   - Verify user is registered with WebSocket
   - Check room joining functionality
   - Verify event listeners are set up

3. **Authentication Errors**
   - Check JWT token is valid
   - Verify token is included in WebSocket connection
   - Check user permissions

### Debug Information

Enable debug logging by checking the console output:

```
✅ WebSocket connected to /chat with socket ID: abc123
📨 Message received: {...}
💰 Balance updated: {...}
❌ WebSocket connection error: {...}
```

## Production Deployment

### 1. Update URLs

Change the URLs in `websocket_constants.dart` to your production domain:

```dart
static const String baseUrl = 'https://your-production-domain.com';
static const String socketUrl = 'https://your-production-domain.com';
```

### 2. Configure CORS

Ensure your backend allows WebSocket connections from your Flutter app domain.

### 3. SSL/TLS

Use secure WebSocket connections (wss://) in production.

### 4. Monitoring

Set up monitoring for:
- WebSocket connection health
- Message delivery rates
- Error rates and types
- Performance metrics

## API Integration

The WebSocket implementation works alongside your existing HTTP API:

- **Send messages**: Use HTTP API (`POST /api/chat/personal/messages`)
- **Receive messages**: Use WebSocket (`message:received` event)
- **Get wallet balance**: Use HTTP API (`GET /api/wallet/balance`)
- **Receive balance updates**: Use WebSocket (`balance:updated` event)

## Next Steps

1. **Test the implementation** with your backend
2. **Customize the UI** to match your app's design
3. **Add push notifications** for offline message delivery
4. **Implement media sharing** via WebSocket
5. **Add message encryption** for security
6. **Optimize performance** based on usage patterns

## Support

For issues or questions:
1. Check the console logs for error messages
2. Use the test page to verify WebSocket functionality
3. Verify backend WebSocket implementation
4. Check network connectivity and firewall settings

The WebSocket implementation provides a robust foundation for real-time communication between your web and mobile applications.
