import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:itunes_app/src/constants/app_colors.dart';
import 'package:itunes_app/src/constants/app_strings.dart';
import 'package:itunes_app/src/features/models/search_response.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

class DetailScreen extends ConsumerStatefulWidget {
  const DetailScreen({
    super.key,
    required this.details,
  });

  final Result details;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DetailScreenState();
}

class _DetailScreenState extends ConsumerState<DetailScreen> {
  late VideoPlayerController _controller;
  Size screenSize = const Size(0, 0);
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    log("Preview URL ---> ${widget.details.previewUrl}");
    _controller =
        VideoPlayerController.networkUrl(Uri.parse(widget.details.previewUrl))
          ..initialize().then((_) {
            setState(() {});
          });

    if (!(_controller.value.isPlaying)) {
      setState(() {
        _isPlaying = true;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        title: const Text(AppStrings.description),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20.0),
            // * Details Card
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 12.0,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    height: 200.0,
                    width: 120.0,
                    child: Image.network(
                      widget.details.artworkUrl100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 20.0),
                  // * Card Details
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10.0),
                      Wrap(
                        children: [
                          SizedBox(
                            width: screenSize.width * 60 / 100,
                            child: Text(widget.details.trackName,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: Theme.of(context).textTheme.bodyMedium),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        widget.details.artistName,
                        overflow: TextOverflow.clip,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 20.0),
                      Text(
                        widget.details.primaryGenreName,
                        overflow: TextOverflow.clip,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: AppColors.alert),
                      ),
                      const SizedBox(height: 20.0),
                      InkWell(
                        onTap: () {
                          _launchUrl(Uri.parse(widget.details.trackViewUrl));
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppStrings.preview,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: AppColors.link,
                                  ),
                            ),
                            const SizedBox(width: 10.0),
                            const Icon(
                              CupertinoIcons.compass,
                              color: AppColors.link,
                            )
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            // * Preview
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        AppStrings.preview,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w300,
                            ),
                      ),
                      const SizedBox(width: 10.0),
                      const Tooltip(
                        message: "Tap to preview",
                        triggerMode: TooltipTriggerMode.tap,
                        child: Icon(
                          Icons.info,
                          color: AppColors.secondary,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _controller.value.isPlaying
                            ? {
                                setState(() {
                                  _isPlaying = false;
                                }),
                                _controller.pause(),
                              }
                            : {
                                setState(() {
                                  _isPlaying = true;
                                }),
                                _controller.play(),
                              };
                      });
                    },
                    child: SizedBox(
                      width: screenSize.width,
                      height: 250.0,
                      child: widget.details.previewUrl
                              .toLowerCase()
                              .contains('audio')
                          ? const Stack(
                              alignment: Alignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      CupertinoIcons.music_albums,
                                      color: AppColors.secondary,
                                      size: 80.0,
                                    ),
                                    SizedBox(height: 10.0),
                                    Text(AppStrings.tapToPlay)
                                  ],
                                ),
                              ],
                            )
                          : Stack(
                              alignment: Alignment.center,
                              children: [
                                _controller.value.isInitialized
                                    ? AspectRatio(
                                        aspectRatio:
                                            _controller.value.aspectRatio,
                                        child: VideoPlayer(_controller),
                                      )
                                    : Container(),
                                _isPlaying
                                    ? const SizedBox.shrink()
                                    : Icon(
                                        CupertinoIcons.play_arrow,
                                        color: AppColors.secondary
                                            .withOpacity(0.5),
                                        size: 80.0,
                                      ),
                              ],
                            ),
                    ),
                  ),
                  const SizedBox(height: 30.0),
                ],
              ),
            ),

            // * Description
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w300,
                        ),
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    widget.details.trackCensoredName,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w300,
                        ),
                  ),
                  const SizedBox(height: 30.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl(Uri url) async {
    await launchUrl(url);
  }
}
