import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tictok_clone/constants/gaps.dart';
import 'package:tictok_clone/constants/sizes.dart';
import 'package:tictok_clone/features/videos/video_preview_screen.dart';
import 'package:tictok_clone/features/videos/widgets/flash_mode.dart';

class VideoRecordingScreen extends StatefulWidget {
  static String routeName = "/";

  const VideoRecordingScreen({Key? key}) : super(key: key);

  @override
  State<VideoRecordingScreen> createState() => _VideoRecordingScreenState();
}

class _VideoRecordingScreenState extends State<VideoRecordingScreen>
    with TickerProviderStateMixin {
  // Flag here
  bool _hasPermission = false;

  bool _selfMode = false;

  late FlashMode _flashMode;

  bool _permissionDenied = false;

  late CameraController _cameraController;

  late final AnimationController _buttonAnimationController =
      AnimationController(
    vsync: this,
    duration: const Duration(
      milliseconds: 200,
    ),
  );

  late final Animation<double> _buttonAnimation = Tween(
    begin: 1.0,
    end: 1.3,
  ).animate(_buttonAnimationController);

  late final AnimationController _progressAnimationController =
      AnimationController(
    vsync: this,
    duration: const Duration(
      seconds: 20,
    ),
    lowerBound: 0.0,
    upperBound: 1.0,
  );

  Future<void> initCamera() async {
    final camera = await availableCameras();
    //print(camera);

    if (camera.isEmpty) {
      return;
    }

    _cameraController = CameraController(
      camera[_selfMode ? 1 : 0],
      ResolutionPreset.ultraHigh,
    );

    await _cameraController.initialize();

    // For IOS Setting
    await _cameraController.prepareForVideoRecording();

    _flashMode = _cameraController.value.flashMode;
  }

  Future<void> initPermission() async {
    final cameraPermission = await Permission.camera.request();
    final micPermission = await Permission.microphone.request();

    final cameraDenied =
        cameraPermission.isDenied || cameraPermission.isPermanentlyDenied;
    final micDenied =
        micPermission.isDenied || micPermission.isPermanentlyDenied;

    if (!cameraDenied && !micDenied) {
      _hasPermission = true;
      await initCamera();
    } else {
      _permissionDenied = true;
    }
    setState(() {});
  }

  Future<void> _toggleSelfMode() async {
    _selfMode = !_selfMode;
    await initCamera();
    setState(() {});
  }

  Future<void> _startRecording(TapDownDetails _) async {
    //print("촬영을 시작합니다.");
    if (_cameraController.value.isRecordingVideo) return;

    await _cameraController.startVideoRecording();

    _buttonAnimationController.forward();
    _progressAnimationController.forward();
  }

  Future<void> _stopRecording() async {
    //print("촬영을 중지합니다.");
    if (!_cameraController.value.isRecordingVideo) return;
    _buttonAnimationController.reverse();
    _progressAnimationController.reset();

    final video = await _cameraController.stopVideoRecording();

    if (!mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPreviewScreen(video: video),
      ),
    );
  }

  @override
  void dispose() {
    _progressAnimationController.dispose();
    _buttonAnimationController.dispose();
    _cameraController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    initPermission();
    _progressAnimationController.addListener(() {
      setState(() {});
      _progressAnimationController.addStatusListener((status) {
        // 애니메이션이 언제 종료되는지 사용자에게 공지
        if (status == AnimationStatus.completed) {
          _stopRecording();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: _permissionDenied
            ? const CameraStatus(
                status:
                    "사용자에 의해 카메라 접근권한이 거부되었습니다.\n 어플리케이션 설정에서 직접 권한을 수락해주세요.")
            : !_hasPermission || !_cameraController.value.isInitialized
                ? const CameraStatus(status: "초기화가 진행중입니다.")
                : Stack(
                    alignment: Alignment.center,
                    children: [
                      CameraPreview(_cameraController),
                      Positioned(
                        top: Sizes.size20,
                        right: Sizes.size20,
                        child: Column(
                          children: [
                            IconButton(
                              color: Colors.white,
                              onPressed: _toggleSelfMode,
                              icon: const Icon(
                                Icons.cameraswitch,
                              ),
                            ),
                            Gaps.v10,
                            FlashModeWidget(
                              cameraController: _cameraController,
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: Sizes.size40,
                        child: GestureDetector(
                          onTapDown: _startRecording,
                          onTapUp: (details) => _stopRecording,
                          child: ScaleTransition(
                            scale: _buttonAnimation,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                SizedBox(
                                  width: Sizes.size64 + Sizes.size14,
                                  height: Sizes.size64 + Sizes.size14,
                                  child: CircularProgressIndicator(
                                    color: Colors.red.shade400,
                                    strokeWidth: Sizes.size6,
                                    value: _progressAnimationController.value,
                                  ),
                                ),
                                Container(
                                  width: Sizes.size64,
                                  height: Sizes.size64,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.red.shade400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }
}

class CameraStatus extends StatelessWidget {
  final String status;

  const CameraStatus({
    Key? key,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          status,
          style: const TextStyle(
            color: Colors.white,
            fontSize: Sizes.size20,
          ),
          textAlign: TextAlign.center,
        ),
        Gaps.v20,
        const CircularProgressIndicator.adaptive(),
      ],
    );
  }
}
