import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class ThreadPostData {
  late final String userName;
  late final String userThumbnail;
  late final int postTimeStamp;
  late final String postContent;
  late final String postImage;
  late final int postLikeCount;
  late final int postCommentCount;

  ThreadPostData(
      {required this.userName,
      required this.userThumbnail,
      required this.postTimeStamp,
      required this.postContent,
      required this.postImage,
      required this.postCommentCount,
      required this.postLikeCount});
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<ThreadPostData> dummyData = [
    new ThreadPostData(
        userName: "userTest1",
        userThumbnail: "",
        postTimeStamp: 202000,
        postContent: "This is Content",
        postCommentCount: 2,
        postLikeCount: 4,
        postImage: ''),
    new ThreadPostData(
        userName: "userTest1",
        userThumbnail: "",
        postTimeStamp: 202000,
        postContent: "This is Content",
        postCommentCount: 2,
        postLikeCount: 4,
        postImage: ''),
    new ThreadPostData(
        userName: "userTest1",
        userThumbnail: "",
        postTimeStamp: 202000,
        postContent: "This is Content",
        postCommentCount: 2,
        postLikeCount: 4,
        postImage: ''),
  ];

  bool _isLoading = false;

  void initState() {
    _takeUserDataFromFireBase();
    super.initState();
  }

  Future<void> _takeUserDataFromFireBase() async {
    setState(() {
      _isLoading = true;
    });
  }

  void _incrementCounter() {
    setState(() {
      print("WritePost");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Stack(
        children: [
          ListView(
            shrinkWrap: true,
            children: dummyData.map(_listTile).toList(),
          ),
          _isLoading
              ? Positioned(
                  child: Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ))
              : Container()
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

Widget _listTile(ThreadPostData data) {
  return Padding(
    padding: const EdgeInsets.all(2.0),
    child: Card(
      elevation: 2.0,
      child: ListTile(
        onTap: () {
          print("Tap");
        },
        title: Text(
          data.postContent,
          style: TextStyle(fontSize: 18),
        ),
      ),
    ),
  );
}
