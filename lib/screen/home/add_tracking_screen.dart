import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesheet/controller/home_controller.dart';
import 'package:timesheet/utils/color_resources.dart';
import 'package:timesheet/utils/styles.dart';

import '../../helper/date_converter.dart';
import 'fragment/tab/tracking_tab.dart';

class AddTrackingScreen extends StatelessWidget {
  const AddTrackingScreen({Key? key}) : super(key: key);
  List<TrackingTab> createTabView({required int numTab}){
    List<TrackingTab> trackingTabs = [];
    for(int i=0; i<numTab; i++ ){
      trackingTabs.add(TrackingTab(index: i));
    }
    return trackingTabs;
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        builder: (controller){
          return Scaffold(
            appBar: AppBar(
                leading: IconButton(
                    icon: const Icon(Icons.arrow_back), onPressed: (){
                  Get.back();
                  controller.getTrackings();
                }),
              title: Text(DateConverter.dateToDate(controller.tracking.dateWorking!),style: font18WhiteW600),
              centerTitle: true,
              actions: [
                TextButton(onPressed: (){
                  controller.saveTracking().then( (isOK) {
                    if(isOK){
                      Get.back();
                      controller.getTrackings();
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Lưu thành công')));
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Có lỗi xảy ra')));
                    }
                  });
                }, child: const Text('Lưu',style: font16WhiteW600))
              ],
            ),
            backgroundColor: Colors.white,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Switch(
                        value: controller.tracking.dayOff??false,
                        onChanged: (value) {
                          controller.tracking.dayOff = value;
                          controller.update();
                        },
                      ), const Text('Nghỉ phép',style: font14BlackW600)
                    ],
                ),
                Expanded(
                    child: Visibility(
                      visible: !(controller.tracking.dayOff??false),
                        child: DefaultTabController(
                        length: controller.tracking.tasks?.length??0,
                        child: Column(
                            children: [
                              Container(
                                  color: Colors.white,
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: TabBar(
                                              controller: controller.tabController,
                                              labelColor: Colors.black,
                                              indicatorColor: ColorResources.COLOR_PRIMARY,
                                              tabs: controller.tracking.tasks?.asMap().entries.map((e) =>
                                                  Tab(text: '${controller.tracking.tasks!.length<5?'Dự án':controller.tracking.tasks!.length==5?'DA':''} ${e.key + 1}')).toList()??[]
                                          )
                                      ),
                                      Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10),
                                          child: IconButton(
                                              icon: const Icon(Icons.add), onPressed: controller.addTask)
                                      )
                                    ],
                                  )),
                              Expanded(
                                child: TabBarView(
                                    controller:  controller.tabController,
                                    children: controller.listTaskController.asMap().entries.map((e) => TrackingTab(index: e.key)).toList()
                                ),
                              )
                            ]
                        )
                    )))
              ],
            )
          );
        }
    );
  }
}