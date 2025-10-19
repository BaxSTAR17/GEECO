import 'package:flutter/material.dart';
import 'package:geeco/modules/globalbottomnav.dart';
import 'package:geeco/pages/homepage.dart';
import 'package:geeco/pages/scans.dart';
import 'package:geeco/pages/editor.dart';
import 'package:geeco/pages/settings.dart';
import 'package:geeco/pages/about.dart';
import 'package:geeco/pages/welcome.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    HomePage(),
    ScansPage(),
    EditorPage(),
    SettingsPage(),
    AboutUs(),
  ];

  final List<String> _pageNames = const [
    "Home",
    "Eco-Lens",
    "Editor",
    "Settings",
    "About Us",
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // add this method
  void setSelectedIndex(int index) => setState(() => _selectedIndex = index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // allow the app bar area to be drawn over the top so we can inset it
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: SafeArea(
          bottom: false,
          child: Container(
            // increase top to move the rounded bar down; decrease to move up
            margin: const EdgeInsets.only(top: 10.0, left: 5.0, right: 5.0),
            height: 54,
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            decoration: BoxDecoration(
              color: const Color(0xFF022000),
              borderRadius: BorderRadius.circular(50.0),
            ),
            alignment: Alignment.centerLeft, // align text to the left
            child: Text(
              _pageNames[_selectedIndex],
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ),
      ),
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: GlobalBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
