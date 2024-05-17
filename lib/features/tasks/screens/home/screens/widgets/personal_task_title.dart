import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../utils/constants/image_strings.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../personal_tasks/models/task.dart';


class PersonalTaskTitle extends StatelessWidget {
  final PersonalTask? task;
  PersonalTaskTitle(this.task);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: CSizes.sm),
      child: Row(
          children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // -- Title
              Text(
                task?.title??"",
                style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),

              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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

                  Row(
                    children: [
                      TextButton(onPressed: () {}, child: Text("View")),
                      SizedBox(width: 4),
                      Icon(
                        Iconsax.eye,
                        color: Colors.grey[200],
                        size: 18,
                      ),
                    ],
                  )

                ],
              ),
            ],
          ),
        ),

        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          height: 70,
          width: 1,
          color: _getBGClr(task?.color??0),
        ),

      ]),
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