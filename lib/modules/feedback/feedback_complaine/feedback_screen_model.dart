import 'package:flutter/material.dart';
import 'package:defenders/model/feedback_model/get_feedback_category_by_id.dart';
import 'package:defenders/model/feedback_model/get_feedback_category_model.dart';

class FeebackScreenModel {
  String? selectedFile;
  String? selectedCategoriesId;
  String? selectedReasonId;
  TextEditingController controller;
  List<FeedbackCategoryResponse> feedbackCategoryData;
  List<FeedbackCategoriesByIdResponse> feedbackCategoryDatabyId;
  FeebackScreenModel(
      {this.selectedFile,
      this.selectedReasonId,
      this.selectedCategoriesId,
      required this.feedbackCategoryData,
      required this.feedbackCategoryDatabyId,
      required this.controller});
}
