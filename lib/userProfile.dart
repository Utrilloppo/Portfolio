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
                child: Container(
                  height: 40,
                  width: 40,
                  child: Image.asset(
                    "images/${widget.myData.myThumbnail}",
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
        Expanded(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: GridView.count(
                crossAxisCount: 5,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                padding: const EdgeInsets.all(8.0),
                //childAspectRatio: size.width * 0.00174,
                physics: ScrollPhysics(),
                shrinkWrap: true,
                children: iconImageList.map(_makeGridTile).toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _makeGridTile(String userIconPath) {
    return GridTile(
      child: GestureDetector(
        onTap: () {
          print("You chose $userIconPath");
          setState(() {
            myThumbnail = userIconPath;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            color: userIconPath == myThumbnail ? Colors.yellow : Colors.white,
            border: userIconPath == myThumbnail
                ? Border.all(width: 2, color: Colors.red)
                : null,
          ),
          child: Image.asset(
            "images/$userIconPath",
          ),
        ),
      ),
    );
  }
}
