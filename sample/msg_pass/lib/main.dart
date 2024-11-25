import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: UploadImageScreen(),
    );
  }
}

class UploadImageScreen extends StatefulWidget {
  @override
  _UploadImageScreenState createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  Uint8List? _imageBytes; // To store the image in a web-compatible format
  XFile? _pickedFile;

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes(); // Convert image to bytes for Flutter Web
      setState(() {
        _imageBytes = bytes;
        _pickedFile = pickedFile;
      });
    }
  }

  Future<void> uploadImage() async {
    if (_pickedFile == null) return;

    final uri = Uri.parse("http://localhost/sample_flutter/upload.php"); // Replace with your server URL
    final request = http.MultipartRequest('POST', uri);

    request.files.add(
      http.MultipartFile.fromBytes(
        'image',
        _imageBytes!,
        filename: basename(_pickedFile!.path),
        contentType: MediaType('image', 'png'), // Adjust content type as needed
      ),
    );

    final response = await request.send();

    if (response.statusCode == 200) {
      print("Image uploaded successfully!");
    } else {
      print("Image upload failed with status: ${response.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upload Image')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _imageBytes != null
                ? Image.memory(_imageBytes!, height: 200, width: 200, fit: BoxFit.cover)
                : const Text('No Image Selected'),
            ElevatedButton(
              onPressed: pickImage,
              child: const Text('Select Image'),
            ),
            ElevatedButton(
              onPressed: uploadImage,
              child: const Text('Upload Image'),
            ),
          ],
        ),
      ),
    );
  }
}
