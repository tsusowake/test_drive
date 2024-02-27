import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Player extends StatefulWidget {
  final String url;
  final String title;

  const Player({
    super.key,
    required this.url,
    required this.title,
  });

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  late VideoPlayerController _controller;
  late final OverlayEntry _overlayEntry = OverlayEntry(
    builder: (context) => PlayOverlay(
      togglePlayPause: _togglePlayPause,
      videoPlayerKey: _videoPlayerKey,
    ),
  );
  final GlobalKey _videoPlayerKey = GlobalKey();

  bool _isLoading = false;
  bool _isError = false;
  bool _isMuted = false;

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
  }

  Future<void> _initializeVideoPlayer() async {
    setState(() {
      _isLoading = true;
    });
    try {
      _controller = VideoPlayerController.networkUrl(Uri.parse(widget.url));
      await _controller.initialize();
      _controller.play();
    } catch (error) {
      setState(() {
        _isError = true;
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    if (_controller.value.isPlaying) {
      _controller.pause();
      _showOverlay(context);
    } else {
      _controller.play();
      _removeOverlay();
    }
  }

  void _removeOverlay() {
    _overlayEntry.remove();
  }

  void _toggleMute() {
    _isMuted = !_isMuted;
    _controller.setVolume(_isMuted ? 0 : 1);
    setState(() {});
  }

  void _showOverlay(BuildContext context) {
    Overlay.of(context).insert(_overlayEntry);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const CircularProgressIndicator();
    }
    if (_isError) {
      return const Text('Error loading video');
    }

    if (!(_controller.value.isInitialized)) {
      return const Text('Error loading video');
    }

    return GestureDetector(
      onTap: _togglePlayPause,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            key: _videoPlayerKey,
            child: VideoPlayer(_controller),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: FloatingActionButton(
              onPressed: _toggleMute,
              backgroundColor: Colors.transparent,
              elevation: 0,
              child: Icon(
                _isMuted ? Icons.volume_off : Icons.volume_up,
                color: Colors.black45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PlayOverlay extends StatelessWidget {
  final VoidCallback togglePlayPause;
  final GlobalKey videoPlayerKey;

  const PlayOverlay({
    super.key,
    required this.togglePlayPause,
    required this.videoPlayerKey,
  });

  @override
  Widget build(BuildContext context) {
    final RenderBox box =
        videoPlayerKey.currentContext?.findRenderObject() as RenderBox;
    final size = box.size;

    return Positioned(
      height: size.height,
      width: size.width,
      child: GestureDetector(
        onTap: togglePlayPause,
        child: Container(
          color: Colors.black45,
          child: const Center(
            child: Icon(
              Icons.play_arrow_rounded,
              color: Colors.white,
              size: 100.0,
            ),
          ),
        ),
      ),
    );
  }
}
