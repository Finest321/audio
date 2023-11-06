import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MusicPlayerPage(),
    );
  }
}

class Song {
  final String title;
  final String artist;
  final String audioPath;

  Song({
    required this.title,
    required this.artist,
    required this.audioPath,
  });
}

class MusicPlayerPage extends StatefulWidget {
  @override
  _MusicPlayerPageState createState() => _MusicPlayerPageState();
}

class _MusicPlayerPageState extends State<MusicPlayerPage> {
  final assetsAudioPlayer = AssetsAudioPlayer();
  List<Song> playlist = [
    Song(
      title: 'Celine Love',
      artist: 'Celine Dion',
      audioPath: 'assets/audio/celinex.mp3',
    ),
    Song(
      title: 'Celine Sweet',
      artist: 'Celine Dion',
      audioPath: 'assets/audio/celine.mp3',
    ),
    Song(
      title: 'Celine Sweetest',
      artist: 'Celine Dion',
      audioPath: 'assets/audio/celinew.mp3',
    ),
    // Add more songs here
  ];

  String selectedSong = 'Celine Dion';
  bool isPlaying = false;

  @override
  void dispose() {
    assetsAudioPlayer.dispose();
    super.dispose();
  }

  void playMusic() {
    Song selectedSongData =
        playlist.firstWhere((song) => song.title == selectedSong);
    assetsAudioPlayer.open(
      Audio(selectedSongData.audioPath),
      autoStart: true,
    );
    setState(() {
      isPlaying = true;
    });
  }

  void stopMusic() {
    assetsAudioPlayer.stop();
    setState(() {
      isPlaying = false;
    });
  }

  void playNextSong() {
    int currentIndex =
        playlist.indexWhere((song) => song.title == selectedSong);
    if (currentIndex < playlist.length - 1) {
      setState(() {
        selectedSong = playlist[currentIndex + 1].title;
      });
      playMusic();
    }
  }

  void playPreviousSong() {
    int currentIndex =
        playlist.indexWhere((song) => song.title == selectedSong);
    if (currentIndex > 0) {
      setState(() {
        selectedSong = playlist[currentIndex - 1].title;
      });
      playMusic();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Music Player'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                image: DecorationImage(
                  image: AssetImage(
                      'assets/images/celinepic.png'), // Replace with your image path
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              selectedSong,
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.skip_previous),
                  iconSize: 48.0,
                  onPressed: playPreviousSong,
                ),
                Expanded(
                  child: IconButton(
                    icon: isPlaying
                        ? Icon(Icons.pause_circle_filled, size: 48.0)
                        : Icon(Icons.play_circle_filled, size: 48.0),
                    onPressed: () {
                      if (isPlaying) {
                        assetsAudioPlayer.pause();
                        setState(() {
                          isPlaying = false;
                        });
                      } else {
                        assetsAudioPlayer.play();
                        setState(() {
                          isPlaying = true;
                        });
                      }
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.skip_next),
                  iconSize: 48.0,
                  onPressed: playNextSong,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
