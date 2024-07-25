import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:itunes_app/src/constants/app_colors.dart';
import 'package:itunes_app/src/constants/app_strings.dart';
import 'package:itunes_app/src/features/models/search_response.dart';
import 'package:itunes_app/src/features/repository/search_repository.dart';
import 'package:itunes_app/src/features/screens/detail_screen.dart';
import 'package:itunes_app/src/core/network/models/app_response.dart';
import 'package:itunes_app/src/utils/loading/loading_screen.dart';
import 'package:itunes_app/src/widgets/app_error_widget.dart';
import 'package:itunes_app/src/widgets/section_title.dart';
import 'package:toggle_switch/toggle_switch.dart';

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

  Size screenSize = const Size(0, 0);
  bool _isGridView = true;

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;

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
              children: [
                ToggleSwitch(
                  minWidth: screenSize.width,
                  cornerRadius: 6.0,
                  activeBgColors: const [
                    [AppColors.field],
                    [AppColors.field]
                  ],
                  inactiveBgColor: AppColors.tagField,
                  changeOnTap: true,
                  initialLabelIndex: _isGridView ? 0 : 1,
                  totalSwitches: 2,
                  labels: const [AppStrings.gridLayout, AppStrings.listLayout],
                  radiusStyle: true,
                  animate: false,
                  onToggle: (index) {
                    if (index == 0) {
                      setState(() {
                        _isGridView = true;
                      });
                    } else {
                      setState(() {
                        _isGridView = false;
                      });
                    }
                  },
                ),
                const SizedBox(height: 10.0),
                SingleChildScrollView(
                  child: Column(
                    children: allCategory.map(
                      (category) {
                        if (category.results.isNotEmpty) {
                          // * Media type title
                          return Column(
                            children: [
                              SectionTitle(title: category.category),
                              if (_isGridView)
                                // * Grid of Items for that category
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: GridView(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        mainAxisSpacing: 30.0,
                                        crossAxisSpacing: 8.0,
                                      ),
                                      children: category.results.map((item) {
                                        return InkWell(
                                          onTap: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        DetailScreen(
                                                            details: item)));
                                          },
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 120.0,
                                                width: 120.0,
                                                child: Image.network(
                                                  item.artworkUrl100,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              const SizedBox(height: 4.0),
                                              Text(item.trackName,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium),
                                            ],
                                          ),
                                        );
                                      }).toList()),
                                ),
                              if (!_isGridView)
                                // * List of Items for that Category
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: category.results.length,
                                  itemBuilder: (context, index) {
                                    final item = category.results[index];
                                    return InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailScreen(
                                                        details: item)));
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0,
                                          vertical: 12.0,
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                                      width: 250.0,
                                                      child: Text(
                                                          item.trackName,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 2,
                                                          style:
                                                              Theme.of(context)
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
                ),
              ],
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      }),
    );
  }
}
