// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:defenders/config/manager/global_singleton.dart';
import 'package:defenders/config/theme/app_colors.dart';
import 'package:defenders/config/theme/app_text_style.dart';
import 'package:defenders/constants/app_sizes.dart';
import 'package:defenders/model/ebook_model/ebook_category_model.dart';
import 'package:defenders/utils/api_path.dart';
import 'package:defenders/utils/encrypted_api_path.dart';
import 'package:defenders/utils/network/network_dio.dart';
import 'package:defenders/widget/appbars/custom_app_bar.dart';
import 'package:defenders/widget/button/primary_button.dart';
import 'package:defenders/widget/snackbar/snackbars.dart';
import 'package:defenders/widget/textfields/default_text_field.dart';

class AddBookScreen extends StatefulWidget {
  const AddBookScreen({super.key});

  @override
  State<AddBookScreen> createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController ebookNameController = TextEditingController();
  final TextEditingController authorController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quanityController = TextEditingController();
  final TextEditingController discountController = TextEditingController();
  List<BookCategoriesData> category = <BookCategoriesData>[];
  String? selectedImages;
  XFile? bankStatmentPdf;
  BookCategoriesData? selectedCategories;

  @override
  void initState() {
    ebookCategories(context: context);
    super.initState();
  }

  Future<void> _pickImages() async {
    XFile? pickedImages = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    // if (pickedImages != null) {
    //   model.selectedImages = pickedImages;
    // }

    if (pickedImages != null) {
      selectedImages = pickedImages.path;
    }
    setState(() {});
  }

