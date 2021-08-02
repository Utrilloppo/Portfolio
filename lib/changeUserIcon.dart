import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'commons/const.dart';

class ChangeUserIcon extends StatefulWidget {
  final MyProfileData myData;
  ChangeUserIcon({required this.myData});

  @override
  State<StatefulWidget> createState() => _ChangeUserIcon();
}

class _ChangeUserIcon extends State<ChangeUserIcon> {
  String myThumbnail = "004-bear-1.png";

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SimpleDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16))),
          contentPadding: EdgeInsets.zero,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).size.height * 0.12,
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
        ),
        Positioned(
          bottom: 10,
          right: 10,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 2, right: 2),
                child: ClipOval(
                  child: Container(
                    color: Colors.blue,
                    height: 60.0,
                    width: 60.0,
                    child: RaisedButton(
                      elevation: 8.0,
                      color: Colors.black,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.close,
                        size: 32,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        )
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
