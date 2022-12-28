import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_app/screens/view_task.dart';
import 'package:task_management_app/services/service.dart';
import 'package:task_management_app/utils/app_colors.dart';
import 'package:task_management_app/widgets/button_widget.dart';
import 'package:task_management_app/widgets/textfield_widget.dart';

class AddTask extends StatefulWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  Future<void> postData(String task, String taskDetail) async {
    await ApiService().postData({"task_name": task, "task_detail": taskDetail});
    // Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController detailController = TextEditingController();

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

    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        padding: const EdgeInsets.only(left: 20, right: 20),
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover, image: AssetImage("assets/addtask.jpg"))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 60,
                ),
                IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: AppColors.secondaryColor,
                    ))
              ],
            ),
            Column(
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
                      postData(nameController.text.trim(),
                          detailController.text.trim());

                      Get.to(() => const ViewTasks());
                    }
                  },
                  child: const ButtonWidget(
                      backgroundColor: AppColors.mainColor,
                      text: "Add",
                      textColor: Colors.white),
                )
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 20,
            ),
          ],
        ),
      ),
    );
  }
}
