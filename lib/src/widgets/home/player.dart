import 'package:chewie/chewie.dart';
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
  late ChewieController _chewieController;

  bool _isLoading = false;
  bool _isError = false;

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

      _chewieController = ChewieController(
        videoPlayerController: _controller,
        autoPlay: true,
        looping: false,
        aspectRatio: _controller.value.aspectRatio,
      );
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
    _chewieController.dispose();
    super.dispose();
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

    return AspectRatio(
      aspectRatio: _chewieController.videoPlayerController.value.aspectRatio,
      child: Chewie(controller: _chewieController),
    );
  }
}
