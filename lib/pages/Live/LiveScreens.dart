import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
// live_streaming_page.dart
import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:permission_handler/permission_handler.dart';

class LiveStreamingPage extends StatefulWidget {
  final bool isHost;

  const LiveStreamingPage({Key? key, required this.isHost}) : super(key: key);

  @override
  State<LiveStreamingPage> createState() => _LiveStreamingPageState();
}

class _LiveStreamingPageState extends State<LiveStreamingPage> {
  final String appId = "YOUR_AGORA_APP_ID";
  final String channelName = "live_channel_123";
  final String token = "YOUR_TOKEN"; // Get from backend in production

  bool _isMuted = false;
  bool _isVideoEnabled = true;
  bool _isFrontCamera = true;
  int? _remoteUid;
  bool _isJoined = false;
  RtcEngine? _agoraEngine;
  List<int> _remoteUsers = [];

  @override
  void initState() {
    super.initState();
    _initAgora();
  }

  Future<void> _initAgora() async {
    _agoraEngine = createAgoraRtcEngine();
    await _agoraEngine!.initialize(RtcEngineContext(appId: appId));

    _agoraEngine!.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          setState(() {
            _isJoined = true;
          });
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          setState(() {
            _remoteUid = remoteUid;
            _remoteUsers.add(remoteUid);
          });
        },
        onUserOffline: (RtcConnection connection, int remoteUid, UserOfflineReasonType reason) {
          setState(() {
            _remoteUsers.remove(remoteUid);
          });
        },
        onError: (ErrorCodeType err, String msg) {
          print('Error: $err, $msg');
        },
      ),
    );

    await _agoraEngine!.enableVideo();
    await _agoraEngine!.startPreview();

    VideoEncoderConfiguration configuration = const VideoEncoderConfiguration(
      dimensions: VideoDimensions(width: 640, height: 360),
      frameRate: 15,
      bitrate: 0,
    );
    await _agoraEngine!.setVideoEncoderConfiguration(configuration);

    await _joinChannel();
  }

  Future<void> _joinChannel() async {
    await [Permission.microphone, Permission.camera].request();

    await _agoraEngine!.setChannelProfile(ChannelProfileType.channelProfileLiveBroadcasting);

    if (widget.isHost) {
      await _agoraEngine!.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    } else {
      await _agoraEngine!.setClientRole(role: ClientRoleType.clientRoleAudience);
    }

    await _agoraEngine!.joinChannel(
      token: token,
      channelId: channelName,
      uid: 0,
      options: const ChannelMediaOptions(),
    );
  }

  Future<void> _leaveChannel() async {
    await _agoraEngine!.leaveChannel();
    setState(() {
      _isJoined = false;
      _remoteUsers.clear();
    });
  }

  void _switchCamera() {
    _agoraEngine!.switchCamera().then((value) {
      setState(() {
        _isFrontCamera = !_isFrontCamera;
      });
    }).catchError((err) {
      print('Error switching camera: $err');
    });
  }

  void _toggleMute() {
    setState(() {
      _isMuted = !_isMuted;
    });
    _agoraEngine!.muteLocalAudioStream(_isMuted);
  }

  void _toggleVideo() {
    setState(() {
      _isVideoEnabled = !_isVideoEnabled;
    });
    _agoraEngine!.muteLocalVideoStream(!_isVideoEnabled);
  }

  @override
  void dispose() {
    _agoraEngine?.leaveChannel();
    _agoraEngine?.release();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Video views
          _buildVideoView(),

          // Header with live info
          _buildHeader(),

          // Bottom controls
          _buildControls(),

          // Comments/Interactions overlay
          if (!widget.isHost) _buildInteractionsOverlay(),

          // Host-specific controls
          if (widget.isHost) _buildHostControls(),
        ],
      ),
    );
  }

  Widget _buildVideoView() {
    if (widget.isHost) {
      // Host view - show local preview
      return AgoraVideoView(
        controller: VideoViewController(
          rtcEngine: _agoraEngine!,
          canvas: const VideoCanvas(uid: 0),
        ),
      );
    } else {
      // Audience view - show remote stream
      if (_remoteUsers.isNotEmpty) {
        return AgoraVideoView(
          controller: VideoViewController.remote(
            rtcEngine: _agoraEngine!,
            canvas: VideoCanvas(uid: _remoteUsers.first),
            connection: RtcConnection(channelId: channelName),
          ),
        );
      } else {
        return const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.red)),
              SizedBox(height: 16),
              Text(
                'Waiting for host to start the live...',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
        );
      }
    }
  }

  Widget _buildHeader() {
    return Positioned(
      top: 40,
      left: 16,
      right: 16,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              children: [
                Icon(Icons.circle, color: Colors.white, size: 12),
                SizedBox(width: 6),
                Text(
                  'LIVE',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          const Text(
            '1.2K viewers',
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.close, color: Colors.white, size: 28),
            onPressed: () {
              _leaveChannel();
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildControls() {
    return Positioned(
      bottom: 20,
      right: 16,
      child: Column(
        children: [
          // Camera switch (host only)
          if (widget.isHost)
            IconButton(
              icon: Icon(
                Icons.cameraswitch,
                color: Colors.white,
                size: 28,
              ),
              onPressed: _switchCamera,
            ),

          // Mute button (host only)
          if (widget.isHost)
            IconButton(
              icon: Icon(
                _isMuted ? Icons.mic_off : Icons.mic,
                color: Colors.white,
                size: 28,
              ),
              onPressed: _toggleMute,
            ),

          // Video toggle (host only)
          if (widget.isHost)
            IconButton(
              icon: Icon(
                _isVideoEnabled ? Icons.videocam : Icons.videocam_off,
                color: Colors.white,
                size: 28,
              ),
              onPressed: _toggleVideo,
            ),

          // Like button
          IconButton(
            icon: const Icon(Icons.favorite_border, color: Colors.white, size: 28),
            onPressed: () {
              // Send like to host
            },
          ),

          // Comment button
          IconButton(
            icon: const Icon(Icons.comment, color: Colors.white, size: 28),
            onPressed: () {
              _showCommentDialog();
            },
          ),

          // Share button
          IconButton(
            icon: const Icon(Icons.share, color: Colors.white, size: 28),
            onPressed: () {
              // Share live stream
            },
          ),
        ],
      ),
    );
  }

  Widget _buildInteractionsOverlay() {
    return Positioned(
      left: 16,
      bottom: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Live comments
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            height: 200,
            child: ListView(
              reverse: true,
              children: [
                _buildCommentItem('User123', 'This is amazing! ❤️'),
                _buildCommentItem('LiveFan', 'Wow, great content!'),
                _buildCommentItem('Viewer456', 'Hello from Spain!'),
              ],
            ),
          ),

          // Live reactions (hearts animation)
          // You would implement a animation controller for floating hearts
        ],
      ),
    );
  }

  Widget _buildCommentItem(String username, String comment) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(20),
      ),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '$username: ',
              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            TextSpan(
              text: comment,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHostControls() {
    return Positioned(
      bottom: 20,
      left: 16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Viewers count
          const Text(
            '1.2K viewers',
            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),

          // Live duration
          const Text(
            '01:23:45',
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
          const SizedBox(height: 20),

          // End live button
          GestureDetector(
            onTap: () {
              _showEndLiveConfirmation();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'END LIVE',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showCommentDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Live Comments',
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Type a comment...',
                  hintStyle: const TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.grey[800],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: () {
                      // Send comment
                      Navigator.pop(context);
                    },
                  ),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView(
                  children: [
                    _buildCommentItem('User123', 'This is amazing! ❤️'),
                    _buildCommentItem('LiveFan', 'Wow, great content!'),
                    _buildCommentItem('Viewer456', 'Hello from Spain!'),
                    _buildCommentItem('StreamLover', 'How often do you go live?'),
                    _buildCommentItem('User789', 'Can you show us that again?'),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showEndLiveConfirmation() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF2A2A2A),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text(
            'End Live Stream',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          content: const Text(
            'Are you sure you want to end the live stream?',
            style: TextStyle(color: Colors.grey),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.white),
              ),
            ),
            TextButton(
              onPressed: () {
                _leaveChannel();
                Navigator.pop(context); // Close dialog
                Navigator.pop(context); // Close live screen
              },
              child: const Text(
                'End Live',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}