import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:workflow_management_app/common/widgets/appbar/appbar.dart';
import 'package:workflow_management_app/utils/constants/sizes.dart';
import 'package:workflow_management_app/utils/helpers/helper_functions.dart';

import '../../../utils/constants/colors.dart';

class NotifiedPage extends StatelessWidget {
  const NotifiedPage({super.key, required this.label});

  final String? label;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CHelperFunctions.isDarkMode(context)
            ? CColors.primary
            : Colors.white,
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(Iconsax.arrow_left,
                color: CHelperFunctions.isDarkMode(context)
                    ? CColors.white
                    : CColors.dark)),
        title: Text(
          this.label.toString().split("|")[0],
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(CSizes.defaultSpace),
        child: Container(
          width: 350,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
          color: CHelperFunctions.isDarkMode(context)? Colors.grey.withOpacity(0.2): Colors.grey.withOpacity(0.2)),
          child: Padding(
            padding: const EdgeInsets.all(CSizes.defaultSpace),
            child: Text(
              this.label.toString().split("|")[1],
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
        ),
      ),
    );
  }
}
