import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesheet/controller/home_controller.dart';
import 'package:timesheet/utils/color_resources.dart';
import 'package:timesheet/view/item_tracking.dart';

import '../../../data/model/body/tracking.dart';
import '../../../utils/styles.dart';

class TrackingFragment extends StatelessWidget {
  const TrackingFragment({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var numRows = [7,10,14,21,31];
    Get.find<HomeController>().getProjects();
    Get.find<HomeController>().getTrackings();
    return GetBuilder<HomeController>(builder: (controller){
      return Center(
        child: Container(
          color: const Color(0x09000000),
            child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  IconButton(
                    onPressed: controller.onPreMonth,
                    icon: const Icon(Icons.arrow_back_ios,size: 20,color: Colors.black38),
                  ),
                  SizedBox(width: 80,child: Center(child: Text("T${controller.month}/${controller.year}" , style: font16PrimaryW600))),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward_ios,size: 20,color: Colors.black38),
                    onPressed: controller.onNextMonth,
                  )
                ]),
            Expanded(child: ListView.separated(
                padding: const EdgeInsets.only(left: 20,right: 20),
                itemCount: controller.trackingResponse.data?.tracks?.length??0,
                itemBuilder: (BuildContext context, int index) {
                  Tracking tracking = controller.trackingResponse.data!.tracks![index];
                  return ItemTracking(tracking: tracking, controller: controller);
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: 10,);
                }
            )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
              children: [
                const Text('Số hàng', style: font14BlackW400,),
                const SizedBox(width: 10),
                SizedBox(
                  width: 100,
                  height: 32,
                  child: PopupMenuButton(
                      itemBuilder: (BuildContext context) {
                        return numRows.map((e) => PopupMenuItem(value: e, child: Text(e==31?'Tất cả':'$e'))).toList();
                      },
                    onSelected: controller.handleChoosePageSize,
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8)
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(child: Text('${controller.pageSize>20?'Tất cả':controller.pageSize}',style: font14BlackW400)),
                              const Icon(Icons.arrow_drop_down),
                            ],
                          )
                      )
                  ),
                ),
                Expanded(child: Wrap(
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    IconButton(
                        onPressed: controller.onPreIndex,
                        icon: const Icon(Icons.arrow_back_ios,size: 16,color: Colors.black45)
                    ),
                    Text("${controller.pageIndex}/${controller.totalPages}" , style: font14SecondaryW600),
                    IconButton(
                      icon: const Icon(Icons.arrow_forward_ios,size: 16,color: Colors.black45,),
                      onPressed: controller.onNextIndex,
                    )
                  ],
                )),
              ],
            ),),
            const SizedBox(height: 10)
          ],
        ))
      );
    });
  }
}

