import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioPlayerScreen extends StatefulWidget {
  const AudioPlayerScreen({Key? key}) : super(key: key);

  @override
  State<AudioPlayerScreen> createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  
  final player = AudioCache();

  Widget buttonMusic(String text, String soundName, Color color) {
    return Expanded(
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
          primary: color,
        ),
        onPressed: () {
          player.play('audio/$soundName');
        },
        child: Row(
          children: [
            const Icon(Icons.music_note_outlined),
            Text(text, style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Audio Player Screen'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          buttonMusic('Cat', 'cat.mp3', Colors.green),
          buttonMusic('Dog', 'dog.mp3', Colors.blue),
          buttonMusic('Sheep' ,'sheep.wav', Colors.deepPurpleAccent),
          buttonMusic('Bear', 'bear.wav', Colors.red),
        ],
      ),
    );
  }
}
