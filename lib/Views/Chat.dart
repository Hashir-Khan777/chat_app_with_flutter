import 'package:flutter/material.dart';

class Chat extends StatefulWidget {
  final myData;
  final userData;
  const Chat({Key? key, this.myData, this.userData}) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            '${widget.userData['name']}',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
          ),
        ),
      ),
    );
  }
}
