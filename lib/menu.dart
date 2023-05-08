import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isCollapsed = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 207, 207, 219),
        title: Text('Collapsible Sidebar Menu'),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            setState(() {
              _isCollapsed = !_isCollapsed;
            });
          },
        ),
      ),
      body: Stack(
        children: [
          _buildSidebar(),
          _buildContent(),
        ],
      ),
    );
  }

  Widget _buildSidebar() {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      width: _isCollapsed ? 0.0 : 200.0,
      color: Color.fromARGB(255, 73, 7, 64),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(height: 50.0),
          _buildMenuItem(Icons.home, 'Home'),
          _buildMenuItem(Icons.settings, 'Settings'),
          _buildMenuItem(Icons.person, 'Profile'),
          _buildMenuItem(Icons.exit_to_app, 'Logout'),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.white,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
      onTap: () {
        // Handle menu item click here
      },
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Center(
        child: Text(
          'Content goes here',
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}
