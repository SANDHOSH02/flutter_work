import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'attendance.dart'; // Import the Attendance page
import 'request.dart'; // Import the Request page
import 'profile.dart'; // Import the Profile page

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const Center(child: Text('')),
    const Center(child: Text('')),
    const Center(child: Text('')),
    const Center(child: Text('')),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Attendance()),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Request()),
      );
    } else if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Profile()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 600, // Adjust width for centering on larger screens
          child: Column(
            children: [
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.deepPurple, width: 1.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.deepPurple, width: 2),
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Statistics',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 14),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildStatisticContainer('Classes', '5', 'assets/profile.svg', color: const Color(0xFF22A6B3)),
                        _buildStatisticContainer('Subjects', '8', 'assets/subject.svg', color: const Color(0xFF22A6B3)),
                        _buildStatisticContainer('Schedule', '3', 'assets/time_table.svg', isTwoLine: true, color: const Color(0xFF22A6B3)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildSmallContainer('Report', () {
                          print("Report tapped");
                        }, color: const Color(0xFFF0932B)),
                        _buildSmallContainer('Notes', () {
                          print("Notes tapped");
                        }, color: const Color(0xFFF0932B)),
                        _buildSmallContainer('News', () {
                          print("News tapped");
                        }, color: const Color(0xFFF0932B)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildSmallContainer('Classes', () {
                          print("Classes tapped");
                        }, color: Colors.blue),
                        _buildSmallContainer('Classes', () {
                          print("Classes tapped");
                        }, color: Colors.blue),
                        _buildSmallContainer('Classes', () {
                          print("Classes tapped");
                        }, color: Colors.blue),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Recent Updates',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: List.generate(10, (index) => _buildUpdateCard("Update #$index", "This is a summary of update #$index")),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: _pages[_selectedIndex],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        showSelectedLabels: true,
        showUnselectedLabels: true,
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

  Widget _buildStatisticContainer(String title, String count, String svgPath, {bool isTwoLine = false, required Color color}) {
    return Container(
      width: 100,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            svgPath,
            height: 32,
            color: Colors.white,
          ),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isTwoLine ? 14 : 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            count,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ],
      ),
    );
  }


  Widget _buildSmallContainer(String title, VoidCallback onTap, {required Color color}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUpdateCard(String title, String summary) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            summary,
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}


