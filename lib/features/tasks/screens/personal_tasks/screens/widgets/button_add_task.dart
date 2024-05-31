import 'package:flutter/material.dart';
import 'package:workflow_management_app/utils/constants/colors.dart';

class CButtonAddTask extends StatelessWidget {
  const CButtonAddTask(
      {super.key,
      required this.label,
      required this.onTap,
      this.color ,
      });

  final String label;
  final Function()? onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 130,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: color,
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(color: CColors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
