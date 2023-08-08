import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesheet/controller/home_controller.dart';
import 'package:timesheet/helper/route_helper.dart';
import 'package:timesheet/utils/color_resources.dart';

import '../../../data/model/body/tracking.dart';
import '../../../helper/date_converter.dart';
import '../../../utils/styles.dart';

class TrackingFragment extends StatelessWidget {
  const TrackingFragment({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Color getColorForWeekday(DateTime dateTime){
      switch(dateTime.weekday){
        case 6:
          return ColorResources.gradientColor;
        case 7:
          return Colors.redAccent;
        default:
          return ColorResources.COLOR_PRIMARY;
      }
    }
    Get.find<HomeController>().getProjects();
    Get.find<HomeController>().getTrackings();
    return GetBuilder<HomeController>(builder: (controller){
      DateTime today = DateTime.now();
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            ListTile(
              visualDensity: const VisualDensity(vertical: -2),
              contentPadding: const EdgeInsets.only(right: 70,left: 70),
              leading: IconButton(
                onPressed: controller.onPreMonth,
                icon: Icon(Icons.arrow_back_ios,size: 24),
              ),
              title: Align(
                alignment: Alignment.center,
                child: Text("T${controller.month}/${controller.year}" , style: font16PrimaryW600,),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.arrow_forward_ios,size: 24),
                onPressed: controller.onNextMonth,
              ),
            ),
            Expanded(child: ListView.separated(
                padding: const EdgeInsets.only(left: 20,right: 20),
                itemCount: controller.trackingResponse.data?.content?.length??0,
                itemBuilder: (BuildContext context, int index) {
                  Tracking tracking = controller.trackingResponse.data!.content![index];
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)),
                    title: Container(
                      padding: const EdgeInsets.only(left: 12.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: getColorForWeekday(tracking.dateWorking!),
                      ),
                      height: 50,
                      child: Container(
                        padding: const EdgeInsets.only(left: 10),
                        alignment: Alignment.centerLeft,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10.0),
                              bottomRight: Radius.circular(10.0)),
                          color: Colors.white,
                        ),
                        child: Row(
                          children: [
                            Text(DateConverter.formatDateItemTracking(tracking.dateWorking!),style: font16BlackW500),
                            Expanded(child: Container(
                                alignment: Alignment.centerLeft,
                                margin: const EdgeInsets.symmetric(horizontal: 20),
                                child: tracking.tasks?.isNotEmpty??false ?
                                const Icon(Icons.task_alt,color: ColorResources.COLOR_PRIMARY,size: 20,):null
                            )),
                            Container(
                                margin: const EdgeInsets.only(right: 20),
                                child: Visibility(
                                    visible: tracking.dateWorking?.compareTo(today)!=1,
                                    child: IconButton(
                                        icon: Icon(Icons.mode_edit_outline_outlined, color: Colors.orange[400], size: 20),
                                        onPressed: (){
                                          controller.initTaskController(mTracking: tracking);
                                          Get.toNamed( RouteHelper.addTracking); } ),
                                )
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: 0,);
                }
            )),
            ListTile(
              visualDensity: const VisualDensity(vertical: -2),
              contentPadding: EdgeInsets.only(right: 100,left: 100),
              leading: IconButton(
                onPressed: controller.onPreIndex,
                icon: Icon(Icons.arrow_back_ios,size: 24),
              ),
              title: Align(
                alignment: Alignment.center,
                child: Text("${controller.pageIndex}/4" , style: font16SecondaryW600,),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.arrow_forward_ios,size: 24),
                onPressed: controller.onNextIndex,
              ),
            )
          ],
        ),
      );
    });
  }
}

