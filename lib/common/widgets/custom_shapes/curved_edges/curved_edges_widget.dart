import 'package:flutter/material.dart';
import 'package:workflow_management_app/common/widgets/custom_shapes/curved_edges/curved_edges.dart';

class CCurvedEdgesWidget extends StatelessWidget {
  const CCurvedEdgesWidget({super.key, this.child});

  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CCustomCurvedEdges(),
      child: child,
    );
  }
}
