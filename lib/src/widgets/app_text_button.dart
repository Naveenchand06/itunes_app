import 'package:flutter/material.dart';
import 'package:itunes_app/src/constants/app_colors.dart';

class AppTextButton extends StatelessWidget {
  const AppTextButton({
    super.key,
    required this.title,
    required this.onPress,
    this.style,
  });

  final String title;
  final VoidCallback onPress;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(padding: WidgetStateProperty.all(EdgeInsets.zero)),
      onPressed: onPress,
      child: Text(
        title,
        style: style ??
            Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.secondary.withOpacity(0.6),
                ),
      ),
    );
  }
}
