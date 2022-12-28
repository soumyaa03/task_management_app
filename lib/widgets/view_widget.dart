import 'package:flutter/material.dart';
import 'package:task_management_app/utils/app_colors.dart';
import 'package:task_management_app/widgets/button_widget.dart';

class ViewWidget extends StatelessWidget {
  final String taskName;
  final String taskDetail;
  const ViewWidget(
      {super.key, required this.taskName, required this.taskDetail});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
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
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Container(
                        width: double.maxFinite,
                        height: MediaQuery.of(context).size.height / 14,
                        decoration: BoxDecoration(
                          color: AppColors.mainColor,
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Center(
                          child: Text(
                            taskName,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Container(
                      width: double.maxFinite,
                      height: MediaQuery.of(context).size.height / 14,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Center(
                        child: Text(
                          taskDetail,
                          style: const TextStyle(
                              color: AppColors.smallTextColor, fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      child: const ButtonWidget(
          backgroundColor: AppColors.mainColor,
          text: "View",
          textColor: Colors.white),
    );
  }
}
