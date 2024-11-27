import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p; // Use alias here
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
        filename: p.basename(_pickedFile!.path),
        contentType: MediaType('image', 'png'), // Adjust content type as needed
      ),
    );

    final response = await request.send();

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Image uploaded successfully!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Upload failed with status: ${response.statusCode}')),
      );
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
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Welcome to the Staff Dashboard',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              // Dashboard cards
              Row(
                children: [
                  _buildDashboardCard(
                    title: 'Select Image',
                    icon: Icons.image_outlined,
                    onTap: pickImage,
                  ),
                  const SizedBox(width: 20),
                  _buildDashboardCard(
                    title: 'Upload Image',
                    icon: Icons.cloud_upload_outlined,
                    onTap: uploadImage,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _buildCircularImagePreview(),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_imageBytes != null) {
                      Navigator.pushNamed(
                        context,
                        '/student',
                        arguments: _imageBytes,
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please upload an image first!')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text('Go to Student Page'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDashboardCard({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 40, color: Colors.blueAccent),
                const SizedBox(height: 10),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCircularImagePreview() {
    return Center(
      child: _imageBytes != null
          ? CircleAvatar(
              radius: 80,
              backgroundImage: MemoryImage(_imageBytes!),
            )
          : CircleAvatar(
              radius: 80,
              backgroundColor: Colors.grey.shade300,
              child: const Icon(Icons.image, size: 40, color: Colors.grey),
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
              'Uploaded Image Preview',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            imageBytes != null
                ? CircleAvatar(
                    radius: 100,
                    backgroundImage: MemoryImage(imageBytes),
                  )
                : const Text(
                    'No Image Available',
                    style: TextStyle(color: Colors.red),
                  ),
          ],
        ),
      ),
    );
  }
}
