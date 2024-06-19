import 'package:dev_nc/tutorial_overlay.dart';
import 'package:flutter/material.dart';

class SpotifyUI extends StatefulWidget {
  const SpotifyUI({super.key});

  @override
  State<SpotifyUI> createState() => _SpotifyUIState();
}

class _SpotifyUIState extends State<SpotifyUI> {
  int _currentStepIndex = 0;

  final List<TutorialStep> _tutorialSteps = [
    TutorialStep(
      title: 'Song',
      description: 'This is song',
      key: GlobalKey(),
    ),
    TutorialStep(
      title: 'Album',
      description: 'You can view and edit your personal information here.',
      key: GlobalKey(),
    ),
    TutorialStep(
      title: 'Set',
      description: 'inform',
      key: GlobalKey(),
    ),
    TutorialStep(
      title: 'Set',
      description: 'inform',
      key: GlobalKey(),
    ),
    TutorialStep(
      title: 'Set',
      description: 'inform',
      key: GlobalKey(),
    ),
    TutorialStep(
      title: 'Set',
      description: 'inform',
      key: GlobalKey(),
    ),
    TutorialStep(
      title: 'Set',
      description: 'inform',
      key: GlobalKey(),
    ),
  ];

  void _showTutorialOverlay() {
    OverlayState overlayState = Overlay.of(context);
    OverlayEntry? overlayEntry;

    RenderBox renderBox = _tutorialSteps[_currentStepIndex]
        .key
        .currentContext!
        .findRenderObject() as RenderBox;
    Offset offset = renderBox.localToGlobal(Offset.zero);
    Rect targetRect = Rect.fromLTWH(
        offset.dx, offset.dy, renderBox.size.width, renderBox.size.height);

    overlayEntry = OverlayEntry(
      builder: (context) {
        return SpotlightOverlay(
          target: targetRect,
          title: _tutorialSteps[_currentStepIndex].title,
          description: _tutorialSteps[_currentStepIndex].description,
          onNext: () {
            overlayEntry!.remove();
            setState(() {
              _currentStepIndex++;
              if (_currentStepIndex < _tutorialSteps.length) {
                _showTutorialOverlay();
              } else {
                _currentStepIndex =
                    0; // Reset for the next time tutorial is shown
              }
            });
          },
          onSkip: () {
            overlayEntry!.remove();
            setState(() {
              _currentStepIndex =
                  0; // Reset for the next time tutorial is shown
            });
          },
        );
      },
    );

    overlayState.insert(overlayEntry);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Container(
          key: _tutorialSteps[0].key,
          width: 200,
          alignment: Alignment.center,
          child: const Text(
            "Rhythms",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.more_horiz,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black,
              Colors.grey.shade500,
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Album Art
              Container(
                key: _tutorialSteps[1].key,
                width: 350,
                height: 350,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: const DecorationImage(
                    image: NetworkImage(
                        'https://img.freepik.com/free-vector/electro-music-album_53876-67221.jpg?size=626&ext=jpg&ga=GA1.1.1546980028.1702684800&semt=ais'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Song Title
              const Text(
                'Song Title',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              // Artist Name
              const Text(
                'Artist Name',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 20),
              // Progress Bar
              Slider(
                value: 0.3,
                onChanged: (value) {},
                activeColor: Colors.black,
                inactiveColor: Colors.grey,
              ),
              const SizedBox(height: 10),
              // Play/Pause Button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    key: _tutorialSteps[2].key,
                    child: IconButton(
                      icon: const Icon(
                        Icons.shuffle,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    ),
                  ),
                  Expanded(
                    key: _tutorialSteps[3].key,
                    child: IconButton(
                      icon: const Icon(
                        Icons.skip_previous,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    ),
                  ),
                  Expanded(
                    key: _tutorialSteps[4].key,
                    child: IconButton(
                      icon: const Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                        size: 60,
                      ),
                      onPressed: _showTutorialOverlay,
                    ),
                  ),
                  Expanded(
                    key: _tutorialSteps[5].key,
                    child: IconButton(
                      icon: const Icon(
                        Icons.skip_next,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    ),
                  ),
                  Expanded(
                    key: _tutorialSteps[6].key,
                    child: IconButton(
                      icon: const Icon(
                        Icons.loop,
                        color: Colors.green,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          backgroundColor: Colors.transparent,
                          builder: (BuildContext context) {
                            return MusicListBottomSheet();
                          },
                        );
                      },
                      child: const Row(
                        children: [
                          Icon(
                            Icons.media_bluetooth_on_rounded,
                            color: Colors.green,
                          ),
                          Text(
                            " MARSHEEL~",
                            style: TextStyle(
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Row(
                      children: [
                        Icon(
                          Icons.ios_share,
                          color: Colors.white,
                        ),
                        SizedBox(width: 30),
                        Icon(
                          Icons.playlist_play_rounded,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Container(
                margin: const EdgeInsets.all(15),
                padding: const EdgeInsets.all(15),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black45,
                ),
                child: const Text(
                  "Hey, Em, it's Paul\nUh, I was listening to the album\nGood fucking luck, you're on your own\nGuess who's back, back again?\nShady's back, tell a friend\nGuess who's back? Guess who's back?\nGuess who's back? (Haha)\nDa-da-da, da, da, da, da, da, da\nDa-da-da, da, da, da, da",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MusicListBottomSheet extends StatelessWidget {
  final List<String> musicList = [
    'Song 1 - Artist 1',
    'Song 2 - Artist 2',
    'Song 3 - Artist 3',
    'Song 4 - Artist 4',
    'Song 5 - Artist 5',
  ];

  MusicListBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Music List',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          const Divider(color: Colors.grey),
          const SizedBox(height: 10),
          ListView.builder(
            shrinkWrap: true,
            itemCount: musicList.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  musicList[index],
                  style: const TextStyle(color: Colors.white),
                ),
                onTap: () {
                  // Handle song selection
                  Navigator.of(context).pop(); // Close the bottom sheet
                },
              );
            },
          ),
          const SizedBox(height: 10),
          IconButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the bottom sheet
            },
            color: Colors.white,
            icon: const Icon(Icons.close),
          ),
        ],
      ),
    );
  }
}
