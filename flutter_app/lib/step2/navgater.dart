import 'package:flutter/material.dart';

class BottomNavgater extends StatefulWidget {
  BottomNavgater({Key key}) : super(key: key);
  _State createState() => _State();
}

class _State extends State<BottomNavgater> {
  int index=0;
  List<Widget> list = List();
  @override
  void initState() {
    list
      ..add(Detail(title: "Home"))
      ..add(Detail(title: "Email"))
      ..add(Detail(title: "Pages"))
      ..add(Detail(title: "AipPlay"))
      ..add(Detail(title: "home5"));

    super.initState();
  }

  final _BottomNavigationColor = Colors.blue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: list[index],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: _BottomNavigationColor,
              ),
              title: Text('Home',
                  style: TextStyle(color: _BottomNavigationColor))),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.email,
                color: _BottomNavigationColor,
              ),
              title: Text('Email',
                  style: TextStyle(color: _BottomNavigationColor))),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.pages,
                color: _BottomNavigationColor,
              ),
              title: Text('Pages',
                  style: TextStyle(color: _BottomNavigationColor))),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.airplay,
                color: _BottomNavigationColor,
              ),
              title: Text('AipPlay',
                  style: TextStyle(color: _BottomNavigationColor))),
        ],
        type: BottomNavigationBarType.fixed,
        onTap: (i) => {
              setState(() => index = i)
            },
      ),
    );
  }
}

class Detail extends StatelessWidget {
  final String title;
  Detail({Key key, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Text(title),
    );
  }
}
