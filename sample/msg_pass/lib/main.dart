import 'package:flutter/material.dart';
import 'student.dart'; // Import the student profile page.

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dashboard App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const DashboardPage(),
    );
  }
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final TextEditingController _msgController = TextEditingController();

  // Function to handle message submission
  Future<void> _submitMessage() async {
    final message = _msgController.text;

    if (message.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Message cannot be empty!')),
      );
      return;
    }

    // Call backend service to save the message in MySQL
    try {
      final response = await saveMessageToDatabase(message);

      if (response) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Message uploaded successfully!')),
        );
        _msgController.clear(); // Clear the text field
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to upload message!')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  // Simulated function to save data to the database (replace with actual backend logic)
  Future<bool> saveMessageToDatabase(String message) async {
    // Replace this with your HTTP request logic to save the message in MySQL
    await Future.delayed(const Duration(seconds: 1)); // Simulate delay
    return true; // Return success
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Details'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Upload Your Message:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _msgController,
              decoration: const InputDecoration(
                labelText: 'Enter your message',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _submitMessage,
              child: const Text('Submit'),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                // Navigate to student profile page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const StudentProfile()),
                );
              },
              child: const Text('Go to Student Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
