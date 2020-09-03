import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';

import 'package:liondnafx/pages/freemium.dart';
import 'package:liondnafx/pages/notifications.dart';
import 'package:liondnafx/pages/packages.dart';
import 'package:liondnafx/pages/premium.dart';
import 'package:liondnafx/pages/settings.dart';
import 'package:liondnafx/services/database.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class TabHome extends StatefulWidget {
  @override
  _TabHomeState createState() => _TabHomeState();
}

class _TabHomeState extends State<TabHome> {
  Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  int _selectedIndex = 0;
  String _deviceID = 'null';
  PageController controller = PageController();
  int modifiedIndex;
  final List<Widget> _children = [
    Premium(),
    Freemium(),
    Notifications(),
    Packages(),
    Settings(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context);
    prefs.then((SharedPreferences prefs) {
      if (prefs.containsKey('deviceId')) {
        print('deviceID set');
      } else {
        print('no deviceId set');
        prefs.setString('deviceId', database.getDeviceID());
        final deviceData = {
          'id': database.getDeviceID(),
          'plan': '0',
          'remaining': 0
        };
        database.addDevice(deviceData);
      }
    });
    return MaterialApp(
      home: Scaffold(
//        appBar: AppBar(
//          title: const Text('Plugin example app'),
//        ),
        body: PageView.builder(
          physics: NeverScrollableScrollPhysics(),
          onPageChanged: (page) {
            setState(() {
              _selectedIndex = page;
            });
//          updateTab(page);
//          getTab();
//          setState(() {
//            selectedIndex = page;
//          });
          },
          controller: controller,
          itemBuilder: (context, position) {
            return Container(child: _children[_selectedIndex ?? 0],);
          },
          itemCount: 4, // Can be null
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.bubble_chart),
              title: Text('Premium'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.show_chart),
              title: Text('Signals'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications_none),
              activeIcon: Icon(Icons.notifications),
              title: Text('Notifications'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.layers),
              title: Text('Store'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              title: Text('Settings'),
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Color(0xFFb8891f),
          unselectedItemColor: Colors.grey[800],
          showUnselectedLabels: false,
          iconSize: 24,
          unselectedLabelStyle: TextStyle(color: Colors.grey, fontSize: 10),
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}