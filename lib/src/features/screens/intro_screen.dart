import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:itunes_app/src/constants/app_colors.dart';
import 'package:itunes_app/src/constants/app_strings.dart';
import 'package:itunes_app/src/features/screens/home_screen.dart';
import 'package:itunes_app/src/features/screens/tag_screen.dart';
import 'package:itunes_app/src/widgets/app_button.dart';
import 'package:itunes_app/src/widgets/app_tag.dart';
import 'package:itunes_app/src/widgets/app_text_field.dart';

class IntroScreen extends ConsumerStatefulWidget {
  const IntroScreen({super.key});

  @override
  ConsumerState<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends ConsumerState<IntroScreen> {
  List<String> _selectedtags = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Image.asset('assets/images/logo.png')),
              const SizedBox(height: 20.0),
              Text(
                AppStrings.iTunesIntro,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 30.0),
              // * Search Field
              AppTextField(
                controller: _searchController,
              ),
              // * Search Tags
              const SizedBox(height: 20.0),
              Text(
                AppStrings.searchFieldlabel,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 18.0),
              // * tag Field
              InkWell(
                onTap: () async {
                  final List<String> tags = await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          TagScreen(selectedTags: _selectedtags),
                    ),
                  );
                  setState(() {
                    _selectedtags = tags;
                  });
                },
                child: Container(
                  height: 100.0,
                  width: double.maxFinite,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.0),
                    color: AppColors.tagField,
                  ),
                  child: Wrap(
                    children:
                        _selectedtags.map((e) => AppTag(title: e)).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 30.0),
              // * Submit Button
              AppButton(
                title: AppStrings.submit,
                onPress: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(
                        term: _searchController.text.trim(),
                        tag: _selectedtags
                            .map((item) => item.toLowerCase())
                            .toList()
                            .join(","),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
