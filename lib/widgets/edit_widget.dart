import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_app/screens/view_task.dart';
import 'package:task_management_app/services/service.dart';
import 'package:task_management_app/utils/app_colors.dart';
import 'package:task_management_app/widgets/button_widget.dart';
import 'package:task_management_app/widgets/textfield_widget.dart';

class EditWidget extends StatefulWidget {
  final String taskId;
  final String taskName;
  final String taskDetail;
  const EditWidget(
      {super.key,
      required this.taskName,
      required this.taskDetail,
      required this.taskId});

  @override
  State<EditWidget> createState() => _EditWidgetState();
}

class _EditWidgetState extends State<EditWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController detailController = TextEditingController();
  Future<void> editData(String id, String task, String taskDetail) async {
    await ApiService().updateData(
      {"id": id, "task_name": task, "task_detail": taskDetail},
      '/update/$id',
    );
  }

  @override
  Widget build(BuildContext context) {
    bool dataValidation() {
      if (nameController.text.trim() == '') {
        Get.snackbar('Task name', 'Task name is empty');
        return false;
      } else if (detailController.text.trim() == '') {
        Get.snackbar('Task detail', 'Task detail is empty');
        return false;
      }

      return true;
    }

    return GestureDetector(
      onTap: (() {
        showModalBottomSheet(
          backgroundColor: Colors.grey,
          barrierColor: Colors.transparent,
          context: context,
          builder: (_) {
            return Container(
              decoration: BoxDecoration(
                  color: Colors.blueGrey.withOpacity(0.4),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              height: 500,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  children: [
                    TextFieldWidget(
                      textController: nameController,
                      hintText: "Task Name",
                    ),
                    const SizedBox(height: 20),
                    TextFieldWidget(
                      textController: detailController,
                      hintText: "Task Details",
                      borderRadius: 20,
                      maxLines: 3,
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        if (dataValidation()) {
                          editData(
                            widget.taskId,
                            nameController.text.trim(),
                            detailController.text.trim(),
                          );
                          Future.delayed(const Duration(seconds: 1))
                              .then((value) => setState(() {}));
                          Get.off(() => const ViewTasks(),
                              preventDuplicates: false);
                        }
                      },
                      child: const ButtonWidget(
                          backgroundColor: AppColors.mainColor,
                          text: "Update",
                          textColor: Colors.white),
                    )
                  ],
                ),
              ),
            );
          },
        );
      }),
      child: const ButtonWidget(
          backgroundColor: AppColors.mainColor,
          text: "Edit",
          textColor: Colors.white),
    );
  }
}
