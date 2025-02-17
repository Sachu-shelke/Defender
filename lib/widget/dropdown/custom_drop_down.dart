// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:defenders/config/theme/app_colors.dart';
import 'package:defenders/config/theme/app_text_style.dart';

class CustomDropDownString extends StatefulWidget {
  final List<String> data;
  final String? selectedDropdownValue;
  final Function(String?) onChanged;
  final String title;
  final double padding;
  final Color titleColor;
  const CustomDropDownString(
      {required this.data,
      required this.selectedDropdownValue,
      required this.onChanged,
      required this.title,
      super.key,
      this.padding = 12,
      this.titleColor = Colors.black});

  @override
  _CustomDropDownStringState createState() => _CustomDropDownStringState();
}

class _CustomDropDownStringState extends State<CustomDropDownString> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: widget.padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.title,
              textScaleFactor: 1.0, style: AppTextStyle.semiBold14),
          const SizedBox(height: 10),
          SizedBox(
              child: DropdownButtonHideUnderline(
            child: DropdownButtonFormField<String>(
              focusColor: AppColors.appColors,
              decoration: const InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                  border: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppColors.appColors, width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppColors.appColors, width: 1.0),
                  )),
              value: widget.selectedDropdownValue,
              hint: Text(
                widget.title,
                textScaleFactor: 1.0,
              ),
              isExpanded: true,
              onChanged: widget.onChanged,
              validator: (value) =>
                  value == null ? 'This field required' : null,
              icon: const Icon(
                Icons.arrow_drop_down,
                color: AppColors.appColors,
                size: 24,
              ),
              iconSize: 24,
              items: widget.data
                  .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        textScaleFactor: 1.0,
                        style: AppTextStyle.regular16,
                      ),
                    );
                  })
                  .toSet()
                  .toList(),
            ),
          )),
        ],
      ),
    );
  }
}
