import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesheet/screen/home/fragment/tracking_fragment.dart';
import 'package:timesheet/utils/color_resources.dart';

import '../../controller/auth_controller.dart';
import '../../utils/images.dart';
import '../../utils/styles.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePage();

}

class _HomePage extends State<HomePage> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  static final List<Widget> _widgetOptions = <Widget>[
    const TrackingFragment(),
    const Text('Index 1: Business', style: font15W600)
  ];
  AuthController controller = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Trang chủ")),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child:Column(
          mainAxisSize: MainAxisSize.max,
          children: [
           Expanded(child:  ListView(
             padding: const EdgeInsets.only(left: 20,right: 20),
             children: [
               Container(
                 padding: const EdgeInsets.fromLTRB(0, 50, 0, 24),
                 child: const Row(
                   children: [
                     CircleAvatar(
                       radius: 24,
                       backgroundImage:  AssetImage(Images.avatar2),
                       backgroundColor: Color(0xFFFFCB66),
                     ),
                     SizedBox(width: 12),
                     Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text("user", style: font15W600),
                         Text("emailemail@gmail.com", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, fontFamily:'Inter' ))
                       ],
                     )
                   ],
                 ),
               ),
               ListTile(
                 selected: _selectedIndex == 0,
                 textColor:  const Color(0xFF535763),
                 iconColor: const Color(0xFF535763),
                 selectedColor: ColorResources.whiteColor,
                 selectedTileColor: ColorResources.COLOR_PRIMARY,
                 visualDensity: const VisualDensity(vertical: -2),
                 title: const Text('Checking', style: font15W600),
                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                 leading: const Icon(Icons.work) ,
                 onTap: () {
                   // Update the state of the app.
                   _onItemTapped(0);
                   Navigator.pop(context);
                 },
               ),
               const SizedBox(height: 10),
               ListTile(
                 selected: _selectedIndex == 1,
                 textColor:   const Color(0xFF535763),
                 iconColor: const Color(0xFF535763),
                 leadingAndTrailingTextStyle: const TextStyle(color: Color(0xFF535763)),
                 selectedColor: ColorResources.whiteColor,
                 selectedTileColor: ColorResources.COLOR_PRIMARY,
                 visualDensity: const VisualDensity(vertical: -2),
                 title: const Text('User', style: font15W600),
                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                 leading: const Icon(Icons.person) ,
                 onTap: () {
                   // Update the state of the app.
                   _onItemTapped(1);
                   Navigator.pop(context);
                 },
               )
             ],
           )),
            Container(
              padding: const EdgeInsets.only(left: 20,right: 20),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: ListTile(
                  selected: _selectedIndex == 2,
                  iconColor: const Color(0xFF535763),
                  textColor:   const Color(0xFF535763),
                  leadingAndTrailingTextStyle: const TextStyle(color: Color(0xFF535763)),
                  selectedColor: ColorResources.whiteColor,
                  selectedTileColor: ColorResources.COLOR_PRIMARY,
                  title: const Text('Đăng xuất', style: font15W600),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  leading: const Icon(Icons.logout_sharp) ,
                  onTap: () {
                    // Update the state of the app.
                    Navigator.pop(context);
                  },
                ),
              ),
            )
          ],
        )
      ),
      body:  Center(
        child: _widgetOptions[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.work),
            label: 'Checking',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'User',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: ColorResources.COLOR_PRIMARY,
        onTap: _onItemTapped,
      ),
    );
  }
}


