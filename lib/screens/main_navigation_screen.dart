import 'package:flutter/material.dart';
import 'settings_screen.dart';
import 'home_dashboard_screen.dart';
import 'library_screen.dart';
import 'scanner_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int currentIndex = 0;

  final pages = [
    const HomeDashboardScreen(),
    const ScannerScreen(),
    const LibraryScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: NavigationBar(
        height: 80,
        backgroundColor: const Color(0xff121A2A),
        selectedIndex: currentIndex,
        indicatorColor: const Color(0xff00B4D8),
        onDestinationSelected: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_rounded), label: "Home"),
          NavigationDestination(
            icon: Icon(Icons.document_scanner_rounded),
            label: "Scanner",
          ),
          NavigationDestination(
            icon: Icon(Icons.folder_rounded),
            label: "Library",
          ),
          NavigationDestination(icon: Icon(Icons.settings), label: "Settings"),
        ],
      ),
    );
  }
}
