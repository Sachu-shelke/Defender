class CompanyPorfolioModel {
  int? status;
  String? message;
  List<TodayBussiness>? todayBussiness;
  List<MonthlyPlanBussiness>? monthlyPlanBussiness;
  num? silver;
  num? gold;
  num? platinum;
  num? diamond;
  num? doubleDiamond;
  num? ambassador;
  num? carFund;
  num? houseFund;
  num? travelFund;
  num? comunityFund;
  num? mobilefund;

  CompanyPorfolioModel(
      {this.status,
      this.message,
      this.todayBussiness,
      this.monthlyPlanBussiness,
      this.mobilefund,
      this.silver,
      this.gold,
      this.platinum,
      this.diamond,
      this.doubleDiamond,
      this.ambassador,
      this.carFund,
      this.houseFund,
      this.travelFund,
      this.comunityFund});

  CompanyPorfolioModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['todayBussiness'] != null) {
      todayBussiness = <TodayBussiness>[];
      json['todayBussiness'].forEach((v) {
        todayBussiness!.add(TodayBussiness.fromJson(v));
      });
    }
    if (json['MonthlyPlanBussiness'] != null) {
      monthlyPlanBussiness = <MonthlyPlanBussiness>[];
      json['MonthlyPlanBussiness'].forEach((v) {
        monthlyPlanBussiness!.add(MonthlyPlanBussiness.fromJson(v));
      });
    }
    silver = json['Silver'];
    gold = json['Gold'];
    platinum = json['Platinum'];
    diamond = json['Diamond'];
    doubleDiamond = json['DoubleDiamond'];
    ambassador = json['Ambassador'];
    carFund = json['CarFund'];
    houseFund = json['HouseFund'];
    travelFund = json['TravelFund'];
    comunityFund = json['ComunityFund'];
    mobilefund = json['Mobilefund'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (todayBussiness != null) {
      data['todayBussiness'] = todayBussiness!.map((v) => v.toJson()).toList();
    }
    if (monthlyPlanBussiness != null) {
      data['MonthlyPlanBussiness'] =
          monthlyPlanBussiness!.map((v) => v.toJson()).toList();
    }
    data['Silver'] = silver;
    data['Gold'] = gold;
    data['Platinum'] = platinum;
    data['Diamond'] = diamond;
    data['DoubleDiamond'] = doubleDiamond;
    data['Ambassador'] = ambassador;
    data['CarFund'] = carFund;
    data['HouseFund'] = houseFund;
    data['TravelFund'] = travelFund;
    data['ComunityFund'] = comunityFund;
    return data;
  }
}

class TodayBussiness {
  int? hybrid;
  int? booster;
  int? primeA;
  int? primeB;

  TodayBussiness({this.hybrid, this.booster, this.primeA, this.primeB});

  TodayBussiness.fromJson(Map<String, dynamic> json) {
    hybrid = json['hybrid'];
    booster = json['booster'];
    primeA = json['prime_a'];
    primeB = json['prime_b'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['hybrid'] = hybrid;
    data['booster'] = booster;
    data['prime_a'] = primeA;
    data['prime_b'] = primeB;
    return data;
  }
}

class MonthlyPlanBussiness {
  int? hybrid;
  int? booster;
  int? primeA;
  int? primeB;

  MonthlyPlanBussiness({this.hybrid, this.booster, this.primeA, this.primeB});

  MonthlyPlanBussiness.fromJson(Map<String, dynamic> json) {
    hybrid = json['hybrid'];
    booster = json['booster'];
    primeA = json['prime_a'];
    primeB = json['prime_b'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['hybrid'] = hybrid;
    data['booster'] = booster;
    data['prime_a'] = primeA;
    data['prime_b'] = primeB;
    return data;
  }
}
