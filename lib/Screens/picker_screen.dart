// lib/screens/picker_screen.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PickerScreen extends StatefulWidget {
  const PickerScreen({super.key});
  @override
  State<PickerScreen> createState() => _PickerScreenState();
}

class _PickerScreenState extends State<PickerScreen> {
  File? _pickedImage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final xFile = await picker.pickImage(source: ImageSource.gallery);
    if (xFile != null) {
      setState(() => _pickedImage = File(xFile.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gallery Picker')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _pickedImage == null
                ? const Text('No image selected')
                : Image.file(_pickedImage!, width: 100, height: 100),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: _pickImage,
                child: const Text('Select from Gallery')),
          ],
        ),
      ),
    );
  }
}