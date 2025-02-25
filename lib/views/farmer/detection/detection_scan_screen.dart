import 'dart:io';
import 'package:agrolyn/api/detection_ext_service.dart';
import 'package:agrolyn/api/detection_service.dart';
import 'package:agrolyn/shared/constants.dart';
import 'package:agrolyn/views/farmer/detection/detection_result_screen.dart';
import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetectionScanScreen extends StatefulWidget {
  const DetectionScanScreen({super.key});

  @override
  _DetectionScanScreenState createState() => _DetectionScanScreenState();
}

class _DetectionScanScreenState extends State<DetectionScanScreen>
    with SingleTickerProviderStateMixin {
  CameraController? _cameraController;
  List<CameraDescription>? _cameras;
  bool _isCameraInitialized = false;
  late AnimationController _animationController;
  late Animation<double> _scanAnimation;
  bool loading = false;
  late String imgPath;

  @override
  void initState() {
    super.initState();
    _initializeCamera();

    // Setup Animation Controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    // Define the scan animation
    _scanAnimation =
        Tween<double>(begin: 0.0, end: .9).animate(_animationController);
  }

  Future<void> _initializeCamera() async {
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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Izin kamera ditolak')),
      );
    }
  }

  Future<void> _processImage(File file) async {
    setState(() {
      loading = true;
      imgPath = file.path;
    });

    try {
      var formData = FormData.fromMap({
        'img_pred':
            await MultipartFile.fromFile(file.path, filename: 'scan.jpg'),
      });

      var formData2 = FormData.fromMap({
        'img_pred':
            await MultipartFile.fromFile(file.path, filename: 'scan.jpg'),
      });

      await DetectionExtService()
          .fetchPredictCornDisease(formData)
          .whenComplete(() async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String disease = prefs.getString('disease') ?? '';
        await DetectionService()
            .fetchPredictCornDisease(disease, formData2)
            .whenComplete(() {
          setState(() {
            loading = false;
          });
          context.loaderOverlay.hide();
          pushWithoutNavBar(
              context,
              MaterialPageRoute(
                  builder: (context) => const DetectionResultScreen()));
        });
      });
    } catch (e) {
      print('Error processing image: $e');
      setState(() {
        loading = false;
      });
    }
  }

  Future<void> _takePicture() async {
    if (!_cameraController!.value.isInitialized) return;

    final directory = await getApplicationDocumentsDirectory();
    final imagePath = '${directory.path}/${DateTime.now()}.png';

    try {
      context.loaderOverlay.show();

      XFile file = await _cameraController!.takePicture();
      await _processImage(File(file.path));
    } catch (e) {
      print('Error taking picture: $e');
      setState(() {
        loading = false;
      });
    }
  }

  Future<void> _pickImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      await _processImage(File(pickedFile.path));
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
      body: GlobalLoaderOverlay(
        overlayColor: Colors.green,
        overlayWidgetBuilder: (progress) {
          return const Center(
            child: SizedBox(
              width: 300,
              height: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: Colors.white,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Sedang Memproses...',
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          );
        },
        child: _isCameraInitialized
            ? Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height - 130,
                    child: AspectRatio(
                        aspectRatio: _cameraController!.value.aspectRatio,
                        child: Stack(
                          children: [
                            CameraPreview(_cameraController!),
                            AnimatedBuilder(
                              animation: _scanAnimation,
                              builder: (context, child) {
                                return CustomPaint(
                                  painter: ScanPainter(
                                      scanPosition: _scanAnimation.value),
                                  child: Container(),
                                );
                              },
                            ),
                          ],
                        )),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 200,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: MyColors.primaryColor,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: loading ? null : _takePicture,
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.camera_alt_rounded,
                                    color: Colors.white),
                                SizedBox(width: 10),
                                Text(
                                  'Ambil Foto',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            )),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: 200,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: MyColors.primaryColor,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: loading ? null : _pickImageFromGallery,
                          child: loading
                              ? const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: CircularProgressIndicator(
                                    color: Colors.green,
                                    semanticsLabel:
                                        "Sedang Mengidentifikasi Tanaman",
                                  ),
                                )
                              : const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.image, color: Colors.white),
                                    SizedBox(width: 10),
                                    Text(
                                      'Pilih dari Galeri',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

class ScanPainter extends CustomPainter {
  final double scanPosition;

  ScanPainter({required this.scanPosition});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color.fromARGB(255, 1, 81, 180).withOpacity(0.5)
      ..strokeWidth = 5.0
      ..style = PaintingStyle.stroke;
    final lineY = size.height * scanPosition;
    canvas.drawLine(
      Offset(0, lineY),
      Offset(size.width, lineY),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
