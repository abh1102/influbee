import 'package:flutter/material.dart';
import '../widgets/influbee_coin.dart';
import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:permission_handler/permission_handler.dart';

class InstantLivePage extends StatefulWidget {
  const InstantLivePage({super.key});

  @override
  State<InstantLivePage> createState() => _InstantLivePageState();
}

class _InstantLivePageState extends State<InstantLivePage> {
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  bool _isLoading = false;

  // Agora variables
  bool _isLive = false;
  RtcEngine? _agoraEngine;
  final String _appId = "YOUR_AGORA_APP_ID"; // Replace with your App ID
  String _channelName = "instant_live_${DateTime.now().millisecondsSinceEpoch}";
  int? _remoteUid;
  List<int> _remoteUsers = [];

  @override
  void initState() {
    super.initState();
    _initAgora();
  }

  @override
  void dispose() {
    _priceController.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    _disposeAgora();
    super.dispose();
  }

  // Agora initialization
  Future<void> _initAgora() async {
    _agoraEngine = createAgoraRtcEngine();
    await _agoraEngine!.initialize(RtcEngineContext(appId: _appId));

    // Register the event handler
    _agoraEngine!.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          debugPrint("Local user ${connection.localUid} joined");
          setState(() {
            _isLive = true;
          });
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          debugPrint("Remote user $remoteUid joined");
          setState(() {
            _remoteUid = remoteUid;
            _remoteUsers.add(remoteUid);
          });
        },
        onUserOffline: (RtcConnection connection, int remoteUid, UserOfflineReasonType reason) {
          debugPrint("Remote user $remoteUid left channel");
          setState(() {
            _remoteUsers.remove(remoteUid);
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

  // Start live stream with Agora
  Future<void> _startLiveStream() async {
    // Request microphone and camera permissions
    await [Permission.microphone, Permission.camera].request();

    // Enable video
    await _agoraEngine!.enableVideo();

    // Set channel profile to live broadcasting
    await _agoraEngine!.setChannelProfile(ChannelProfileType.channelProfileLiveBroadcasting);
    await _agoraEngine!.setClientRole(role: ClientRoleType.clientRoleBroadcaster);

    // Configure video encoder
    VideoEncoderConfiguration configuration = const VideoEncoderConfiguration(
      dimensions: VideoDimensions(width: 640, height: 360),
      frameRate: 15,
      bitrate: 0,
    );
    await _agoraEngine!.setVideoEncoderConfiguration(configuration);

    // Start preview
    await _agoraEngine!.startPreview();

    // Join channel
    await _agoraEngine!.joinChannel(
      token: "", // Use null for testing, in production use a token
      channelId: _channelName,
      uid: 0, // Let Agora assign a uid
      options: const ChannelMediaOptions(),
    );
  }

  // End live stream
  Future<void> _endLiveStream() async {
    await _agoraEngine!.leaveChannel();
    setState(() {
      _isLive = false;
      _remoteUsers.clear();
      _remoteUid = null;
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
        title: const Text(
          'Instant',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFFF9500).withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xFFFF9500).withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF9500).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.flash_on,
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
                          'Go Live Instantly!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'Set your price and start streaming right now',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Live Stream Details
            const Text(
              'Live Stream Details',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),

            // Title Input
            _buildInputField(
              controller: _titleController,
              label: 'Stream Title',
              hint: 'Enter your live stream title',
              icon: Icons.title,
            ),

            const SizedBox(height: 16),

            // Description Input
            _buildInputField(
              controller: _descriptionController,
              label: 'Description (Optional)',
              hint: 'Describe your live stream',
              icon: Icons.description,
              maxLines: 3,
            ),

            const SizedBox(height: 32),

            // Price Setting
            const Text(
              'Set Your Price',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'How much will viewers pay to join your live stream?',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 16),

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF2A2A2A),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.white.withOpacity(0.1),
                  width: 1,
                ),
              ),
              child: Column(
                children: [
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
                          Icons.monetization_on,
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
                              'Entry Price',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'Set the price viewers pay to join',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _priceController,
                          keyboardType: TextInputType.number,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                          decoration: InputDecoration(
                            hintText: '0',
                            hintStyle: const TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Colors.white.withOpacity(0.2),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Colors.white.withOpacity(0.2),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: Color(0xFFFF9500),
                                width: 2,
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 16,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF9500).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color(0xFFFF9500).withOpacity(0.3),
                          ),
                        ),
                        child: const Icon(
                          Icons.monetization_on,
                          color: Color(0xFFFF9500),
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Go Live Button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _goLive,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF9500),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                child: _isLoading
                    ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
                    : const Text(
                  'Go Live Now!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: maxLines,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
            prefixIcon: Icon(
              icon,
              color: Colors.grey,
              size: 20,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Colors.white.withOpacity(0.2),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Colors.white.withOpacity(0.2),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xFFFF9500),
                width: 2,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
        ),
      ],
    );
  }

  void _goLive() {
    if (_priceController.text.isEmpty || _titleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all required fields'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Start the live stream
    _startLiveStream().then((_) {
      setState(() {
        _isLoading = false;
      });

      // Navigate to live streaming page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LiveStreamingPage(
            isHost: true,
            channelName: _channelName,
            price: double.tryParse(_priceController.text) ?? 0.0,
            title: _titleController.text,
            description: _descriptionController.text,
          ),
        ),
      );
    }).catchError((error) {
      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to start live stream: $error'),
          backgroundColor: Colors.red,
        ),
      );
    });
  }
}

