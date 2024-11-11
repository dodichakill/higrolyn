import 'package:agrolyn/shared/constants.dart';
import 'package:agrolyn/views/detection/detection_result_screen.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class DetectionScanScreen extends StatefulWidget {
  const DetectionScanScreen({super.key});

  @override
  _DetectionScanScreenState createState() => _DetectionScanScreenState();
}

class _DetectionScanScreenState extends State<DetectionScanScreen> {
  CameraController? _cameraController;
  List<CameraDescription>? _cameras;
  bool _isCameraInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    // Meminta izin akses kamera
    if (await Permission.camera.request().isGranted) {
      _cameras = await availableCameras();
      if (_cameras != null && _cameras!.isNotEmpty) {
        _cameraController = CameraController(
          _cameras![0],
          ResolutionPreset.high,
        );

        await _cameraController!.initialize();
        setState(() {
          _isCameraInitialized = true;
        });
      }
    } else {
      // Tangani jika izin tidak diberikan
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Izin kamera ditolak')),
      );
    }
  }

  Future<void> _takePicture() async {
    if (!_cameraController!.value.isInitialized) return;

    final directory = await getApplicationDocumentsDirectory();
    final imagePath = '${directory.path}/${DateTime.now()}.png';

    try {
      await _cameraController!.takePicture().then((XFile file) {
        // file.saveTo(imagePath);
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(content: Text('Foto tersimpan di $imagePath')),
        // );
        pushWithoutNavBar(context,
            MaterialPageRoute(builder: (context) => DetectionResultScreen()));
      });
    } catch (e) {
      print('Error taking picture: $e');
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isCameraInitialized
          ? Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height - 70,
                  child: AspectRatio(
                    aspectRatio: _cameraController!.value.aspectRatio,
                    child: CameraPreview(
                      _cameraController!,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyColors.primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: _takePicture,
                  child: const Text(
                    'Ambil Foto',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
