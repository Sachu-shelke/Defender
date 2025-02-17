import 'package:defenders/model/passbook_model/wallet_passbook_model.dart';

class CashbackPassbookModel {
  List<WalletPassbookDataModelData>? walletData;
  int lastPageIndex;
  CashbackPassbookModel({required this.lastPageIndex, this.walletData});
}
