import 'package:chatappflutter/Controllers/home_controller.dart';
import 'package:chatappflutter/Views/Chat.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  final user;
  const Home({Key? key, this.user}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            'Chat App',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
          ),
        ),
      ),
      body: GetX<HomeController>(
        builder: (controller) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10, left: 20),
                  child: Text(
                    'My account',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                ListTile(
                  title: Text(widget.user['name']),
                  subtitle: Text(widget.user['email']),
                ),
                if (controller.users.length > 1)
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Text(
                      'Chats',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ListView.builder(
                  primary: false,
                  shrinkWrap: true,
                  itemCount: controller.users.length,
                  itemBuilder: (context, index) {
                    if (widget.user['_id'] != controller.users[index]['_id']) {
                      return GestureDetector(
                        onTap: () {
                          Get.to(Chat(
                            myData: widget.user,
                            userData: controller.users[index],
                          ));
                        },
                        child: ListTile(
                          title: Text(controller.users[index]['name']),
                          subtitle: Text(controller.users[index]['email']),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
