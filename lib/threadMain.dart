import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/commons/const.dart';
import 'package:news_app/commons/utils.dart';
import 'package:news_app/writePost.dart';

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

class ThreadMain extends StatefulWidget {
  late final MyProfileData myData;
  ThreadMain({required this.myData});

  @override
  State<StatefulWidget> createState() => _ThreadMain();
}

class _ThreadMain extends State<ThreadMain> {
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
            " TestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTest",
        postCommentCount: 2,
        postLikeCount: 4,
        postImage: ''),
    new ThreadPostData(
        userName: "OmOm",
        userThumbnail: "",
        postTimeStamp: DateTime.now()
            .subtract(new Duration(days: 7))
            .millisecondsSinceEpoch,
        postContent: FirebaseFirestore.instance
            .collection("test")
            .doc("come")
            .get()
            .toString(),
        postCommentCount: 2,
        postLikeCount: 22,
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
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => WritePost()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection("thread").snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return LinearProgressIndicator();
              return Stack(
                children: [
                  snapshot.data!.docs.length > 0
                      ? ListView(
                          shrinkWrap: true,
                          children: snapshot.data!.docs.map(_listTile).toList(),
                        )
                      : Container(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.error),
                                Padding(
                                  padding: const EdgeInsets.all(14.0),
                                  child: Text(
                                    "Message",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey[700],
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                  _isLoading
                      ? Positioned(
                          child: Container(
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                            color: Colors.white.withOpacity(0.7),
                          ),
                        )
                      : Container(),
                ],
              );
            },
          ),
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

Widget _listTile(DocumentSnapshot data) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(2, 2, 2, 6),
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
                      Text(
                        data["userName"],
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Container(
                          child: Text(
                            readTimestamp(data["postTimeStamp"]),
                            style:
                                TextStyle(fontSize: 16, color: Colors.black87),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(4, 10, 4, 10),
                    child: Text(
                      data["postContent"],
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Divider(
                    height: 4,
                    color: Colors.black,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 6, bottom: 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.favorite_border,
                              size: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Text(
                                "Like(${data["postLikeCount"]})",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.mode_comment),
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Text(
                                "Comment(${data["postCommentCount"]})",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
