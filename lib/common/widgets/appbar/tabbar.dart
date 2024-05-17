import 'package:flutter/material.dart';
import 'package:workflow_management_app/utils/constants/colors.dart';
import 'package:workflow_management_app/utils/device/device_utility.dart';

import '../../../utils/helpers/helper_functions.dart';


class CTabbar extends StatelessWidget implements PreferredSizeWidget {
  const CTabbar({super.key, required this.tabs});

  final List<Widget> tabs;

  @override
  Widget build(BuildContext context) {
    final dark = CHelperFunctions.isDarkMode(context);
    return Material(
      color: dark ? CColors.black : CColors.white,
      child: TabBar(
        tabAlignment: TabAlignment.start,
        tabs: tabs,
        isScrollable: true,
        indicatorColor: CColors.primary,
        labelColor: dark ? CColors.white : CColors.primary,
        unselectedLabelColor: CColors.darkGrey,

      ),
    );
  }


  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(CDeviceUtils.getAppBarHeight());
}