import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WritePost extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WritePost();
}

class _WritePost extends State<WritePost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Writing Post"),
        centerTitle: true,
      ),
      body: Text("Write Post"),
    );
  }
}
