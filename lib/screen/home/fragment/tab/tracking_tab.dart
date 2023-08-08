import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/home_controller.dart';
import '../../../../data/model/body/project.dart';
import '../../../../data/model/body/tasks.dart';
import '../../../../utils/styles.dart';

class TrackingTab extends StatelessWidget {
  final int index;
  const TrackingTab({super.key,required this.index});
  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.find<HomeController>();
    List<Project> projects = controller.projects;
    Tasks task  = controller.tracking.tasks![index];
    TextEditingController ot = controller.getOvertimeHourController(index: index);
    TextEditingController oh = controller.getOfficeHourController(index: index);
    TextEditingController taskOT = controller.getTaskOverTimeController(index: index);
    late TextEditingController taskOH = controller.getTaskOfficeController(index: index);
    return Scaffold(
      backgroundColor: const Color(0x09000000),
        body: SingleChildScrollView(
          controller: ScrollController(),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(20)),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 24,
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.zero,
                  child: IconButton(onPressed: () {
                      controller.deleteTask(index: index);
                  }, icon: const Icon(Icons.disabled_by_default_sharp,color: Colors.redAccent,),alignment: Alignment.centerRight),
                ),
                const Padding(
                    padding: EdgeInsets.only( bottom: 6),
                    child: Text("Dự án", style: font16BlackW600)),
                Container(
                    color: Colors.white,
                    height: 40,
                    child: DropdownButtonFormField<String>(
                      dropdownColor: Colors.white,
                      decoration: borderDropbox(),
                      value: task.project?.id,
                      items: projects.map((e) => DropdownMenuItem(value: e.id, child: Text(e.code ?? '--', style: font15W400))).toList(),
                      onChanged: (String? idProject) {
                        task.project = projects.firstWhere((e) => e.id == idProject);
                      },
                    )),
                Row(
                  children: [
                    layoutEditTextNumber(label: 'OH',controller:  oh),
                    const SizedBox(width: 10),
                    layoutEditTextNumber(label: 'OT', controller: ot)
                  ],
                ),
                const Padding(
                    padding: EdgeInsets.only(top: 12, bottom: 6),
                    child: Text('Task làm trong giờ', style: font16BlackW600)),
                textArea(controller: taskOH, placeholder: 'Tóm tắt ngắn gọn công việc'),
                const Padding(
                    padding: EdgeInsets.only(top: 12, bottom: 6),
                    child: Text('Task làm ngoài giờ', style: font16BlackW600)),
                textArea(controller: taskOT, placeholder: 'Tóm tắt ngắn gọn công việc'),
                SizedBox(height: 20,)
              ],
            ),
          ),
        ));
  }
}
