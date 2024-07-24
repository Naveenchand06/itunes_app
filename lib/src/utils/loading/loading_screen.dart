import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:itunes_app/src/constants/app_colors.dart';
import 'package:itunes_app/src/utils/loading/loading_screen_controller.dart';

class LoadingScreen {
  /// Creating a singleton (In the entire application we only want one loading screen)
  LoadingScreen._sharedInstance();
  static final LoadingScreen _shared = LoadingScreen._sharedInstance();
  factory LoadingScreen.instance() => _shared;

  LoadingScreenController? _controller;

  void show({
    required BuildContext context,
  }) {
    if (_controller?.update() ?? false) {
      return;
    } else {
      _controller = showOverLay(context: context);
    }
  }

  void hide() {
    _controller?.close();
    _controller = null;
  }

  LoadingScreenController? showOverLay({
    required BuildContext context,
  }) {
    final state = Overlay.of(context);
    // if (state == null) {
    //   return null;
    // }

    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    final overlay = OverlayEntry(
      builder: (context) {
        return Material(
          color: Colors.black.withAlpha(150),
          child: Center(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: size.width * 0.8,
                maxHeight: size.width * 0.8,
                minWidth: size.width * 0.5,
              ),
              decoration: BoxDecoration(
                color: AppColors.field,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 20),
                      CupertinoActivityIndicator(
                        radius: 20.0,
                        color: AppColors.secondary,
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );

    state.insert(overlay);

    return LoadingScreenController(close: () {
      overlay.remove();
      return true;
    }, update: () {
      return true;
    });
  }
}
