import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'view_messages.dart'; // Import the new page

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Message Saver',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MessageSaverPage(),
    );
  }
}

class MessageSaverPage extends StatefulWidget {
  const MessageSaverPage({super.key});

  @override
  State<MessageSaverPage> createState() => _MessageSaverPageState();
}

class _MessageSaverPageState extends State<MessageSaverPage> {
  final TextEditingController _msgController = TextEditingController();

  // Function to save message to the database
  Future<void> _saveMessage() async {
    final message = _msgController.text;

    if (message.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Message cannot be empty!')),
      );
      return;
    }

    final url = Uri.parse('http://localhost/sample_flutter/save_message.php'); // Replace with your backend API URL

    try {
      final response = await http.post(
        url,
        body: {'message': message},
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Message saved successfully!')),
        );
        _msgController.clear();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to save message!')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  // Navigate to ViewMessagesPage
  void _goToMessagesPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ViewMessagesPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Message Saver'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Enter a message to save:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _msgController,
              decoration: const InputDecoration(
                labelText: 'Message',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _saveMessage,
              child: const Text('Save Message'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _goToMessagesPage,
              child: const Text('View Saved Messages'),
            ),
          ],
        ),
      ),
    );
  }
}
