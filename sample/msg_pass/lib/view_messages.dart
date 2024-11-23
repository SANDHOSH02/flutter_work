// view_messages.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ViewMessagesPage extends StatefulWidget {
  const ViewMessagesPage({super.key});

  @override
  State<ViewMessagesPage> createState() => _ViewMessagesPageState();
}

class _ViewMessagesPageState extends State<ViewMessagesPage> {
  List<String> _messages = [];

  // Function to fetch messages from the database
  Future<void> _fetchMessages() async {
    final url = Uri.parse('http://localhost/sample_flutter/get_messages.php'); // Replace with your backend API URL

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        // Assuming the server responds with a list of messages
        setState(() {
          _messages = List<String>.from(response.body.split(',')); // You may need to adjust based on your API response
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to load messages!')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchMessages(); // Fetch messages when the page is loaded
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Messages'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _messages.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_messages[index]),
                  );
                },
              ),
      ),
    );
  }
}
