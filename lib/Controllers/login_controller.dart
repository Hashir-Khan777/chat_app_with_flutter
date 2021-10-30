import 'package:chatappflutter/Views/Home.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

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

  void signInWithGoogle() async {
    loading.value = true;
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      await firestore.collection('Users').doc(userCredential.user?.uid).set({
        '_id': userCredential.user?.uid,
        'email': userCredential.user?.email,
        'name': userCredential.user?.displayName,
      });
      firestore
          .collection('Users')
          .doc(userCredential.user?.uid)
          .get()
          .then((value) {
        loading.value = false;
        Get.to(Home(
          user: value.data(),
        ));
      });
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

  void signInWithFacebook() async {
    loading.value = true;
    try {
      // Trigger the sign-in flow
      final LoginResult loginResult = await FacebookAuth.instance.login();

      // Create a credential from the access token
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      // Once signed in, return the UserCredential
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(facebookAuthCredential);
      await firestore.collection('Users').doc(userCredential.user?.uid).set({
        '_id': userCredential.user?.uid,
        'email': userCredential.user?.email,
        'name': userCredential.user?.displayName,
      });
      firestore
          .collection('Users')
          .doc(userCredential.user?.uid)
          .get()
          .then((value) {
        loading.value = false;
        Get.to(Home(
          user: value.data(),
        ));
      });
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
