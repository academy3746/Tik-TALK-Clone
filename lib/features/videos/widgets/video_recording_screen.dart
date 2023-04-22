import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tictok_clone/constants/gaps.dart';
import 'package:tictok_clone/constants/sizes.dart';

class VideoRecordingScreen extends StatefulWidget {
  static String routeName = "/";

  const VideoRecordingScreen({Key? key}) : super(key: key);

  @override
  State<VideoRecordingScreen> createState() => _VideoRecordingScreenState();
}

class _VideoRecordingScreenState extends State<VideoRecordingScreen> {
  // Flag here
  bool _hasPermission = false;

  bool _selfMode = false;

  late FlashMode _flashMode;

  bool _permissionDenied = false;

  late CameraController _cameraController;

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

  Future<void> _setFlashMode(FlashMode newFlashMode) async {
    await _cameraController.setFlashMode(newFlashMode);
    _flashMode = newFlashMode;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    initPermission();
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
                            IconButton(
                              color: _flashMode == FlashMode.off ? Colors.amber.shade200 : Colors.white,
                              onPressed: () => _setFlashMode(FlashMode.off),
                              icon: const Icon(
                                Icons.flash_off_rounded,
                              ),
                            ),
                            Gaps.v10,
                            IconButton(
                              color: _flashMode == FlashMode.always ? Colors.amber.shade200 : Colors.white,
                              onPressed: () => _setFlashMode(FlashMode.always),
                              icon: const Icon(
                                Icons.flash_on_rounded,
                              ),
                            ),
                            Gaps.v10,
                            IconButton(
                              color: _flashMode == FlashMode.auto ? Colors.amber.shade200 : Colors.white,
                              onPressed: () => _setFlashMode(FlashMode.auto),
                              icon: const Icon(
                                Icons.flash_auto_rounded,
                              ),
                            ),
                            Gaps.v10,
                            IconButton(
                              color: _flashMode == FlashMode.torch ? Colors.amber.shade200 : Colors.white,
                              onPressed: () => _setFlashMode(FlashMode.torch),
                              icon: const Icon(
                                Icons.flashlight_on_rounded,
                              ),
                            ),
                          ],
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
