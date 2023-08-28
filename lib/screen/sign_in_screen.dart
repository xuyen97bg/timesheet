import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesheet/controller/auth_controller.dart';
import 'package:timesheet/utils/color_resources.dart';
import 'package:timesheet/utils/images.dart';

import '../helper/route_helper.dart';
import '../view/password_field.dart';
import '../view/progress_dialog.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 300,
                child: Image.asset(Images.logo , height: 150,width: 150),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: Column(
                  children: [
                    const Text(
                      "Login To Your Account",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: EditTextField(
                        icon: const Icon(Icons.person_outline, size: 24),
                        controller: _usernameController,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child:  PasswordField(
                        controller: _passwordController,
                      ),
                    ),
                    const SizedBox(height: 50),
                    ElevatedButton(
                      onPressed: () {
                        _login();
                      },
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        backgroundColor: ColorResources.COLOR_PRIMARY,
                      ),
                      child: Container(
                        width: 120,
                        padding: const EdgeInsets.all(14),
                        alignment: Alignment.center,
                        child: const Text("Login",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white),
                      ),
                    ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      child: const Text("OR",style: TextStyle(color: Colors.black, fontSize: 16)),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Get.offNamed(RouteHelper.signUp);
                      },
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        backgroundColor: ColorResources.COLOR_WHITE,
                      ),
                      child: Container(
                        width: 120,
                        padding: const EdgeInsets.all(14),
                        alignment: Alignment.center,
                        child: const Text("Registration",
                          style: TextStyle(
                              fontSize: 16,
                              color: ColorResources.COLOR_GREY),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              GetBuilder<AuthController>(
                builder: (controller) {
                  return controller.loading
                      ? const LinearProgressIndicator()
                      : Container();
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  _login() {
    String username = _usernameController.text;
    String password = _passwordController.text;
    if (username.isEmpty || password.isEmpty) {
      const snackBar = SnackBar(
        content: Text('Bạn cần điền đầy đủ tài khoản mật khẩu.'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      ProgressDialog.showLoaderDialog(context);
      Get.find<AuthController>().login(username, password).then((value) => {
            if (value == 200){
              Get.offNamed(RouteHelper.getHomeRoute())
            }
            else if (value == 400)
              {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Tài khoản mật khẩu không chính xác")))
              }
            else
              {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Đã xảy ra lỗi xin vui lòng thử lại")))
              }
          });
    }
  }
}
