import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:itunes_app/src/constants/app_colors.dart';
import 'package:itunes_app/src/extensions/string_extensions.dart';
import 'package:itunes_app/src/features/models/search_response.dart';
import 'package:itunes_app/src/features/repository/search_repository.dart';
import 'package:itunes_app/src/features/screens/detail_screen.dart';
import 'package:itunes_app/src/network/models/app_response.dart';
import 'package:itunes_app/src/utils/loading/loading_screen.dart';
import 'package:itunes_app/src/widgets/app_error_widget.dart';
import 'package:itunes_app/src/widgets/section_title.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({
    super.key,
    required this.term,
    required this.tag,
  });

  final String term;
  final String tag;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(searchNotifierProvider.notifier).search(
            term: widget.term,
            tag: widget.tag,
          );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // * Loading Listener

    ref.listen<AppResponse<SearchResponse>>(
      searchNotifierProvider,
      (previous, current) async {
        if (current.isLoading == true) {
          LoadingScreen.instance().show(
            context: context,
          );
        } else {
          LoadingScreen.instance().hide();
        }
      },
    );
    final searchValue = ref.watch(searchNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        title: const Text("iTunes"),
      ),
      body: Builder(builder: (context) {
        if (searchValue.error != null) {
          // * Error Response
          return AppErrorWidget(
            appError: searchValue.error!,
            showButton: true,
            onPress: () {
              ref.read(searchNotifierProvider.notifier).search(
                    term: widget.term,
                    tag: widget.tag,
                  );
            },
          );
        } else if (searchValue.isLoading) {
          // * Loading
          return const SizedBox.shrink();
        } else if (searchValue.result != null) {
          // * Success Response
          final allCategory = searchValue.result!.categoryResults;
          return SingleChildScrollView(
            child: Column(
              children: allCategory.map(
                (category) {
                  if (category.results.isNotEmpty) {
                    // * Media type title
                    return Column(
                      children: [
                        SectionTitle(title: category.category),
                        // * List of Items for that Category
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: category.results.length,
                          itemBuilder: (context, index) {
                            final item = category.results[index];
                            return InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        DetailScreen(details: item)));
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0,
                                  vertical: 12.0,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    SizedBox(
                                      height: 130.0,
                                      width: 90.0,
                                      child: Image.network(
                                        item.artworkUrl100,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(width: 12.0),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Wrap(
                                          children: [
                                            SizedBox(
                                              width: 300.0,
                                              child: Text(item.trackName,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 4.0),
                                        Text(item.artistName,
                                            overflow: TextOverflow.clip,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ).toList(),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      }),
    );
  }
}
