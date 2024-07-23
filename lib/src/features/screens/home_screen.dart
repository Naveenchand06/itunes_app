import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:itunes_app/src/features/models/search_response.dart';
import 'package:itunes_app/src/features/repository/search_repository.dart';
import 'package:itunes_app/src/network/models/app_response.dart';
import 'package:itunes_app/src/utils/loading/loading_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // * Loading Listener

    // ref.listen<AppResponse<SearchResponse>>(
    //   searchNotifierProvider,
    //   (previous, current) async {
    //     if (current.isLoading == true) {
    //       LoadingScreen.instance().show(
    //         context: context,
    //       );
    //     } else {
    //       LoadingScreen.instance().hide();
    //     }
    //   },
    // );
    final isLoading = ref.watch(searchNotifierProvider).isLoading;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        title: const Text("iTunes"),
      ),
      body: Center(
          child: isLoading
              ? CircularProgressIndicator(
                  color: Colors.white,
                )
              : Text("------")),
    );
  }
}
