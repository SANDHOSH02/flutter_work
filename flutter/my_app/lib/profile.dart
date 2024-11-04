import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Top bar with profile picture, name, and notification icon
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
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
          ),
          const SizedBox(height: 20),
          // Profile details
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildProfileDetail('Work', 'Senior Lecturer'),
                  _buildProfileDetail('Education', 'Ph.D. in Computer Science'),
                  _buildProfileDetail('College', 'NSCET Engineering College'),
                  _buildProfileDetail('Email', 'john.doe@example.com'),
                  _buildProfileDetail('Area of Interest', 'Machine Learning, Data Science, AI'),
                  _buildProfileDetail('Phone Number', '+1234567890'),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 3, // set to profile index
        onTap: (index) {
          // Handle navigation if needed
          Navigator.pop(context); // Return to previous page if tapped on bottom nav
        },
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/home.svg',
              color: Colors.grey,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/menu.svg',
              color: Colors.grey,
            ),
            label: 'Attendance',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/request.svg',
              color: Colors.grey,
            ),
            label: 'Requests',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/profile.svg',
              color: Colors.deepPurple,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  // Helper method to create a detail row with title and value
  Widget _buildProfileDetail(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$title:',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
