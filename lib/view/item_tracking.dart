import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/home_controller.dart';
import '../data/model/body/tracking.dart';
import '../helper/date_converter.dart';
import '../helper/route_helper.dart';
import '../utils/color_resources.dart';
import '../utils/styles.dart';

class ItemTracking extends StatefulWidget {
  final Tracking tracking;
  final HomeController controller;

  const ItemTracking(
      {super.key, required this.tracking, required this.controller});

  @override
  State<ItemTracking> createState() => _ItemTrackingState();
}

class _ItemTrackingState extends State<ItemTracking> {
  bool isCollapse = false;

  Color getColorForWeekday(DateTime dateTime) {
    switch (dateTime.weekday) {
      case 6:
        return ColorResources.gradientColor;
      case 7:
        return Colors.redAccent;
      default:
        return ColorResources.COLOR_PRIMARY;
    }
  }

  @override
  Widget build(BuildContext context) {
    Tracking tracking = widget.tracking;
    HomeController controller = widget.controller;
    DateTime today = DateTime.now();
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            tracking.tasks?.isNotEmpty ?? false
                ? setState(() {
                    isCollapse = !isCollapse;
                  })
                : null;
          },
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10)),
                  color: isCollapse ? const Color(0xBBFFFFFF) : null),
              child: Container(
                  padding: const EdgeInsets.only(left: 12.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: getColorForWeekday(tracking.dateWorking!),
                      boxShadow: isCollapse?const [BoxShadow(offset: Offset(0,2),color: Color(0x09000000),blurRadius:1)]:null
                  ),
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
                        Text(
                            DateConverter.formatDateItemTracking(
                                tracking.dateWorking!),
                            style: font16BlackW500),
                        Expanded(
                            child: Container(
                                alignment: Alignment.centerLeft,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: tracking.tasks?.isNotEmpty ?? false
                                    ? const Icon(
                                        Icons.task_alt,
                                        color: ColorResources.COLOR_PRIMARY,
                                        size: 20,
                                      )
                                    :
                                const SizedBox(height: 48))
                        ),
                        Container(
                            margin: const EdgeInsets.only(right: 20),
                            child: Visibility(
                              visible:
                                  tracking.dateWorking?.compareTo(today) != 1,
                              child: IconButton(
                                  icon: Icon(Icons.mode_edit_outline_outlined,
                                      color: Colors.orange[400], size: 20),
                                  onPressed: () {
                                    controller.initTaskController(
                                        mTracking: tracking);
                                    Get.toNamed(RouteHelper.addTracking);
                                  }),
                            ))
                      ],
                    ),
                  ))),
        ),
        Visibility(
            visible: isCollapse,
            child:Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Color(0xBBFFFFFF),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10))
                ),
                child: ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    var task = tracking.tasks![index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(task.project?.code ?? '', style: font14PrimaryW600),
                        Row(
                          children: [
                            task.officeHour != 0
                                ? Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: Text('OH: ${task.officeHour}',style: font14BlackW600),
                                ))
                                : const SizedBox(),
                            task.overtimeHour != 0
                                ? Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Text('OT: ${task.overtimeHour}', style: font14BlackW600),
                                ))
                                : const SizedBox()
                          ],
                        ),
                        Row(children: [
                          task.taskOffice?.isNotEmpty == true
                              ? Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10),
                                child: Text(task.taskOffice ?? '',
                                    style: font12BlackW400),
                              ))
                              : const SizedBox(),
                          task.taskOverTime?.isNotEmpty == true
                              ? Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Text(task.taskOverTime ?? '',
                                    style: font12BlackW400),
                              ))
                              : const SizedBox()
                        ]),
                        const SizedBox(
                          height: 6,
                        )
                      ],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 0);
                  },
                  itemCount: tracking.tasks?.length ?? 0,
                  shrinkWrap: true,
                )))
      ],
    );
  }
}
