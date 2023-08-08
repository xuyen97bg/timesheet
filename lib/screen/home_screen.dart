
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/auth_controller.dart';
import '../data/model/body/user.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {
  AuthController controller = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    BoxDecoration myBoxDecoration() {
      return BoxDecoration(
        border: Border.all(width: 1,color: Colors.black38),
        borderRadius: BorderRadius.circular(10)
      );
    }
    return Scaffold(
      body: Column(children: [
        // ElevatedButton(onPressed: controller.getAllUser, child: Text('Get all user')),
        // ElevatedButton(onPressed: controller.getUserCurrent, child: Text('Get user curent')),
        Obx(() =>
            Expanded(child: ListView.separated(
                itemCount: controller.users.value.length,
                itemBuilder: (context, index) {
                  User user = controller.users.value[index];
                  return ListTile(
                    title: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: myBoxDecoration(),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Expanded(
                                  flex: 1,
                                  child: Text('Username:',style: TextStyle(height: 2, fontWeight: FontWeight.bold)),
                              ),
                              Expanded(
                                  flex: 2,
                                  child: Text('${user.username}', textAlign: TextAlign.end, style: TextStyle(height: 2)),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              const Expanded(
                                flex: 1,
                                child: Text('Display name:',style: TextStyle(height: 2,fontWeight: FontWeight.bold)),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text('', textAlign: TextAlign.end , style: TextStyle(height: 2)),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              const Expanded(
                                flex: 1,
                                child: Text('Email:',style: TextStyle(height: 2,fontWeight: FontWeight.bold)),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text('${user.email}', textAlign: TextAlign.end , style: TextStyle(height: 2)),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              const Expanded(
                                flex: 1,
                                child: Text('Role:',style: TextStyle(height: 2,fontWeight: FontWeight.bold)),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text('', textAlign: TextAlign.end , style: TextStyle(height: 2)),
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  );
                }, separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: 10,);
            },)
            )
        )
      ],),
    );
  }
}
