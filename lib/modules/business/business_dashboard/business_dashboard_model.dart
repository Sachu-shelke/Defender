import 'package:flutter/material.dart';
import 'package:defenders/model/company/company_portfolio_model.dart';
import 'package:defenders/model/team_details/team_details_model.dart';

class BusinessDashboardModel {
  List<DashboardIncomeList> incomeList;
  List<DashboardIncomeList> companyIncomeList;
  List<DashboardIncomeList> companyRoyalityList;
  List<DashboardIncomeList> filteredincomeList;
  List<TodayBussiness>? todayBussiness;
  CompanyPorfolioModel? companyPortfolio;

  TeamDetailsModel? teamDetails;
  int selectedDasboardButtonIndex;
  int selectedBusinessScreenIndex;
  BusinessDashboardModel({
    required this.incomeList,
    required this.filteredincomeList,
    required this.companyIncomeList,
    required this.companyRoyalityList,
    required this.todayBussiness,
    required this.companyPortfolio,
    this.teamDetails,
    this.selectedDasboardButtonIndex = 0,
    this.selectedBusinessScreenIndex = 0,
  });
}

class DashboardIncomeList {
  String name;
  String? otherName;
  String income;
  String? path;
  String? id;
  Color? color;
  Color? otherColor;
  String? image;
  int catId;
  DashboardIncomeList({
    required this.name,
    required this.income,
    required this.catId,
    this.path,
    this.image,
    this.color,
    this.otherColor,
    this.otherName,
    this.id,
  });
}
