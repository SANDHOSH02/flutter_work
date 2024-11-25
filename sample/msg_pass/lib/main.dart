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
      initialRoute: '/',
      routes: {
        '/': (context) => const StaffDashboard(),
        '/student': (context) => const StudentDashboard(),
      },
    );
  }
}

class StaffDashboard extends StatefulWidget {
  const StaffDashboard({Key? key}) : super(key: key);

  @override
  _StaffDashboardState createState() => _StaffDashboardState();
}

class _StaffDashboardState extends State<StaffDashboard> {
  Uint8List? _imageBytes; // To store the image in a web-compatible format
  XFile? _pickedFile;

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes(); // Convert image to bytes
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
      appBar: AppBar(
        title: const Text('Staff Dashboard'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Welcome to Staff Dashboard',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              _imageBytes != null
                  ? Image.memory(
                      _imageBytes!,
                      height: 200,
                      width: 200,
                      fit: BoxFit.cover,
                    )
                  : const Text('No Image Selected'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: pickImage,
                child: const Text('Select Image'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: uploadImage,
                child: const Text('Upload Image'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (_imageBytes != null) {
                    Navigator.pushNamed(
                      context,
                      '/student',
                      arguments: _imageBytes, // Pass the image to the Student page
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please upload an image first!'),
                      ),
                    );
                  }
                },
                child: const Text('Go to Student Page'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StudentDashboard extends StatelessWidget {
  const StudentDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Uint8List? imageBytes = ModalRoute.of(context)!.settings.arguments as Uint8List?;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Dashboard'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Uploaded Image',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            imageBytes != null
                ? Image.memory(
                    imageBytes,
                    height: 200,
                    width: 200,
                    fit: BoxFit.cover,
                  )
                : const Text('No Image Available'),
          ],
        ),
      ),
    );
  }
}
