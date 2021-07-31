import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/threadMain.dart';

class UserProfile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UserProfile();
}

class _UserProfile extends State<UserProfile> {
  List<String> iconImageList = [
    "001-panda.png",
    "002-lion.png",
    "003-tiger.png",
    "004-bear-1.png",
    "005-parrot.png",
    "006-rabbit.png",
    "007-chameleon.png",
    "008-sloth.png"
  ];

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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.book,
                  size: 26,
                ),
              ),
              Text(
                "Your Name: Miyu",
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
                childAspectRatio: size.width * 0.00174,
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
        child: GestureDetector(child: Image.asset("images/$userIconPath")));
  }
}
