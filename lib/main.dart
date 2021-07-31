import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:news_app/threadMain.dart';
import 'package:news_app/userProfile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

//もしかして,,,

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
        backgroundColor: Colors.grey.withOpacity(0.9),
      ),
      // extendBodyBehindAppBar: true,
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
                icon: new Icon(Icons.water_damage_outlined),
                title: new Text("Thread")),
            BottomNavigationBarItem(
                icon: new Icon(Icons.people), title: new Text("Profile")),
          ]),
    );
  }
}
