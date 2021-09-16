import 'package:chatappflutter/Controllers/chat_controller.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:get/get.dart';

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
  final TextEditingController _message = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if ('${widget.myData['_id']}'.compareTo('${widget.userData['_id']}') < 0) {
      uniqueId = widget.myData['_id'] + widget.userData['_id'];
    } else {
      uniqueId = widget.userData['_id'] + widget.myData['_id'];
    }
    chatController.fetchMessages(uniqueId);

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
                          title: Align(
                            alignment: controller.messages[index]['sender'] ==
                                    '${widget.myData['_id']}'
                                ? Alignment.centerLeft
                                : Alignment.centerRight,
                            child: Text(
                              controller.messages[index]['message'],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(6),
                  child: TextFormField(
                    controller: _message,
                    decoration: InputDecoration(
                      hintText: 'write a message...',
                      border: OutlineInputBorder(),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          if (_message.text.isNotEmpty) {
                            controller.sendMessage(
                              _message.text,
                              widget.myData['_id'],
                              widget.userData['_id'],
                              uniqueId,
                            );
                          }
                          _message.clear();
                        },
                        child: Transform.rotate(
                          angle: -math.pi / 4,
                          child: Icon(Icons.send),
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.text,
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
