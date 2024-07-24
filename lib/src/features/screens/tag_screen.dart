import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:itunes_app/src/constants/app_colors.dart';
import 'package:itunes_app/src/constants/app_strings.dart';

class TagScreen extends ConsumerStatefulWidget {
  const TagScreen({
    super.key,
    required this.selectedTags,
  });

  final List<String> selectedTags;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TagScreenState();
}

class _TagScreenState extends ConsumerState<TagScreen> {
  List<String> _selectedTags = [];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _selectedTags = widget.selectedTags;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, _selectedTags);
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        title: const Text('Media'),
      ),
      body: ListView.separated(
        itemCount: AppStrings.mediaTypeParams.length,
        separatorBuilder: (context, index) {
          return Divider(
            color: AppColors.secondary.withOpacity(0.3),
          );
        },
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              if (_selectedTags.contains(AppStrings.mediaTypeParams[index])) {
                _selectedTags.remove(AppStrings.mediaTypeParams[index]);
              } else {
                _selectedTags.add(AppStrings.mediaTypeParams[index]);
              }
              setState(() {});
            },
            title: Text(
              AppStrings.mediaTypeParams[index],
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            trailing: _selectedTags.contains(AppStrings.mediaTypeParams[index])
                ? const Icon(
                    Icons.check,
                    color: AppColors.secondary,
                  )
                : null,
          );
        },
      ),
    );
  }
}
