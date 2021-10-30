import 'package:chatappflutter/Controllers/login_controller.dart';
import 'package:chatappflutter/Views/Register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:get/get.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final loginController = Get.put(LoginController());
  var email;
  var password;
  var obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Chat App',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
          ),
        ),
      ),
      body: GetX<LoginController>(
        builder: (controller) {
          if (controller.loading.isTrue) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 30),
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            if (controller.error.isNotEmpty)
                              Container(
                                width: MediaQuery.of(context).size.width - 40,
                                margin: EdgeInsets.only(bottom: 30),
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Color(0xffffe0e0),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  '${controller.error}',
                                  style: TextStyle(
                                    color: Color(0xffa02020),
                                  ),
                                ),
                              ),
                            Container(
                              width: MediaQuery.of(context).size.width - 40,
                              child: TextFormField(
                                decoration: InputDecoration(
                                    hintText: 'email',
                                    border: OutlineInputBorder(),
                                    prefixIcon: Icon(Icons.email)),
                                keyboardType: TextInputType.emailAddress,
                                initialValue: email,
                                onChanged: (text) {
                                  setState(() {
                                    email = text;
                                  });
                                },
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width - 40,
                              margin: EdgeInsets.only(top: 10, bottom: 10),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'password',
                                  border: OutlineInputBorder(),
                                  prefixIcon: Icon(Icons.lock),
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        obscureText = !obscureText;
                                      });
                                    },
                                    child: Icon(obscureText
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                  ),
                                ),
                                keyboardType: TextInputType.text,
                                obscureText: obscureText,
                                initialValue: password,
                                onChanged: (text) {
                                  setState(() {
                                    password = text;
                                  });
                                },
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                controller.login(email, password);
                              },
                              child: Text('Login'),
                            ),
                          ],
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width - 40,
                          child: Row(
                            children: [
                              Text('Do not have an account ?'),
                              TextButton(
                                onPressed: () {
                                  Get.to(Register());
                                },
                                child: Text('Create account'),
                              ),
                            ],
                          ),
                        ),
                        Text('OR'),
                        SignInButton(
                          Buttons.Google,
                          onPressed: () {
                            controller.signInWithGoogle();
                          },
                        ),
                        SignInButton(
                          Buttons.Facebook,
                          onPressed: () {
                            controller.signInWithFacebook();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
