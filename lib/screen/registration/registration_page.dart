import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:timesheet/data/model/body/user.dart';

import '../../controller/auth_controller.dart';
import '../../helper/route_helper.dart';
import '../../view/password_field.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  var username = TextEditingController();
  var password = TextEditingController();
  var rePassword = TextEditingController();
  var firstname = TextEditingController();
  var lastname = TextEditingController();
  var year = TextEditingController();
  var birthPlace = TextEditingController();
  var dob = TextEditingController();
  var gender = RxString('');
  var university = TextEditingController();
  var email = TextEditingController();
  Map<String, String> listGender = <String, String>{'0': 'Female', '1': 'Male'};
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1920, 1),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dob.text = DateFormat('dd-MM-yyyy').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Create Account',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 24,
          ),
          onPressed: () => Get.offNamed(RouteHelper.signIn),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.only(right: 10, left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                                padding: EdgeInsets.only(top: 12, bottom: 6),
                                child: Text('Lastname',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400))),
                            EditTextField(controller: lastname)
                          ],
                        )),
                    const SizedBox(width: 10),
                    Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                                padding: EdgeInsets.only(top: 12, bottom: 6),
                                child: Text('Firstname',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400))),
                            EditTextField(controller: firstname)
                          ],
                        ))
                  ],
                ),
                const Padding(
                    padding: EdgeInsets.only(top: 12, bottom: 6),
                    child: Text('Username',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w400))),
                EditTextField(
                  icon: Icon(Icons.person_outline, size: 24),
                  controller: username,
                ),
                const Padding(
                    padding: EdgeInsets.only(top: 12, bottom: 6),
                    child: Text('Password',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w400))),
                PasswordField(
                  controller: password,
                ),
                const Padding(
                    padding: EdgeInsets.only(top: 12, bottom: 6),
                    child: Text('Re-password',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w400))),
                PasswordField(
                  controller: rePassword,
                ),
                const Padding(
                    padding: EdgeInsets.only(top: 12, bottom: 6),
                    child: Text('Gender',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w400))),
                Obx(() => DropdownButtonFormField<String>(
                      focusColor: Colors.white,
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.only(left: 10, right: 10),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Colors.black45,
                                width: 1,
                                style: BorderStyle.solid)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Colors.green,
                                width: 1,
                                style: BorderStyle.solid)),
                      ),
                      value: gender.value == '' ? null : gender.value,
                      hint: const Text("Select Gender"),
                      items: listGender
                          .map((key, value) {
                            return MapEntry(
                                key,
                                DropdownMenuItem<String>(
                                    value: key, child: Text(value)));
                          })
                          .values
                          .toList(),
                      onChanged: (String? value) {
                        if (value != null) {
                          gender.value = value;
                        }
                      },
                    )),
                const Padding(
                    padding: EdgeInsets.only(top: 12, bottom: 6),
                    child: Text('University/College',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w400))),
                EditTextField(
                  icon: const Icon(Icons.school_outlined, size: 24),
                  controller: university,
                ),
                const Padding(
                    padding: EdgeInsets.only(top: 12, bottom: 6),
                    child: Text('How many years are you in university/college?',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w400))),
                EditTextField(
                  icon: const Icon(Icons.school_outlined, size: 24),
                  controller: year,
                ),
                const Padding(
                    padding: EdgeInsets.only(top: 12, bottom: 6),
                    child: Text('BirthPlace',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w400))),
                EditTextField(
                  icon: const Icon(Icons.place_outlined, size: 24),
                  controller: birthPlace,
                ),
                const Padding(
                    padding: EdgeInsets.only(top: 12, bottom: 6),
                    child: Text('Date of birth',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w400))),
                TextField(
                  controller: dob,
                  onTap: () {
                    _selectDate(context);
                  },
                  canRequestFocus: false,
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    //Hides label on focus or if filled
                    labelText: "Please input value",
                    filled: true,
                    // Needed for adding a fill color
                    fillColor: Colors.white,
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.black45,
                            width: 1,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.green,
                            width: 1,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    isDense: true,
                    // Reduces height a bit
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none, // No border
                      borderRadius:
                          BorderRadius.circular(10), // Apply corner radius
                    ),
                    prefixIcon: const Icon(
                      Icons.date_range_outlined,
                      size: 24,
                    ),
                  ),
                ),
                const Padding(
                    padding: EdgeInsets.only(top: 12, bottom: 6),
                    child: Text('Email',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w400))),
                EditTextField(
                  icon: const Icon(Icons.email_outlined, size: 24),
                  controller: email,
                ),
                Container(
                    height: 100,
                    alignment: Alignment.center,
                    child: SizedBox(
                        height: 48,
                        width: 180,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10)))),
                            onPressed: ()=> _registration(),
                            child: const Text(
                              'SUBMIT',
                              style: TextStyle(fontSize: 16),
                            ))))
              ],
            ),
          ))
        ],
      ),
    );
  }

  _registration(){
    String lastname = this.lastname.text;
    String firstname = this.firstname.text;
    String username = this.username.text;
    String password = this.password.text;
    String rePassword = this.rePassword.text;
    int year = int.parse(this.year.text);
    String birthPlace = this.birthPlace.text;
    DateTime dob = selectedDate;
    String gender = this.gender.value == 'Male' ? 'M' : 'F' ;
    String university = this.university.text;
    String email = this.email.text;

    if(lastname.isEmpty || firstname.isEmpty){
      const snackBar = SnackBar(
        content: Text('Bạn cần điền đầy đủ họ tên.'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }

    if (username.isEmpty || password.isEmpty) {
      const snackBar = SnackBar(
        content: Text('Bạn cần điền đầy đủ tài khoản mật khẩu.'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }

    User user = User();
    // Get.find<AuthController>().register(user).then((value) => {
    //   if (value == 200)
    //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    //         content: Text("Đăng ký thành công")))
    //   else if (value == 400)
    //     {
    //       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    //           content: Text("Tài khoản mật khẩu không chính xác")))
    //     }
    //   else
    //     {
    //       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    //           content: Text("Đã xảy ra lỗi xin vui lòng thử lại")))
    //     }
    // });
  }
}
