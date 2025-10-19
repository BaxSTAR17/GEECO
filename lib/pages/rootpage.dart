import 'package:flutter/material.dart';
import 'package:lazy_load_indexed_stack/lazy_load_indexed_stack.dart';
import 'package:geeco/modules/globalbottomnav.dart';
import 'package:geeco/pages/homepage.dart';
import 'package:geeco/pages/scans.dart';
import 'package:geeco/pages/editor.dart';
import 'package:geeco/pages/settings.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _selectedIndex = 0;
  double appBarBorderRadius = 100000.0;

  final List<Widget> _pages = [
    HomePage(),
    ScansPage(),
    EditorPage(),
    SettingsPage(),
  ];

  final List<String> _pageNames = const [
    "Home",
    "Eco-Lens",
    "Editor",
    "Settings",
  ];

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
      if (index == 2) {
        appBarBorderRadius = 0.0;
      }
      else {
        appBarBorderRadius = 100000.0;
      }
      
    });

    
      
  }
    

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child:Text(
            _pageNames[_selectedIndex], 
            style: TextStyle(
              color: Colors.white,
              fontFamily: "Gabarito"
            )
          )
        ),
        backgroundColor: Color(0xFF022000),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(appBarBorderRadius), bottomRight: Radius.circular(appBarBorderRadius)),
        ),
      ),
      body: LazyLoadIndexedStack(
        index: _selectedIndex,
        autoDisposeIndexes: List.generate(_pages.length, (i) => i),
        children: _pages,
      ),
      bottomNavigationBar: GlobalBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped
      ),
    );
  }
}