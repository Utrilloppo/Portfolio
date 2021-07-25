import 'package:flutter/material.dart';
import 'package:news_app/utils.dart';

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
        postTimeStamp: DateTime.now()
            .subtract(new Duration(hours: 2))
            .millisecondsSinceEpoch,
        postContent: "This is Content",
        postCommentCount: 2,
        postLikeCount: 4,
        postImage: ''),
    new ThreadPostData(
        userName: "Miyu",
        userThumbnail: "",
        postTimeStamp: DateTime.now()
            .subtract(new Duration(seconds: 2))
            .millisecondsSinceEpoch,
        postContent:
            "This is a Contenaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaat",
        postCommentCount: 2,
        postLikeCount: 4,
        postImage: ''),
    new ThreadPostData(
        userName: "OmOm",
        userThumbnail: "",
        postTimeStamp: DateTime.now()
            .subtract(new Duration(days: 7))
            .millisecondsSinceEpoch,
        postContent: "This is the Content",
        postCommentCount: 2,
        postLikeCount: 4,
        postImage: ''),
  ];

  bool _isLoading = false;

  void initState() {
    //_takeUserDataFromFireBase();
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
                  color: Colors.white.withOpacity(0.7),
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
    child: Column(
      children: [
        Card(
            elevation: 2.0,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.book,
                          size: 34,
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            data.userName,
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            readTimestamp(data.postTimeStamp),
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Divider(
                    height: 4,
                    color: Colors.black,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(4, 10, 4, 10),
                  ),
                  Text(
                    data.postContent,
                    style: TextStyle(fontSize: 16),
                  ),
                  Divider(
                    height: 4,
                    color: Colors.black,
                  ),
                  Row(
                    children: [
                      Row(
                        children: [Icon(Icons.favorite_border), Text("Like")],
                      ),
                      Row(
                        children: [Icon(Icons.mode_comment), Text("Comment")],
                      ),
                    ],
                  ),
                ],
              ),
            )

//       ListTile(
//         onTap: () {
//           print("Tap");
//         },
//         title: Text(
//           data.postContent,
//           style: TextStyle(fontSize: 18),
//         ),
//       ),

            ),
        Container(
          height: 4,
        )
      ],
    ),
  );
}
