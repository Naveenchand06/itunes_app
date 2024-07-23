import 'package:flutter/material.dart';
import 'package:itunes_app/src/constants/app_colors.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    this.height,
    this.width,
    required this.title,
    required this.onPress,
    this.buttonColor,
    this.titleColor,
    this.isLoading = false,
    super.key,
  });

  final double? height;
  final double? width;
  final String title;
  final VoidCallback? onPress;
  final Color? buttonColor;
  final Color? titleColor;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        alignment: Alignment.center,
        width: width ?? double.maxFinite,
        height: height ?? 44.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          color: AppColors.button,
        ),
        child: isLoading
            ? const CircularProgressIndicator(
                color: AppColors.secondary,
              )
            : Text(
                title,
                style: Theme.of(context).textTheme.titleSmall,
              ),
      ),
    );
  }
}
