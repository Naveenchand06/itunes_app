import 'package:flutter/cupertino.dart';
import 'package:itunes_app/src/constants/app_colors.dart';
import 'package:itunes_app/src/network/models/app_error.dart';
import 'package:itunes_app/src/widgets/app_text_button.dart';

class AppErrorWidget extends StatelessWidget {
  const AppErrorWidget({
    super.key,
    this.onPress,
    this.showButton = false,
    required this.appError,
  });

  final AppErrorModel appError;
  final VoidCallback? onPress;
  final bool showButton;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        margin: const EdgeInsets.all(16.0),
        constraints: const BoxConstraints(
          maxWidth: 350.0,
          minWidth: 250.0,
          maxHeight: 200.0,
        ),
        decoration: BoxDecoration(
          color: AppColors.field,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              CupertinoIcons.xmark_circle,
              color: AppColors.error,
              size: 30.0,
            ),
            const SizedBox(height: 10.0),
            Text(appError.errorMessage),
            const SizedBox(height: 8.0),
            if (showButton)
              AppTextButton(
                title: 'Try Again',
                onPress: onPress ?? () {},
              )
          ],
        ),
      ),
    );
  }
}
