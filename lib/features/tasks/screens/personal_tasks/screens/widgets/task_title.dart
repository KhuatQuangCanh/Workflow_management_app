import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workflow_management_app/features/tasks/screens/personal_tasks/models/personal_task.dart';
import 'package:workflow_management_app/utils/constants/image_strings.dart';
import 'package:workflow_management_app/utils/constants/sizes.dart';

class TaskTile extends StatelessWidget {
  final PersonalTask? task;
  TaskTile(this.task);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
      EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(bottom: 12),
      child: Container(
        padding: EdgeInsets.only(left: 15, right: 15, bottom: 12, top: 8),
        //  width: SizeConfig.screenWidth * 0.78,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: task!.isCompleted == 1 ? Colors.green.withOpacity(0.8) : _getBGClr(task?.color??0),
        ),
        child: Row(children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      task?.title??"",
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    task!.isCompleted == 1 ?Image(
                      height: 25,
                        width: 25,
                        image: AssetImage(CImages.checkIcon)) : Container()
                  ],
                ),


                SizedBox(
                  height: CSizes.spaceBtwItems/2,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.access_time_rounded,
                      color: Colors.grey[200],
                      size: 18,
                    ),
                    SizedBox(width: 4),
                    Text(
                      "${task!.startTime} - ${task!.endTime}",
                      style: GoogleFonts.lato(
                        textStyle:
                        TextStyle(fontSize: 13, color: Colors.grey[100]),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: CSizes.spaceBtwItems/2),
                Text(
                  task?.note??"",
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(fontSize: 15, color: Colors.grey[100]),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            height: 70,
            width: 0.5,
            color: Colors.grey[200]!.withOpacity(0.7),
          ),

          RotatedBox(
            quarterTurns: 3,
            child: Text(
              task!.isCompleted == 1 ? "DONE" : "TODO",
              style: GoogleFonts.lato(
                textStyle: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  _getBGClr(int no) {
    switch (no) {
      case 0:
        return Colors.green.withOpacity(0.8);
      case 1:
        return Colors.orangeAccent.withOpacity(0.8);
      case 2:
        return Colors.red.withOpacity(0.8);
      default:
        return Colors.green.withOpacity(0.8);
    }
  }
}