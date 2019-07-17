import 'package:flutter/material.dart';

class BottomNavgater extends StatefulWidget {
  BottomNavgater({Key key}) : super(key: key);
  _State createState() => _State();
}

class _State extends State<BottomNavgater> {
  final _BottomNavigationColor = Colors.blue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: _BottomNavigationColor,
            ),
            title:
                Text('Home', style: TextStyle(color: _BottomNavigationColor))),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.email,
              color: _BottomNavigationColor,
            ),
            title:
                Text('Email', style: TextStyle(color: _BottomNavigationColor))),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.pages,
              color: _BottomNavigationColor,
            ),
            title:
                Text('Pages', style: TextStyle(color: _BottomNavigationColor))),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.airplay,
              color: _BottomNavigationColor,
            ),
            title: Text('AipPlay',
                style: TextStyle(color: _BottomNavigationColor))),
      ], type: BottomNavigationBarType.fixed),
    );
  }
}
