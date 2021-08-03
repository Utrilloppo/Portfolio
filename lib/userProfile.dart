import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/changeUserIcon.dart';
import 'package:news_app/threadMain.dart';

import 'commons/const.dart';

class UserProfile extends StatefulWidget {
  final MyProfileData myData;
  UserProfile({required this.myData});

  @override
  State<StatefulWidget> createState() => _UserProfile();
}

class _UserProfile extends State<UserProfile> {
  //String myThumbnail = widget.myData.myThumbnail;
  String myThumbnail = "004-bear-1.png";
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Card(
          elevation: 2.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 60,
                    width: 60,
                    child: Column(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          child: Image.asset(
                            "images/${widget.myData.myThumbnail}",
                          ),
                        ),
                        Text(
                          "Images",
                          style: TextStyle(
                              color: Colors.blue[900],
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        )
                      ],
                    ),
                  ),
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => ChangeUserIcon(
                      myData: widget.myData,
                    ),
                    barrierDismissible: true,
                  );
                },
              ),
              Text(
                "Your Name: ${widget.myData.myName}",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
