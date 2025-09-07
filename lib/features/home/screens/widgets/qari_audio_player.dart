import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_audio/just_audio.dart';
import 'package:tajwid/core/extensions/sizes_extensions.dart';
import 'package:tajwid/features/home/screens/widgets/voice_message_widget.dart';

// class QariAudioPlayer extends StatefulWidget {
//   const QariAudioPlayer({super.key, required this.pickedFile});
//   final File pickedFile;

//   @override
//   State<QariAudioPlayer> createState() => _QariAudioPlayerState();
// }

// class _QariAudioPlayerState extends State<QariAudioPlayer> {
//   final AudioPlayer _player = AudioPlayer();
//   bool _isPlaying = false;
//   Duration _duration = Duration.zero;
//   Duration _position = Duration.zero;

//   @override
//   void initState() {
//     super.initState();
//     _initAudio();
//   }

//   Future<void> _initAudio() async {
//     await _player.setFilePath(widget.pickedFile.path);

//     // Listen for duration changes
//     _player.durationStream.listen((d) {
//       if (d != null) {
//         setState(() => _duration = d);
//       }
//     });

//     // Listen for position changes
//     _player.positionStream.listen((p) {
//       setState(() => _position = p);
//     });

//     // Listen for playing state
//     _player.playerStateStream.listen((state) {
//       setState(() => _isPlaying = state.playing);
//     });
//   }

//   @override
//   void dispose() {
//     _player.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final progress =
//         _duration.inMilliseconds == 0
//             ? 0.0
//             : _position.inMilliseconds / _duration.inMilliseconds;

//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Text(
//           "Now playing: ${widget.pickedFile.path.split('/').last}",
//           style: TextStyle(fontSize: 20.sp, color: Colors.grey.shade800),
//         ),
//         const SizedBox(height: 20),
//         VoiceMessageWidget(
//           duration: _formatDuration(_duration),
//           isPlaying: _isPlaying,
//           isSent: true,
//           progress: progress,
//           timestamp: '11:58 pm',
//           isDelivered: true,
//           isSeen: true,
//           onPlayPause: () {
//             if (_isPlaying) {
//               _player.pause();
//             } else {
//               _player.play();
//             }
//             setState(() {
//               _isPlaying = !_isPlaying;
//             });
//           },
//         ),
//         const SizedBox(height: 40),
//       ],
//     );
//   }

//   String _formatDuration(Duration d) {
//     final minutes = d.inMinutes.remainder(60).toString().padLeft(1, '0');
//     final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
//     return "$minutes:$seconds";
//   }
// }

class QariAudioPlayer extends StatefulWidget {
  const QariAudioPlayer({super.key, required this.pickedFile});
  final File pickedFile;

  @override
  State<QariAudioPlayer> createState() => _QariAudioPlayerState();
}

class _QariAudioPlayerState extends State<QariAudioPlayer> {
  final AudioPlayer _player = AudioPlayer();
  bool _isPlaying = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

  @override
  void initState() {
    super.initState();
    _initAudio();
  }

  Future<void> _initAudio() async {
    await _player.setFilePath(widget.pickedFile.path);

    // Listen for duration changes
    _player.durationStream.listen((d) {
      if (d != null) {
        setState(() => _duration = d);
      }
    });

    // Listen for position changes
    _player.positionStream.listen((p) {
      setState(() => _position = p);
    });

    // Listen for playing state
    _player.playerStateStream.listen((state) {
      setState(() => _isPlaying = state.playing);

      // Reset when finished
      if (state.processingState == ProcessingState.completed) {
        _player.seek(Duration.zero); // rewind
        setState(() {
          _isPlaying = false;
          _position = Duration.zero; // reset progress
        });
      }
    });
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final progress =
        _duration.inMilliseconds == 0
            ? 0.0
            : _position.inMilliseconds / _duration.inMilliseconds;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: context.h * 0.12),
        Text(
          "Now playing: ${widget.pickedFile.path.split('/').last}",
          style: TextStyle(fontSize: 20.sp, color: Colors.grey.shade800),
        ),
        const SizedBox(height: 20),
        VoiceMessageWidget(
          duration: _formatDuration(_duration),
          isPlaying: _isPlaying,
          isSent: true,
          progress: progress,
          timestamp: '11:58 pm',
          isDelivered: true,
          isSeen: true,
          onPlayPause: () {
            if (_isPlaying) {
              _player.pause();
            } else {
              _player.play();
            }
            setState(() {
              _isPlaying = !_isPlaying;
            });
          },
        ),
        SizedBox(height: context.h * 0.1),
      ],
    );
  }

  String _formatDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(1, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }
}
