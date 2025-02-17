class BookCategoriesModel {
  int? status;
  String? message;
  List<BookCategoriesData>? data;

  BookCategoriesModel({this.status, this.message, this.data});

  BookCategoriesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <BookCategoriesData>[];
      json['data'].forEach((v) {
        data!.add(BookCategoriesData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BookCategoriesData {
  int? id;
  String? categoryName;
  int? status;
  String? createdOn;

  BookCategoriesData({this.id, this.categoryName, this.status, this.createdOn});

  BookCategoriesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['category_name'];
    status = json['status'];
    createdOn = json['created_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['category_name'] = categoryName;
    data['status'] = status;
    data['created_on'] = createdOn;
    return data;
  }
}
