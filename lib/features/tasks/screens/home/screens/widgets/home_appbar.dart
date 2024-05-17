import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:workflow_management_app/common/widgets/appbar/appbar.dart';

import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/text_string.dart';

class CHomeAppBar extends StatelessWidget {
  const CHomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return CAppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            CTexts.homeAppbarTitle,
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .apply(color: CColors.grey),
          ),
          Text(
            CTexts.homeAppbarSubTitle,
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .apply(color: CColors.white),
          )
        ],
      ),
      actions: [
        IconButton(onPressed: () {}, icon: Icon(Iconsax.edit, color: CColors.white,))
      ]
    );
  }
}