  List<File> _files = [];
  Future<void> _pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
        allowMultiple: false);

    if (result != null) {
      setState(() {
        _files = result.paths.map((path) => File(path!)).toList();
        bankStatmentPdf = XFile(_files.first.path);
      });
    }
  }

  Future<void> ebookCategories({required BuildContext context}) async {
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
        url: ApiPath.apiEndPoint + EncryptedApiPath.ebookCategories,
        data: {},
        context: context);

    if (response != null && response['status'] == 200) {
      category = BookCategoriesModel.fromJson(response).data!;
    }
    setState(() {});
  }

  Future<void> uploadBook({BuildContext? context}) async {
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
        url: ApiPath.apiEndPoint + EncryptedApiPath.ebookUpload,
        isEncryptionUse: true,
        data: FormData.fromMap(
          {
            "ebook_name": ebookNameController.text,
            "author": authorController.text,
            "description": descriptionController.text,
            "price": priceController.text,
            "quantity": quanityController.text,
            "discount": discountController.text,
            "category_id": selectedCategories!.id,
            "user_id": GlobalSingleton.loginInfo!.data!.id.toString(),
            "image": await MultipartFile.fromFile(
              selectedImages!,
              filename: 'book.jpg',
            ),

            'ebook_pdf': await MultipartFile.fromFile(
              bankStatmentPdf!.path,
              // filename: 'aadhaar.jpg',
            ),
            // 'aadharBackImage': await MultipartFile.fromFile(
            //   model.selectedAdhaarBackImage!.path,
            //   filename: 'aadhaar_back.jpg',
            // ),
            // "chequeBookImage": await MultipartFile.fromFile(
            //   model.bankDetailsImage!.path,
            //   filename: 'cheque.jpg',
            // ),
          },
        ),
        context: context);
    if (response != null && response['status'] == 200) {
      Navigator.pop(context!);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBars.successSnackBar(title: "Book Added Successfully"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Add Book"),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          children: [
            DefaultTextField(
              controller: ebookNameController,
              labelTextStrr: 'Book Name',
              maxLines: 1,
              inputFormatters: [
                // LengthLimitingTextInputFormatter(15),
                FilteringTextInputFormatter.allow(RegExp("[a-z A-Z]")),
              ],
            ),
            DefaultTextField(
              controller: authorController,
              labelTextStrr: 'Author Name',
              maxLines: 1,
              inputFormatters: [
                // LengthLimitingTextInputFormatter(15),
                FilteringTextInputFormatter.allow(RegExp("[a-z A-Z]")),
              ],
            ),
            DefaultTextField(
              controller: descriptionController,
              labelTextStrr: 'Description',
              maxLines: 1,
              inputFormatters: [
                // LengthLimitingTextInputFormatter(15),
                FilteringTextInputFormatter.allow(RegExp("[a-z A-Z]")),
              ],
            ),
            DefaultTextField(
              controller: priceController,
              labelTextStrr: 'Price',
              maxLines: 1,
              type: TextInputType.number,
            ),
            DefaultTextField(
              controller: quanityController,
              labelTextStrr: 'Quantity',
              type: TextInputType.number,
              maxLines: 1,
            ),
            DefaultTextField(
              controller: discountController,
              labelTextStrr: 'Discount',
              type: TextInputType.number,
              maxLines: 1,
            ),
            SizedBox(
                child: DropdownButtonHideUnderline(
              child: DropdownButtonFormField<BookCategoriesData>(
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
                value: selectedCategories,
                hint: const Text(
                  'Select Categories',
                  textScaleFactor: 1.0,
                ),
                isExpanded: true,
                onChanged: (val) {
                  selectedCategories = val!;
                  // presenter.getAffilatecatLink(
                  //     context: context,
                  //     id: model.selectedCategories!.id.toString());
                  setState(() {});
                },
                validator: (value) =>
                    value == null ? 'This field required' : null,
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: AppColors.appColors,
                  size: 24,
                ),
                iconSize: 24,
                items: category
                    .map<DropdownMenuItem<BookCategoriesData>>(
                        (BookCategoriesData value) {
                      return DropdownMenuItem<BookCategoriesData>(
                        value: value,
                        child: Text(
                          value.categoryName.toString(),
                          textScaleFactor: 1.0,
                          style: AppTextStyle.regular16,
                        ),
                      );
                    })
                    .toSet()
                    .toList(),
              ),
            )),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Upload Book Thumbnail",
                    style: AppTextStyle.semiBold16,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      MaterialButton(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 14),
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(color: AppColors.appColors),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        onPressed: _pickImages,
                        child: Text("Book Thumbnail",
                            style: AppTextStyle.semiBold14
                                .copyWith(color: AppColors.appColors)),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      if (selectedImages != null)
                        Container(
                          width: 70,
                          height: 70,
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: Image.file(
                            File(
                              selectedImages!,
                            ),
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,
                          ),
                        )
                    ],
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Stack(
                children: [
                  Card(
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: bankStatmentPdf != null
                        ? const SizedBox(
                            width: 300,
                            height: 100,
                            child: Center(
                              child: Text('PDF Uploaded'),
                            ))
                        : Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 35, vertical: 10),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: AppSizes.size10,
                                ),
                                const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [Text('Upload book PDF')]),
                                const SizedBox(
                                  height: AppSizes.size10,
                                ),
                                InkWell(
                                  onTap: _pickFiles,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColors.appColors),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 10),
                                    child: Text(
                                      'Upload +',
                                      style: AppTextStyle.regular14
                                          .copyWith(color: AppColors.appColors),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: AppSizes.size10,
                                ),
                              ],
                            ),
                          ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (bankStatmentPdf != null)
                    Positioned(
                        top: 0,
                        right: 0,
                        child: InkWell(
                          onTap: () {
                            print('object');
                            bankStatmentPdf = null;
                            setState(() {});
                          },
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: AppColors.appColors,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.close,
                              color: AppColors.whiteColor,
                            ),
                          ),
                        ))
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
      bottomNavigationBar: PrimaryButton(
          borderRadius: 0,
          onTap: () {
            if (_formKey.currentState!.validate()) {
              if (selectedImages == null || bankStatmentPdf == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBars.errorSnackBar(
                        title: "Please Upload Image or PDF"));
              } else {
                uploadBook(context: context);
              }
            }
          },
          text: "Submit"),
    );
  }
}
