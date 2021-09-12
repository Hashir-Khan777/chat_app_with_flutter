import 'package:chatappflutter/Views/Home.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  var loading = false.obs;
  var error = "".obs;

  void login(email, password) async {
    loading.value = true;
    try {
      if (email == null && password == null) {
        loading.value = false;
        error.value = "Email and Password can't be empty";
      } else {
        UserCredential userCredential = await auth.signInWithEmailAndPassword(
            email: email, password: password);
        await firestore
            .collection('Users')
            .doc(userCredential.user?.uid)
            .get()
            .then((value) {
          loading.value = false;
          Get.to(Home(
            user: value.data(),
          ));
        });
      }
    } on FirebaseAuthException catch (e) {
      loading.value = false;
      error.value = '${e.message}';
    } catch (e) {
      loading.value = false;
      error.value = e.toString();
    }
    var future = Future.delayed(Duration(seconds: 4));
    future.asStream().listen((event) {
      error.value = "";
    });
  }
}
