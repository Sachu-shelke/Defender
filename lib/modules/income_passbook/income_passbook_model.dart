import 'package:defenders/model/income_passbook/user_income_passbook_model.dart';

class IncomePassbookModel {
  List<UserIncomePassbookData>? incomeList;
  TotalAmount? totalAmount;
  IncomePassbookModel({
    required this.incomeList,
    this.totalAmount,
  });
}