// Live Streaming Page
class LiveStreamingPage extends StatefulWidget {
  final bool isHost;
  final String channelName;
  final double price;
  final String title;
  final String description;

  const LiveStreamingPage({
    Key? key,
    required this.isHost,
    required this.channelName,
    required this.price,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  State<LiveStreamingPage> createState() => _LiveStreamingPageState();
}

class _LiveStreamingPageState extends State<LiveStreamingPage> {
  final String _appId = "YOUR_AGORA_APP_ID"; // Replace with your App ID
  RtcEngine? _agoraEngine;
  int? _remoteUid;
  bool _isJoined = false;
  bool _isMuted = false;
  bool _isVideoEnabled = true;
  List<int> _remoteUsers = [];
  int _viewerCount = 0;

  @override
  void initState() {
    super.initState();
    _initAgora();
  }

  @override
  void dispose() {
    _disposeAgora();
    super.dispose();
  }

  Future<void> _initAgora() async {
    _agoraEngine = createAgoraRtcEngine();
    await _agoraEngine!.initialize(RtcEngineContext(appId: _appId));

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
            _viewerCount++;
          });
        },
        onUserOffline: (RtcConnection connection, int remoteUid, UserOfflineReasonType reason) {
          setState(() {
            _remoteUsers.remove(remoteUid);
            _viewerCount = _viewerCount > 0 ? _viewerCount - 1 : 0;
          });
        },
        onError: (ErrorCodeType err, String msg) {
          debugPrint('Error: $err, $msg');
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
      token: "", // Use null for testing, in production use a token
      channelId: widget.channelName,
      uid: 0,
      options: const ChannelMediaOptions(),
    );
  }

  Future<void> _disposeAgora() async {
    await _agoraEngine?.leaveChannel();
    await _agoraEngine?.release();
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

  void _switchCamera() {
    _agoraEngine!.switchCamera();
  }

  void _endLive() {
    _disposeAgora();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Video view
          _buildVideoView(),

          // Header with live info
          _buildHeader(),

          // Bottom controls
          _buildControls(),

          // Viewer count and info
          _buildViewerInfo(),
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
            connection: RtcConnection(channelId: widget.channelName),
          ),
        );
      } else {
        return const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFF9500))),
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
          Text(
            '$_viewerCount viewers',
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.close, color: Colors.white, size: 28),
            onPressed: _endLive,
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
          if (widget.isHost) ...[
            IconButton(
              icon: Icon(
                Icons.cameraswitch,
                color: Colors.white,
                size: 28,
              ),
              onPressed: _switchCamera,
            ),
            IconButton(
              icon: Icon(
                _isMuted ? Icons.mic_off : Icons.mic,
                color: Colors.white,
                size: 28,
              ),
              onPressed: _toggleMute,
            ),
            IconButton(
              icon: Icon(
                _isVideoEnabled ? Icons.videocam : Icons.videocam_off,
                color: Colors.white,
                size: 28,
              ),
              onPressed: _toggleVideo,
            ),
          ],
          IconButton(
            icon: const Icon(Icons.favorite_border, color: Colors.white, size: 28),
            onPressed: () {
              // Send like
            },
          ),
          IconButton(
            icon: const Icon(Icons.comment, color: Colors.white, size: 28),
            onPressed: () {
              // Show comments
            },
          ),
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

  Widget _buildViewerInfo() {
    return Positioned(
      left: 16,
      bottom: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (widget.description.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              widget.description,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
          ],
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.monetization_on, color: Color(0xFFFF9500), size: 16),
              const SizedBox(width: 4),
              Text(
                '${widget.price} coins to join',
                style: const TextStyle(
                  color: Color(0xFFFF9500),
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}