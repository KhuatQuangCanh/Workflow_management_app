import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../images/circular_images.dart';

class TUserProfileTitle extends StatelessWidget {
  const TUserProfileTitle({
    super.key, required this.onPressed,
  });
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CCircularImage(
        image: CImages.user,
        width: 50,
        height: 50,
        padding: 0,
      ),
      title: Text('Khuat Quang Canh' ,style: Theme.of(context).textTheme.headlineSmall!.apply(color: CColors.white),),
      subtitle: Text('kqc07062002@gmail.com' ,style: Theme.of(context).textTheme.bodyMedium!.apply(color: CColors.white),),
      trailing:  IconButton(onPressed: onPressed, icon: const Icon(Iconsax.edit, color: CColors.white,)),
    );
  }
}