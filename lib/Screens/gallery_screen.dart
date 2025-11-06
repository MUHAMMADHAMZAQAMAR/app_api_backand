// lib/screens/gallery_screen.dart
import 'package:flutter/material.dart';
import '../utils/constants.dart';
import 'camera_screen.dart';
import 'map_screen.dart';
import 'picker_screen.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gallery')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Remote Images (live URLs)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: Constants.remoteImages
                  .map((url) => ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(url, width: 100, height: 100, fit: BoxFit.cover),
              ))
                  .toList(),
            ),
            const SizedBox(height: 20),

            const Text('Local Assets', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: ['img1.png', 'img2.png', 'img3.png']
                  .map((asset) => ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset('assets/$asset', width: 100, height: 100, fit: BoxFit.cover),
              ))
                  .toList(),
            ),
            const SizedBox(height: 30),

            Wrap(
              spacing: 12,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CameraScreen())),
                  child: const Text('Camera'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const MapScreen())),
                  child: const Text('Google Map'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PickerScreen())),
                  child: const Text('Pick from Gallery'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}