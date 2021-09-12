import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  var users = [].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchUsers();
  }

  void fetchUsers() async {
    await firestore.collection('Users').get().then((value) {
      var data = [];
      value.docs.forEach((element) {
        data.add(element.data());
      });
      users.value = data;
    });
  }
}
