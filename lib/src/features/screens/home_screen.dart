import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:itunes_app/src/constants/app_colors.dart';
import 'package:itunes_app/src/features/models/search_response.dart';
import 'package:itunes_app/src/features/repository/search_repository.dart';
import 'package:itunes_app/src/network/models/app_response.dart';
import 'package:itunes_app/src/utils/loading/loading_screen.dart';
import 'package:itunes_app/src/widgets/app_error_widget.dart';

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
          return ListView.builder(
            itemCount: searchValue.result?.resultCount ?? 0,
            itemBuilder: (context, index) {
              final item = searchValue.result!.results[index];
              return ListTile(
                title: Text(item.trackName),
                subtitle: Text(item.artistName),
              );
            },
          );
        } else {
          return const SizedBox.shrink();
        }
      }),
    );
  }
}
