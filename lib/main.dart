import 'package:flutter/material.dart';
import 'package:news_app/threadMain.dart';
import 'package:news_app/userProfile.dart';
import 'package:news_app/utils.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: MyHomePage(
        title: null,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, title}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabSection);
    super.initState();
  }

  void _handleTabSection() => setState(() {});

  void onTabTapped(int index) {
    setState(() {
      _tabController.index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Portfolio"),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ThreadMain(),
          UserProfile(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          onTap: onTabTapped,
          currentIndex: _tabController.index,
          selectedItemColor: Colors.amber[900],
          unselectedItemColor: Colors.grey[800],
          showUnselectedLabels: true,
          items: [
            BottomNavigationBarItem(
                icon: new Icon(Icons.brightness_7), title: new Text("Thread")),
            BottomNavigationBarItem(
                icon: new Icon(Icons.people), title: new Text("Profile")),
          ]),
    );
  }
}
