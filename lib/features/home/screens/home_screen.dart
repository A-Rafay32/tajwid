import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:record/record.dart';
import 'package:tajwid/app/themes/app_colors.dart';
import 'package:tajwid/app/themes/app_paddings.dart';
import 'package:tajwid/app/utils/filePicker.dart';
import 'package:tajwid/core/extensions/sizes_extensions.dart';
import 'package:tajwid/core/extensions/snackbar_ext.dart';
import 'package:tajwid/features/auth/provider/auth_provider.dart';
import 'package:tajwid/features/auth/screens/widgets/app_bar_white.dart';
import 'package:tajwid/features/auth/screens/widgets/button.dart';
import 'package:tajwid/features/home/provider/home_provider.dart';
import 'package:tajwid/features/home/screens/widgets/analyzing_dialog_box.dart';
import 'package:tajwid/features/home/screens/widgets/qari_audio_player.dart';
import 'package:tajwid/features/home/screens/widgets/voice_message_widget.dart';
import 'package:waveform_fft/waveform_fft.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final Ticker _ticker;
  final AudioRecorder _recorder = AudioRecorder();
  final AudioCaptureService _audioCaptureService = AudioCaptureService();
  final AudioPlayer _player = AudioPlayer();

  List<({FrequencySpectrum spectrum, double value})> data = [];
  List<({FrequencySpectrum spectrum, double value})> data2Animation = [];

  bool isRecording = false;
  String? recordedFilePath;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker((_) {
      if (data2Animation.isEmpty) {
        data2Animation = data;
      } else {
        for (int i = 0; i < data.length; i++) {
          data2Animation[i] = (
            spectrum: data2Animation[i].spectrum,
            value: lerpDouble(data2Animation[i].value, data[i].value, 0.1)!,
          );
        }
      }
      setState(() {});
    });
    _ticker.start();
  }

  Future<void> startEverything() async {
    final micStatus = await Permission.microphone.request();
    if (!micStatus.isGranted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Microphone permission is required")),
      );
      return;
    }

    final dir = await getApplicationDocumentsDirectory();
    final path = "${dir.path}/my_recording.wav";

    // Start visualization
    await _audioCaptureService.startCapture((incomingData) {
      setState(() {
        data = incomingData;
      });
    });

    // Start recording
    await _recorder.start(
      const RecordConfig(
        encoder: AudioEncoder.wav,
        bitRate: 128000,
        sampleRate: 44100,
      ),
      path: path,
    );

    recordedFilePath = path;
  }

  /// Call this when you want to stop and save
  Future<void> stopEverything() async {
    await _audioCaptureService.stopCapture();
    await _recorder.stop();

    if (recordedFilePath != null) {
      userAudio = File(recordedFilePath!); // now you have a File object
      debugPrint("Audio saved at: ${userAudio!.path}");
      context.read<HomeProvider>().compareAccents(
        files: {
          "reference_audio": referenceFile!,
          "comparison_audio": userAudio!,
        },
        context: context,
      );
      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              backgroundColor: Colors.white,
              content: AnalyzingDialog(
                onTap: () {},
                w: context.w,
                image: "assets/login/success-frame.png",
                message:
                    "Your account is ready to use. You will be redirected to Home. page in a few seconds",
                title: "Congratulations",
              ),
            ),
      );
    }
  }

  @override
  void dispose() {
    _ticker.dispose();
    _audioCaptureService.stopCapture();
    _player.dispose();
    super.dispose();
  }

  File? referenceFile;
  File? userAudio;

  @override
  Widget build(BuildContext context) {
    final homeProvider = context.watch<HomeProvider>();
    final authProvider = context.watch<AuthProvider>();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(65),
        child: HomeAppBar(
          onPressed: () {},
          text: authProvider.authResponse?.username ?? "",
        ),
      ),
      drawer: Drawer(),
      body: Container(
        padding: AppPaddings.normal,
        height: context.h,
        width: context.w,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            if (referenceFile == null)
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: context.h * 0.25),
                    child: Text(
                      "Pick your reference Qari audio to get started",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.sp,

                        color: Colors.grey.shade800,
                      ),
                    ),
                  ),
                  AppSizes.largeY,
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 40),
                    child: Button(
                      press: () async {
                        referenceFile = await FilePickerService().pickFile();
                        print("referenceFile : $referenceFile");
                      },
                      text: "Select Reference Audio",
                    ),
                  ),
                  AppSizes.largeY,

                  // Container(
                  //   margin: EdgeInsets.symmetric(horizontal: 40),
                  //   child: Button(
                  //     press: () async {
                  //       userAudio = await FilePickerService().pickFile();
                  //       print("user audio : $userAudio");
                  //     },
                  //     text: "Your Audio",
                  //   ),
                  // ),
                  // AppSizes.largeY,
                  // Container(
                  //   margin: EdgeInsets.symmetric(horizontal: 40),
                  //   child: Button(
                  //     press: () {
                  //       if (referenceFile != null && userAudio != null) {
                  //         context.read<HomeProvider>().compareAccents(
                  //           files: {
                  //             "reference_audio": referenceFile!,
                  //             "comparison_audio": userAudio!,
                  //           },
                  //           context: context,
                  //         );
                  //         showDialog(
                  //           context: context,
                  //           builder:
                  //               (context) => AlertDialog(
                  //                 backgroundColor: Colors.white,
                  //                 content: AnalyzingDialog(
                  //                   onTap: () {},
                  //                   w: context.w,
                  //                   image: "assets/login/success-frame.png",
                  //                   message:
                  //                       "Your account is ready to use. You will be redirected to Home. page in a few seconds",
                  //                   title: "Congratulations",
                  //                 ),
                  //               ),
                  //         );
                  //       } else {
                  //         context.showSnackBar("Select the files first");
                  //       }
                  //     },
                  //     text: "Test API",
                  //   ),
                  // ),
                ],
              )
            else
              SizedBox(
                height: context.h * 0.7,
                width: context.w,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    QariAudioPlayer(pickedFile: referenceFile!),
                    if (homeProvider.recordingMode == RecordingModes.started ||
                        homeProvider.recordingMode == RecordingModes.paused)
                      SizedBox(
                        height: context.h * 0.2,
                        width: context.w,
                        child: WaveFormWidgetEq(
                          data: data,
                          barWidth: 4,
                          maxY: 80,
                          minY: -80,
                          barColor: AppColors.primaryColor,
                          barAlpha: 0.6,
                          animationDuration: const Duration(milliseconds: 120),
                          updateInterval: const Duration(milliseconds: 48),
                        ),
                      ),
                    if (homeProvider.recordingMode == RecordingModes.stopped)
                      Text(
                        "Record your Tajwid to get it analyzed",
                        style: TextStyle(
                          fontSize: 22.sp,
                          color: Colors.grey.shade800,
                        ),
                      ),
                    Spacer(),
                    if (homeProvider.recordingMode == RecordingModes.started ||
                        homeProvider.recordingMode == RecordingModes.paused)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // GestureDetector(
                          //   onTap: () {},
                          //   child: Icon(
                          //     Icons.play_arrow_rounded,
                          //     color: Colors.black,
                          //     size: 40,
                          //   ),
                          // ),
                          // AppSizes.largeX,
                          GestureDetector(
                            onTap: () {
                              context
                                  .read<HomeProvider>()
                                  .switchRecordingMode();
                            },
                            child: Center(
                              child: Container(
                                padding: EdgeInsets.all(20.h),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  homeProvider.recordingMode ==
                                          RecordingModes.paused
                                      ? Icons.circle
                                      : Icons.pause_rounded,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                            ),
                          ),
                          AppSizes.largeX,
                          GestureDetector(
                            onTap: () async {
                              context.read<HomeProvider>().setRecordingMode(
                                RecordingModes.stopped,
                              );
                              await stopEverything().then((val) {
                                userAudio = null;
                                referenceFile = null;
                                setState(() {});
                              });
                            },
                            child: Icon(
                              Icons.square,
                              color: Colors.black,
                              size: 25,
                            ),
                          ),
                        ],
                      ),
                    if (homeProvider.recordingMode == RecordingModes.stopped)
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: GestureDetector(
                          onTap: () async {
                            context.read<HomeProvider>().setRecordingMode(
                              RecordingModes.started,
                            );
                            await startEverything();
                            setState(() {});
                          },
                          child: Container(
                            padding: EdgeInsets.all(20.h),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              shape: BoxShape.circle,
                            ),
                            child: SvgPicture.asset(
                              "assets/svgs/voice.svg",
                              height: 30,
                              width: 30,
                              colorFilter: ColorFilter.mode(
                                Colors.white,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),

            AppSizes.largeY,
            AppSizes.largeY,
          ],
        ),
      ),
    );
  }
}

// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
// import 'package:just_audio/just_audio.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:record/record.dart';
// import 'package:waveform_fft/waveform_fft.dart';
// import 'dart:io';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen>
//     with SingleTickerProviderStateMixin {
//   late final Ticker _ticker;
//   final AudioRecorder _recorder = AudioRecorder();
//   final AudioCaptureService _audioCaptureService = AudioCaptureService();
//   final AudioPlayer _player = AudioPlayer();

//   List<({FrequencySpectrum spectrum, double value})> data = [];
//   List<({FrequencySpectrum spectrum, double value})> data2Animation = [];

//   bool isRecording = false;
//   String? recordedFilePath;

//   @override
//   void initState() {
//     super.initState();
//     _ticker = createTicker((_) {
//       if (data2Animation.isEmpty) {
//         data2Animation = data;
//       } else {
//         for (int i = 0; i < data.length; i++) {
//           data2Animation[i] = (
//             spectrum: data2Animation[i].spectrum,
//             value: lerpDouble(data2Animation[i].value, data[i].value, 0.1)!,
//           );
//         }
//       }
//       setState(() {});
//     });
//     _ticker.start();
//   }

//   Future<void> startEverything() async {
//     final micStatus = await Permission.microphone.request();
//     if (!micStatus.isGranted) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Microphone permission is required")),
//       );
//       return;
//     }

