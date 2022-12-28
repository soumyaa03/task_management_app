import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_app/models/task_model.dart';
import 'package:task_management_app/screens/add_task.dart';
import 'package:task_management_app/screens/home_screen.dart';
import 'package:task_management_app/services/service.dart';
import 'package:task_management_app/utils/app_colors.dart';
import 'package:task_management_app/widgets/edit_widget.dart';
import 'package:task_management_app/widgets/task_widget.dart';
import 'package:task_management_app/widgets/view_widget.dart';

class ViewTasks extends StatefulWidget {
  const ViewTasks({Key? key}) : super(key: key);

  @override
  State<ViewTasks> createState() => _ViewTasksState();
}

class _ViewTasksState extends State<ViewTasks> {
  late List<TaskModel>? _taskModel = [];
  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    _taskModel = (await ApiService().getTasks())!;
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    // List myData = ["Gambare", "Ore wa Kaizouku oni naru wo doko", "1:12:39"];
    final leftEditIcon = Container(
      margin: const EdgeInsets.only(bottom: 10),
      color: Colors.green,
      alignment: Alignment.centerLeft,
      child: const Icon(
        Icons.edit,
        color: Colors.white,
      ),
    );
    final rightEditIcon = Container(
      margin: const EdgeInsets.only(bottom: 10),
      color: Colors.red,
      alignment: Alignment.centerRight,
      child: const Icon(
        Icons.delete,
        color: Colors.white,
      ),
    );
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
          children: [
            Container(
              padding: const EdgeInsets.only(top: 50),
              alignment: Alignment.topLeft,
              width: double.maxFinite,
              height: MediaQuery.of(context).size.height / 3.6,
              child: InkWell(
                onTap: (() => {
                      Get.back()
                      // Get.to(const HomeScreen(),
                      //     transition: Transition.rightToLeft,
                      //     duration: const Duration(seconds: 1))
                    }),
                child: const Icon(
                  Icons.arrow_back,
                  color: AppColors.secondaryColor,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                  left: 0.0), //just to remove unnecessary container message
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Get.to(() => const HomeScreen(),
                          transition: Transition.fade,
                          duration: const Duration(seconds: 1));
                    },
                    child: const Icon(
                      Icons.home,
                      color: AppColors.secondaryColor,
                      size: 30,
                    ),
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  InkWell(
                    onTap: (() {
                      Get.to(() => const AddTask(),
                          transition: Transition.fade,
                          duration: const Duration(seconds: 1));
                    }),
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.black),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                  Expanded(child: Container()),
                  const Icon(
                    Icons.calendar_month_sharp,
                    color: AppColors.secondaryColor,
                    size: 30,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const Text(
                    "2",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Flexible(
              child: _taskModel == null || _taskModel!.isEmpty
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      itemCount: _taskModel!.length,
                      itemBuilder: (context, index) {
                        return Dismissible(
                          key: ObjectKey(index),
                          background: leftEditIcon,
                          secondaryBackground: rightEditIcon,
                          onDismissed: (DismissDirection direction) {},
                          confirmDismiss: (DismissDirection direction) async {
                            if (direction == DismissDirection.startToEnd) {
                              showModalBottomSheet(
                                backgroundColor: Colors.transparent,
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
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          ViewWidget(
                                            taskDetail:
                                                _taskModel![index].taskDetail,
                                            taskName:
                                                _taskModel![index].taskName,
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          EditWidget(
                                            taskId: _taskModel![index].id,
                                            taskDetail:
                                                _taskModel![index].taskDetail,
                                            taskName:
                                                _taskModel![index].taskName,
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                              return false;
                            } else {
                              ApiService().deleteData(
                                  '/delete/${_taskModel![index].id}');
                              return Future.delayed(
                                  const Duration(seconds: 1), () => true);
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            child: TaskWidget(
                                text: _taskModel![index].taskName,
                                color: Colors.blueGrey),
                          ),
                        );
                      }),
            )
          ],
        ),
      ),
    );
  }
}
