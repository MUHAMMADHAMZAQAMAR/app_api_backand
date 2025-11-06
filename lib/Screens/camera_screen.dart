// lib/screens/camera_screen.dart
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:io';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});
  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late Future<void> _initFuture;
  String? _imagePath;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    final cameras = await availableCameras();
    _controller = CameraController(cameras[0], ResolutionPreset.medium);
    _initFuture = _controller.initialize();
  }

  Future<void> _takePicture() async {
    await _initFuture;
    final xFile = await _controller.takePicture();
    setState(() => _imagePath = xFile.path);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Camera')),
      body: FutureBuilder<void>(
        future: _initFuture,
        builder: (c, s) {
          if (s.connectionState == ConnectionState.done) {
            return Stack(
              alignment: Alignment.bottomCenter,
              children: [
                CameraPreview(_controller),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: FloatingActionButton(
                    onPressed: _takePicture,
                    child: const Icon(Icons.camera),
                  ),
                ),
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: _imagePath != null
          ? FloatingActionButton(
        onPressed: () => setState(() => _imagePath = null),
        child: const Icon(Icons.clear),
      )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      body: _imagePath != null
          ? Center(child: Image.file(File(_imagePath!), height: 300))
          : null,
    );
  }
}