//     final dir = await getApplicationDocumentsDirectory();
//     final path = "${dir.path}/my_recording.wav";

//     // Start visualization
//     await _audioCaptureService.startCapture((incomingData) {
//       setState(() {
//         data = incomingData;
//       });
//     });

//     // Start recording
//     await _recorder.start(
//       const RecordConfig(
//         encoder: AudioEncoder.wav,
//         bitRate: 128000,
//         sampleRate: 44100,
//       ),
//       path: path,
//     );

//     recordedFilePath = path;
//   }

//   Future<void> stopEverything() async {
//     await _audioCaptureService.stopCapture();
//     await _recorder.stop();
//   }

//   Future<void> playRecording() async {
//     try {
//       await _player.setFilePath(recordedFilePath!);
//       _player.play();
//     } catch (e) {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(SnackBar(content: Text("Error playing recording: $e")));
//     }
//   }

//   @override
//   void dispose() {
//     _ticker.dispose();
//     _audioCaptureService.stopCapture();
//     _player.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);

//     return Scaffold(
//       backgroundColor: theme.colorScheme.surface,
//       appBar: AppBar(title: const Text("Waveform Recorder")),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(24.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 isRecording
//                     ? "Recording... Speak now"
//                     : "Press the button to start recording + visualization",
//                 style: theme.textTheme.bodyLarge,
//               ),
//               const SizedBox(height: 32),
//               if (isRecording)
//                 SizedBox(
//                   height: 200,
//                   width: MediaQuery.sizeOf(context).width,
//                   child: WaveFormWidgetEq(
//                     data: data2Animation,
//                     barWidth: 4,
//                     maxY: 80,
//                     minY: -80,
//                     barColor: theme.colorScheme.primary,
//                     barAlpha: 0.7,
//                     animationDuration: const Duration(milliseconds: 120),
//                     updateInterval: const Duration(milliseconds: 48),
//                   ),
//                 ),
//               const SizedBox(height: 48),

//               // Start/Stop Recording Button
//               FilledButton.icon(
//                 onPressed: () async {
//                   if (!isRecording) {
//                     await startEverything();
//                   } else {
//                     await stopEverything();
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(
//                         content: Text(
//                           "Recording saved to:\n$recordedFilePath",
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//                     );
//                   }

//                   setState(() => isRecording = !isRecording);
//                 },
//                 icon: Icon(isRecording ? Icons.stop : Icons.mic),
//                 label: Text(isRecording ? "Stop Recording" : "Start Recording"),
//               ),
//               const SizedBox(height: 16),

//               // Play Button
//               // if (recordedFilePath != null && !isRecording)
//               FilledButton.icon(
//                 onPressed: playRecording,
//                 icon: const Icon(Icons.play_arrow),
//                 label: const Text("Play Recording"),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
