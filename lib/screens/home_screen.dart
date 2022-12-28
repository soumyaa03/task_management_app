import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_app/screens/add_task.dart';
import 'package:task_management_app/screens/view_task.dart';
import 'package:task_management_app/utils/app_colors.dart';
import 'package:task_management_app/widgets/button_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        padding: const EdgeInsets.only(left: 20, right: 20),
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover, image: AssetImage("assets/welcome.jpg"))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
                text: const TextSpan(
                    text: "Hello",
                    style: TextStyle(
                        color: AppColors.mainColor,
                        fontSize: 60,
                        fontWeight: FontWeight.bold),
                    children: [
                  TextSpan(
                      text: " \n Moshi Moshi",
                      style: TextStyle(
                        color: AppColors.smallTextColor,
                        fontSize: 14,
                      ))
                ])),
            SizedBox(
              height: MediaQuery.of(context).size.height / 2.8,
            ),
            InkWell(
              onTap: () {
                Get.to(() => const AddTask(),
                    transition: Transition.fade,
                    duration: const Duration(seconds: 1));
              },
              child: const ButtonWidget(
                  backgroundColor: AppColors.mainColor,
                  text: "Add Task",
                  textColor: Colors.white),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                Get.to(() => const ViewTasks(),
                    transition: Transition.fade,
                    duration: const Duration(seconds: 1));
              },
              child: const ButtonWidget(
                  backgroundColor: Colors.white,
                  text: "View Tasks",
                  textColor: AppColors.mainColor),
            )
          ],
        ),
      ),
    );
  }
}
