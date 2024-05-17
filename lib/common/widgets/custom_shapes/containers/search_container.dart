
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

import '../../../../features/tasks/controllers/home_controller.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/device/device_utility.dart';
import '../../../../utils/helpers/helper_functions.dart';


class CSearchContainer extends StatelessWidget {
  const CSearchContainer({
    super.key,
    this.icon = Iconsax.calendar_2,
    this.showBackground = true,
    this.showBorder = true,
    this.onTap,
    this.padding = const EdgeInsets.symmetric(horizontal: CSizes.defaultSpace),
  });


  final IconData? icon;
  final bool showBackground, showBorder;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final dark = CHelperFunctions.isDarkMode(context);
    final controller = Get.put(HomeController());
    return GestureDetector(
      onTap:  () => HomeController.instance.chooseDate(),
      child: Padding(
        padding: padding,
        child: Container(
          width: CDeviceUtils.getScreenWidth(context),
          padding: const EdgeInsets.all(CSizes.md),
          decoration: BoxDecoration(
            color: showBackground
                ? dark
                ? CColors.dark
                : CColors.light
                : Colors.transparent,
            borderRadius: BorderRadius.circular(CSizes.cardRadiusLg),
            border: showBorder ? Border.all(color: CColors.grey) : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    icon,
                  ),
                  const SizedBox(
                    width: CSizes.spaceBtwItems,
                  ),
                  Obx(() => Text(
                    DateFormat("dd/MM/yyyy").format(controller.selectedDate.value).toString(),
                    style: TextStyle(fontSize: 14),

                  ),)
                ],
              ),
              
              Icon(Icons.search_sharp)


            ],
          ),
        ),
      ),
    );
  }
}