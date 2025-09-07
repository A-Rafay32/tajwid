import 'package:flutter/material.dart';
import 'dart:math' as math;

class VoiceMessageWidget extends StatefulWidget {
  final String duration;
  final bool isPlaying;
  final bool isSent;
  final double progress;
  final VoidCallback? onPlayPause;
  final String timestamp;
  final bool isDelivered;
  final bool isSeen;

  // Sample waveform data
  final List<double> waveformData = [
    11,
    14,
    6,
    14,
    21,
    10,
    16,
    30,
    11,
    15,
    22,
    14,
    9,
    17,
    24,
    14,
    11,
    19,
    16,
    13,
    30,
    21,
    15,
    14,
    25,
    11,
    14,
    21,
    16,
    10,
    21,
    13,
    19,
    15,
    11,
    23,
    17,
    9,
    30,
    14,
  ];

  VoiceMessageWidget({
    super.key,
    required this.duration,
    this.isPlaying = false,
    this.isSent = true,
    this.progress = 0.0,
    this.onPlayPause,
    required this.timestamp,
    this.isDelivered = true,
    this.isSeen = false,
  });

  @override
  _VoiceMessageWidgetState createState() => _VoiceMessageWidgetState();
}

class _VoiceMessageWidgetState extends State<VoiceMessageWidget>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _playButtonController;
  late AnimationController _waveController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat();

    _playButtonController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _waveController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.9).animate(
      CurvedAnimation(parent: _playButtonController, curve: Curves.easeInOut),
    );

    if (widget.isPlaying) {
      _waveController.repeat();
    }
  }

  @override
  void didUpdateWidget(VoiceMessageWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isPlaying != oldWidget.isPlaying) {
      if (widget.isPlaying) {
        _waveController.repeat();
      } else {
        _waveController.stop();
      }
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _playButtonController.dispose();
    _waveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      child: Align(
        alignment: widget.isSent ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          height: 80,
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.8,
            minWidth: 200,
          ),
          decoration: BoxDecoration(
            gradient:
                widget.isSent
                    ? LinearGradient(
                      colors: [Colors.black, Colors.black87],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                    : LinearGradient(
                      colors: [Colors.white, Colors.grey[50]!],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
            borderRadius: BorderRadius.all(Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildPlayButton(),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildWaveform(),
                      // SizedBox(height: 4),
                      // _buildDurationAndStatus(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPlayButton() {
    return GestureDetector(
      onTapDown: (_) => _playButtonController.forward(),
      onTapUp: (_) => _playButtonController.reverse(),
      onTapCancel: () => _playButtonController.reverse(),
      onTap: widget.onPlayPause,
      child: AnimatedBuilder(
        animation: Listenable.merge([_pulseAnimation, _scaleAnimation]),
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child:
                widget.isPlaying
                    ? AnimatedBuilder(
                      animation: _pulseAnimation,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _pulseAnimation.value,
                          child: Icon(
                            Icons.pause_rounded,
                            color: Colors.white,
                            size: 28,
                          ),
                        );
                      },
                    )
                    : Icon(
                      Icons.play_arrow_rounded,
                      color: Colors.white,
                      size: 28,
                    ),
          );
        },
      ),
    );
  }

  Widget _buildWaveform() {
    return SizedBox(
      height: 32,
      child: AnimatedBuilder(
        animation: _waveController,
        builder: (context, child) {
          return Row(
            children: List.generate(widget.waveformData.length, (index) {
              double height = widget.waveformData[index];
              bool isPlayed =
                  (index / widget.waveformData.length) <= widget.progress;

              // Add animation effect when playing
              if (widget.isPlaying) {
                double animationOffset =
                    (_waveController.value * widget.waveformData.length);
                double distance = (index - animationOffset).abs();
                if (distance < 3) {
                  height *= (1 + (1 - distance / 3) * 0.3);
                }
              }

              return Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 0.8),
                  child: Align(
                    alignment: Alignment.center,
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 150),
                      width: 3,
                      height: height,
                      decoration: BoxDecoration(
                        color:
                            isPlayed
                                ? (widget.isSent
                                    ? Colors.white
                                    : Color(0xFF25D366))
                                : (widget.isSent
                                    ? Colors.white.withOpacity(0.4)
                                    : Colors.grey[400]),
                        borderRadius: BorderRadius.circular(2),
                        boxShadow:
                            isPlayed && widget.isPlaying
                                ? [
                                  BoxShadow(
                                    color: (widget.isSent
                                            ? Colors.white
                                            : Color(0xFF25D366))
                                        .withOpacity(0.5),
                                    blurRadius: 4,
                                    spreadRadius: 1,
                                  ),
                                ]
                                : null,
                      ),
                    ),
                  ),
                ),
              );
            }),
          );
        },
      ),
    );
  }

  Widget _buildDurationAndStatus() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.duration,
          style: TextStyle(
            color:
                widget.isSent
                    ? Colors.white.withOpacity(0.9)
                    : Colors.grey[600],
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        Row(
          children: [
            Text(
              widget.timestamp,
              style: TextStyle(
                color:
                    widget.isSent
                        ? Colors.white.withOpacity(0.8)
                        : Colors.grey[500],
                fontSize: 11,
              ),
            ),
            if (widget.isSent) ...[SizedBox(width: 4), _buildStatusIcon()],
          ],
        ),
      ],
    );
  }

  Widget _buildStatusIcon() {
    if (widget.isSeen) {
      return Icon(Icons.done_all_rounded, size: 16, color: Colors.blue[300]);
    } else if (widget.isDelivered) {
      return Icon(
        Icons.done_all_rounded,
        size: 16,
        color: Colors.white.withOpacity(0.8),
      );
    } else {
      return Icon(
        Icons.done_rounded,
        size: 16,
        color: Colors.white.withOpacity(0.8),
      );
    }
  }
}
