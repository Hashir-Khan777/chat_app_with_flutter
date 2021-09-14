import 'package:chatappflutter/Controllers/chat_controller.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:get/get.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

class Chat extends StatefulWidget {
  final myData;
  final userData;
  const Chat({Key? key, this.myData, this.userData}) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final chatController = Get.put(ChatController());
  var uniqueId;
  var message;

  @override
  Widget build(BuildContext context) {
    if (widget.myData['_id'].toString().length >
        widget.userData['_id'].toString().length) {
      uniqueId = widget.myData['_id'] + widget.userData['_id'];
    } else {
      uniqueId = widget.userData['_id'] + widget.myData['_id'];
    }
    // final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
    //     .collection('Chats/$uniqueId/message')
    //     .snapshots();

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            '${widget.userData['name']}',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
          ),
        ),
      ),
      body: GetX<ChatController>(
        builder: (controller) {
          return Center(
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    child: ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: controller.messages.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            controller.messages[index]['message'],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(6),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'write a message...',
                      border: OutlineInputBorder(),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          controller.sendMessage(
                            message,
                            widget.myData['_id'],
                            widget.userData['_id'],
                            uniqueId,
                          );
                          setState(() {
                            message = '';
                          });
                        },
                        child: Transform.rotate(
                          angle: -math.pi / 4,
                          child: Icon(Icons.send),
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.text,
                    initialValue: message,
                    onChanged: (text) {
                      setState(() {
                        message = text;
                      });
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
