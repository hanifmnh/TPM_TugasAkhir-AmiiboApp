import 'package:flutter/material.dart';
import 'package:projectakhir/screen/dashboard_screen.dart';
import 'package:projectakhir/screen/favorite_screeen.dart';
import 'package:projectakhir/screen/other_screen.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({Key? key}) : super(key: key);

  @override
  _BottomNavbarState createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const DashboardScreen(),
    const FavoriteScreen(),
    const OtherScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.red,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.dashboard),
                label: 'Dashboard'
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label:'Favorite'
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.more_horiz),
                label:'Other Menu'
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.black,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
