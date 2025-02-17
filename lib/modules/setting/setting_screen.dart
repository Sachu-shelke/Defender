import 'package:flutter/material.dart';
import 'package:defenders/config/manager/global_singleton.dart';
import 'package:defenders/config/manager/storage_manager.dart';
import 'package:defenders/config/theme/app_colors.dart';
import 'package:defenders/config/theme/app_text_style.dart';
import 'package:defenders/widget/appbars/custom_app_bar.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool isSwitched = false;

  @override
  void initState() {
    isSwitched = StorageManager.getBoolValue('isCallLogHide') ?? false;
    super.initState();
  }

  int selectedLang = 0;

  List lanList = [
    {
      'name': 'English',
      'title':
          "Dear ${GlobalSingleton.loginInfo!.data!.firstName}, We respect your privacy. so if you want to delete or stop data we will proceed with this. please, make sure you want to delete it.",
    },
    {
      'name': 'Hindi',
      'title':
          "प्रिय ${GlobalSingleton.loginInfo!.data!.firstName}, हम आपकी प्राइवेसी  का सम्मान करते हैं। इसलिए यदि आप डेटा को हटाना या रोकना चाहते हैं तो हम इस पर आगे बढ़ेंगे। कृपया पुष्टि करें कि आप इसे हटाना चाहते हैं.",
    },
    {
      'name': 'Gujrati',
      'title':
          "પ્રિય ${GlobalSingleton.loginInfo!.data!.firstName}, અમે તમારી પ્રિવાસી નો  આદર કરીએ છીએ. તેથી જો તમે ડેટા કાઢી નાખવા અથવા રોકવા માંગતા હોવ તો અમે આ સાથે આગળ વધીશું. કૃપા કરીને, ખાતરી કરો કે તમે તેને કાઢી નાખવા માંગો છો.",
    },
    {
      'name': 'Marathi',
      'title':
          "डिअर ${GlobalSingleton.loginInfo!.data!.firstName}, आम्ही तुमच्या प्रायव्हसीचा आदर करतो. म्हणून जर तुम्हाला डेटा हटवायचा असेल किंवा थांबवायचा असेल तर आम्ही यासह पुढे जाऊ. कृपया, तुम्हाला ते हटवायचे आहे याची खात्री करा.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Setting'),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Hide Call Log'),
            subtitle: const Text('You can stop your call log data'),
            trailing: Switch(
              value: isSwitched,
              onChanged: (value) {
                setState(() {
                  dialogData(value);
                });
              },
              activeTrackColor: AppColors.appColors.withOpacity(0.5),
              activeColor: AppColors.appColors,
            ),
          ),
        ],
      ),
    );
  }

  dialogData(bool val) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return StatefulBuilder(builder: (context, setstate) {
          return Dialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(32.0),
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Declaimer',
                    style: AppTextStyle.semiBold20,
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Container(
                    decoration: const BoxDecoration(color: Color(0xffF1F1F1)),
                    child: SingleChildScrollView(
                      child: Row(
                        children: List.generate(
                            4,
                            (index) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child: InkWell(
                                    onTap: () {
                                      selectedLang = index;
                                      setstate(() {});
                                    },
                                    child: Column(
                                      children: [
                                        Text(lanList[index]['name']),
                                      ],
                                    ),
                                  ),
                                )),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    lanList[selectedLang]['title'],
                    // 'Mirror respects your privacy. Therefore we do not collect or store your contact history. this feature only helps to remind for your leads.',
                    textAlign: TextAlign.left,
                    style: AppTextStyle.regular16,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () {
                        isSwitched = val;
                        StorageManager.setBoolValue(
                            key: 'isCallLogHide', value: val);
                        setstate(() {});
                        setState(() {});
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 40),
                        decoration: BoxDecoration(
                          color: AppColors.appColors,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: const Text(
                          'OK',
                          textScaleFactor: 1.0,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }
}
