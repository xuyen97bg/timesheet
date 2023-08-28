import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesheet/helper/route_helper.dart';
import 'package:timesheet/utils/color_resources.dart';
import 'package:timesheet/utils/styles.dart';

import '../../../controller/auth_controller.dart';

class UserFragment extends StatelessWidget{
  const UserFragment({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.only(bottom: 30),
      child: ElevatedButton(onPressed: (){
        Get.find<AuthController>().repo.clearUserToken();
        Get.offNamed(RouteHelper.signIn);
      }, child: const Text('Đăng xuất', style: font14WhiteW600)
      )
    );
  }

}