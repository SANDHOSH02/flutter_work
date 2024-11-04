import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Request extends StatefulWidget {
  const Request({super.key});

  @override
  _RequestState createState() => _RequestState();
}

class _RequestState extends State<Request> {
  int _selectedIndex = 2; // Default to Requests page
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _periodController = TextEditingController();
  final TextEditingController _staffController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();

  @override
  void dispose() {
    _dateController.dispose();
    _periodController.dispose();
    _staffController.dispose();
    _reasonController.dispose();
    super.dispose();
  }

  void _sendRequest() {
    print("Request Sent");
    // Add any request submission logic here
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      Navigator.pop(context); // Return to Home when "Home" is clicked
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with profile picture, name, and notification icon
            Row(
              children: [
                const CircleAvatar(
                  radius: 32,
                  backgroundImage: AssetImage('assets/main.png'),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'John Doe',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Staff - Teacher',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
                const Spacer(),
                IconButton(
                  icon: SvgPicture.asset(
                    'assets/bell.svg',
                    color: Colors.deepPurple,
                    height: 24,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Main Content Title
            const Text(
              'Staff Submission Request',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // Input fields
            TextField(
              controller: _dateController,
              decoration: InputDecoration(
                labelText: 'Date',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _periodController,
              decoration: InputDecoration(
                labelText: 'Period',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _staffController,
              decoration: InputDecoration(
                labelText: 'Staff',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _reasonController,
              decoration: InputDecoration(
                labelText: 'Reason',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            // Send Request Button
            ElevatedButton(
              onPressed: _sendRequest,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 202, 191, 223),
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const Text(
                'Send Request',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 30),
            // Request Status Section
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.grey, width: 1.5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Request Status',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(Icons.pending, color: Colors.orange[600]),
                      const SizedBox(width: 8),
                      const Text(
                        'Pending',
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/home.svg',
              color: _selectedIndex == 0 ? Colors.deepPurple : Colors.grey,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/menu.svg',
              color: _selectedIndex == 1 ? Colors.deepPurple : Colors.grey,
            ),
            label: 'Attendance',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/request.svg',
              color: _selectedIndex == 2 ? Colors.deepPurple : Colors.grey,
            ),
            label: 'Requests',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/profile.svg',
              color: _selectedIndex == 3 ? Colors.deepPurple : Colors.grey,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
