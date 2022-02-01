import 'package:colco_poc/core/utils/constants.dart';
import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  final double maxRadius;
  const UserAvatar({this.maxRadius = 29, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      maxRadius: maxRadius,
      backgroundColor: AppColors.kPrimary,
      child: const Text('SA'),
    );
  }
}
