import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:news_app/commons/const.dart';
import 'package:news_app/commons/utils.dart';
import 'package:news_app/threadMain.dart';
import 'package:news_app/userProfile.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        primarySwatch: Colors.grey,
      ),
      home: MyHomePage(),
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
  late MyProfileData myData;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabSection);
    _takeData();

    super.initState();
  }

  Future<void> _takeData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String myThumbnail;
    String myName;

    if (prefs.get('myThumbnail') == null) {
      String tempThumbnail = iconImageList[Random().nextInt(50)];
      prefs.setString('myThumbnail', tempThumbnail);
      myThumbnail = tempThumbnail;
    } else {
      myThumbnail = prefs.get("myThumbnail").toString();
    }

    if (prefs.get('myName') == null) {
      String tempName = Utils.getRandomString(8);
      prefs.setString('myName', tempName);
      myName = tempName;
    } else {
      myName = prefs.get('myName').toString();
    }
    setState(() {
      myData = MyProfileData(myName: myName, myThumbnail: myThumbnail);
    });
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
          ThreadMain(
            myData: myData,
          ),
          UserProfile(
            myData: myData,
          ),
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
