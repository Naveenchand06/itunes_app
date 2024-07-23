import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:itunes_app/src/constants/app_colors.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    this.hint,
    this.controller,
    this.inputformatters,
    this.onChange,
    this.onSubmit,
    this.inputAction = TextInputAction.next,
    this.enableTopBottomGap = true,
    this.validator,
    this.fieldEnabled,
    this.leadIcon,
    this.vertGap,
    super.key,
  });

  final String? hint;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputformatters;
  final Function(String)? onChange;
  final Function(String)? onSubmit;
  final TextInputAction? inputAction;
  final bool enableTopBottomGap;
  final FormFieldValidator<String>? validator;
  final bool? fieldEnabled;
  final IconData? leadIcon;
  final double? vertGap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: vertGap ?? 10.0),
      child: TextFormField(
        inputFormatters: inputformatters,
        controller: controller,
        onChanged: onChange,
        onFieldSubmitted: onSubmit,
        textInputAction: inputAction,
        validator: validator,
        enabled: fieldEnabled,
        style: Theme.of(context).textTheme.bodyMedium,
        decoration: InputDecoration(
          hintText: hint ?? '',
          hintStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: AppColors.primary.withOpacity(0.4),
                fontWeight: FontWeight.w400,
              ),
          filled: true,
          fillColor: AppColors.field,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 14.0,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.0),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.0),
            borderSide: BorderSide(
              color: AppColors.primary.withAlpha(100),
              width: 1.4,
            ),
          ),
        ),
      ),
    );
  }
}
