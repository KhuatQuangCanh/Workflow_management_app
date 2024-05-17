import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../controllers/personal_tasks_controller.dart';

class CSelectedColor extends StatelessWidget {
  const CSelectedColor({
    super.key,

  });



  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PersonalTasksController());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Color: ',style: Theme.of(context).textTheme.titleMedium,),
        SizedBox(height: CSizes.spaceBtwItems/4,),
        Wrap(
          children: List<Widget>.generate(3, (index) {
            return GestureDetector(
              onTap: () {
                controller.selectedColor.value = index;
              },
              child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Obx(() => CircleAvatar(
                    radius: 14,
                    backgroundColor: index==0?Colors.green.withOpacity(0.8) : index == 1? Colors.orangeAccent.withOpacity(0.8) :  Colors.red.withOpacity(0.8),
                    child: controller.selectedColor.value == index?Icon(Icons.done, color: CColors.white, size: 16,):Container(),
                  ),)
              ),
            );
          }),
        )
      ],
    );
  }
}
