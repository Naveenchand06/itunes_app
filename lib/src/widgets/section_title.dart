import 'package:flutter/material.dart';
import 'package:itunes_app/src/constants/app_colors.dart';
import 'package:itunes_app/src/extensions/string_extensions.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.tagField,
      width: double.maxFinite,
      padding: const EdgeInsets.symmetric(
        horizontal: 14.0,
        vertical: 12.0,
      ),
      margin: const EdgeInsets.symmetric(
        vertical: 4.0,
      ),
      child: Text(
        title.toMediaUITypeStr(),
      ),
    );
  }
}
