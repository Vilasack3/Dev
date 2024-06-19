import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class TikTokHome extends StatefulWidget {
  const TikTokHome({super.key});

  @override
  State<TikTokHome> createState() => _TikTokHomeState();
}

class _TikTokHomeState extends State<TikTokHome> {
  final PageController _pageController = PageController();
  final List<String> _videoUrls = [
    'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
    'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4',
    'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        controller: _pageController,
        itemCount: _videoUrls.length,
        itemBuilder: (context, index) {
          return VideoPlayerItem(videoUrl: _videoUrls[index]);
        },
      ),
    );
  }
}

class VideoPlayerItem extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerItem({super.key, required this.videoUrl});

  @override
  State<VideoPlayerItem> createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
        _controller.setLooping(true);
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _controller.value.isInitialized
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    _controller.value.isPlaying
                        ? _controller.pause()
                        : _controller.play();
                  });
                },
                child: VideoPlayer(_controller),
              )
            : const Center(child: CircularProgressIndicator()),
        _buildOverlay(),
      ],
    );
  }

  Widget _buildOverlay() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  '@username',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                SizedBox(height: 10),
                Text(
                  'Video description goes here...',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(Icons.favorite, color: Colors.white),
                  onPressed: () {},
                ),
                const Text('1.2K', style: TextStyle(color: Colors.white)),
                const SizedBox(height: 20),
                IconButton(
                  icon: const Icon(Icons.comment, color: Colors.white),
                  onPressed: () {},
                ),
                const Text('300', style: TextStyle(color: Colors.white)),
                const SizedBox(height: 20),
                IconButton(
                  icon: const Icon(Icons.share, color: Colors.white),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
