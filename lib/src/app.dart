import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:itunes_app/src/constants/app_colors.dart';
import 'package:itunes_app/src/features/screens/intro_screen.dart';
import 'package:itunes_app/src/network/models/app_error.dart';
import 'package:itunes_app/src/widgets/app_error_widget.dart';
import 'package:root_detector/root_detector.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: RootDetector.isRooted(ignoreSimulator: true),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return appScreenCover(
              body: const CupertinoActivityIndicator(
                color: AppColors.secondary,
                radius: 32.0,
              ),
            );
          case ConnectionState.done:
            if (snapshot.data == true) {
              return appScreenCover(
                body: const AppErrorWidget(
                  appError: AppErrorModel(errorMessage: "Mobile is rooted!"),
                ),
              );
            } else {
              return const IntroScreen();
            }
          default:
            return const IntroScreen();
        }
      },
    );
  }

  Widget appScreenCover({required Widget body}) {
    return Scaffold(
      body: Center(
        child: body,
      ),
    );
  }
}
