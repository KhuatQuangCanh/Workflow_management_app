import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:workflow_management_app/utils/constants/colors.dart';

import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/helpers/helper_functions.dart';
import '../../../../controllers/group/group_controller.dart';
import '../../../../models/group_model.dart';

class GroupTaskTitle extends StatelessWidget {
  final GroupModel? group;
  const GroupTaskTitle({this.group});

  @override
  Widget build(BuildContext context) {
    final dark = CHelperFunctions.isDarkMode(context);
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15, bottom: 12, top: 8),
      width: 340,
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: dark ? CColors.darkerGrey : CColors.softGrey,
      ),
      child: Row(children: [
        Expanded(
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                group?.title ?? '',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Text(
                group?.description ?? '',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(
                height: CSizes.spaceBtwItems / 2,
              ),
              Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    color: dark ? CColors.softGrey : CColors.darkerGrey,
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    group?.location ?? '',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
              const SizedBox(
                height: CSizes.spaceBtwItems / 2,
              ),
              Row(
                children: [
                  Icon(
                    Icons.access_time_rounded,
                    color: dark ? CColors.softGrey : CColors.darkerGrey,
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    'Start Time: ${DateFormat("dd/MM/yyyy - HH:mm").format(group!.startTime)}',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 28),
                child: Text(
                  'End Time: ${DateFormat("dd/MM/yyyy - HH:mm").format(group!.endTime)}',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              const SizedBox(
                height: CSizes.spaceBtwItems / 2,
              ),

            ],
          ),
        ),
      ]),
    );
  }
}
