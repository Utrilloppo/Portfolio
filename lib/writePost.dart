import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:keyboard_actions/keyboard_actions_config.dart';

class WritePost extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WritePost();
}

class _WritePost extends State<WritePost> {
  final FocusNode _nodeText1 = FocusNode();
  TextEditingController writeTextController = TextEditingController();
  FocusNode writingTextFocus = FocusNode();
  bool _isLoading = false;

  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      keyboardBarColor: Colors.grey[200],
      nextFocus: true,
      actions: [
        KeyboardActionsItem(
          displayArrows: false,
          focusNode: _nodeText1,
        ),
        KeyboardActionsItem(
          displayArrows: false,
          focusNode: writingTextFocus,
          toolbarButtons: [
            (node) {
              return GestureDetector(
                onTap: () {
                  //   print("Close View");
                  //   Navigator.pop(context);
                  //   node.unfocus();
                },
                child: Container(
                  color: Colors.grey[200],
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.add_photo_alternate, size: 28),
                      Text(
                        "Add Image",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              );
            },
          ],
        ),
      ],
    );
  }

  Future<void> _sendFirePostInFirebase() async {
    FirebaseFirestore.instance.collection("thread").doc("").set({
      "userName": 'Tasaki Miyu',
      "userThumbnail": "",
      "postTimeStamp": DateTime.now().millisecondsSinceEpoch,
      "postContent": "This is test content",
      "postImage": "testUserName",
      "postLikeCount": 0,
      "postCommentCount": 22
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("Writing Post"),
        centerTitle: true,
        actions: [
          FlatButton(
              onPressed: () {
                print(" content is ${writeTextController.text}");
              },
              child: Text(
                "Post",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              )),
        ],
      ),
      body: KeyboardActions(
        config: _buildConfig(context),
        child: Column(
          children: [
            SizedBox(
              height: 28,
            ),
            Container(
              width: size.width,
              height:
                  size.height - MediaQuery.of(context).viewInsets.bottom, //Todo
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Icon(
                          Icons.book,
                          size: 30,
                        ),
                      ),
                      Text(
                        "Miyu",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Divider(
                    height: 1,
                    color: Colors.black,
                  ),
                  TextField(
                    autofocus: true,
                    focusNode: writingTextFocus,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Writing Anything",
                      hintMaxLines: 4,
                    ),
                    controller: writeTextController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
