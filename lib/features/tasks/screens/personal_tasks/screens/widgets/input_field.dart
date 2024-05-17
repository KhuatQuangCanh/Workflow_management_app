import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:workflow_management_app/utils/constants/colors.dart';
import 'package:workflow_management_app/utils/constants/sizes.dart';
import 'package:workflow_management_app/utils/helpers/helper_functions.dart';

import '../../../../../../utils/constants/text_string.dart';

class CInputField extends StatelessWidget {
  const CInputField({super.key, this.title = "", this.hint = "", this.controller, this.widget,});

  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleMedium,),
          SizedBox(height: CSizes.spaceBtwItems/5,),
          IntrinsicHeight(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1.0),
                borderRadius: BorderRadius.circular(12)
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      readOnly: widget ==null ? false : true,
                      autofocus: false,
                      controller: controller,
                      maxLines: null,
                      minLines: 1,
                      style: TextStyle(fontSize: 18,fontWeight: FontWeight.normal),
                      decoration: InputDecoration(
                        hintText: hint,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        hintStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.grey),
                        contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 8)
                      ),
                    ),
                  ),

                  widget ==null?Container():Container(child: widget,),
                ],

              ),
            ),
          )
        ],
      ),
    );
  }
}
