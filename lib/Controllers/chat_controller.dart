import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var messages = [].obs;

  void fetchMessages(uniqueId) {
    firestore.collection('Chats/$uniqueId/messages').get().then((value) {
      messages.value = value.docs.map((e) => e.data()).toList();
    });
  }

  void sendMessage(message, myId, userId, uniqueId) {
    var docId = firestore.collection('Chats').doc().id;
    messages.add({
      '_id': docId,
      'sender': myId,
      'receiver': userId,
      'message': message,
    });
    firestore.collection('Chats/$uniqueId/messages').doc(docId).set({
      '_id': docId,
      'sender': myId,
      'receiver': userId,
      'message': message,
    });
  }
}
