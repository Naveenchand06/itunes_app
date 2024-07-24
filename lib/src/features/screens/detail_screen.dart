import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:itunes_app/src/constants/app_colors.dart';
import 'package:itunes_app/src/constants/app_strings.dart';
import 'package:itunes_app/src/features/models/search_response.dart';

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
  @override
  Widget build(BuildContext context) {
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
            SizedBox(height: 20.0),
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
                  Column(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10.0),
                          Wrap(
                            children: [
                              SizedBox(
                                width: 280.0,
                                child: Text(widget.details.trackName,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium),
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
                        ],
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Row(
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
            Text(
              AppStrings.preview,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w300,
                  ),
            ),
            const SizedBox(height: 30.0),
            // * Preview
            Text(
              AppStrings.description,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w300,
                  ),
            ),
            const SizedBox(height: 10.0),
            Text(
              AppStrings.description,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w300,
                  ),
            )
          ],
        ),
      ),
    );
  }
}
