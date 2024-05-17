import 'package:flutter/material.dart';
import 'package:workflow_management_app/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:workflow_management_app/common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import 'package:workflow_management_app/utils/constants/colors.dart';

class CPrimaryHeaderContainer extends StatelessWidget {
  const CPrimaryHeaderContainer({super.key, required this.child});

  final Widget child;
  @override
  Widget build(BuildContext context) {
    return CCurvedEdgesWidget(
      child: Container(
        color: CColors.primary,
        child: Stack(
          children: [
            Positioned(
                top: -150,
                right: -200,
                child: CCircularContainer(
                  backgroundColor: CColors.textWhite.withOpacity(0.1),
                )),
            Positioned(
                top: 50,
                right: -250,
                child: CCircularContainer(
                  backgroundColor: CColors.textWhite.withOpacity(0.1),
                )),
            child,
          ],
        ),
      ),
    );
  }
}
