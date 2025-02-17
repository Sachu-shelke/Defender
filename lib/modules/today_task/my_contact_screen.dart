import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:defenders/config/manager/global_singleton.dart';
import 'package:defenders/config/theme/app_colors.dart';
import 'package:defenders/config/theme/app_text_style.dart';
import 'package:defenders/utils/get_user_locarion.dart';
import 'package:defenders/widget/appbars/custom_app_bar.dart';

class MyContactScreen extends StatefulWidget {
  const MyContactScreen({super.key});

  @override
  State<MyContactScreen> createState() => _MyContactScreenState();
}

class _MyContactScreenState extends State<MyContactScreen> {
  // List contactMobileNumberList = [];
  List<List<Contact>> parts = [];

  int selectedListIndex = 0;
  // ScrollController _controller = ScrollController();
  final int _currentIndex = 0;

  @override
  void initState() {
    getUserContactList();

    super.initState();
  }

  @override
  void dispose() {
    // Dispose the ScrollController

    super.dispose();
  }

  getUserContactList() async {
    Future.delayed(const Duration(seconds: 0), () async {
      await UserContact().getLatestContact(() {
        setState(() {});
      }, context, 0);
      setState(() {});
      getContactListPart();
    });
  }

  getContactListPart() {
    // List<int> a = [1, 5, 4, 25, 58, 96, 58, 78, 89, 100];
    int numberOfParts = 250;

    // Calculate the length of each part
    int partLength = (GlobalSingleton.contact.length / numberOfParts).ceil();

    // Split the list into parts
    for (int i = 0; i < partLength; i++) {
      int start = i * numberOfParts;
      int end = (i + 1) * numberOfParts;
      parts.add(GlobalSingleton.contact.sublist(
          start,
          end > GlobalSingleton.contact.length
              ? GlobalSingleton.contact.length
              : end));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'My Contact',
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () async {
                String contacts = '';

                for (var i = 0; i < parts[selectedListIndex].length; i++) {
                  if ((parts[selectedListIndex][i].phones != null &&
                      parts[selectedListIndex][i].phones!.isNotEmpty &&
                      parts[selectedListIndex][i]
                              .phones![0]
                              .value
                              .toString()
                              .length >
                          10)) {
                    contacts +=
                        ("91${parts[selectedListIndex][i].phones![0].value.toString().replaceAll(" ", "").replaceFirst("+91", "").replaceFirst("+", "")}\n");
                  }
                }
                await Clipboard.setData(ClipboardData(text: contacts));
                Fluttertoast.showToast(msg: "contacts copied to clipboard");
              },
              child: const Icon(Icons.copy),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 60,
            child: ListView.builder(
                itemCount: parts.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      selectedListIndex = index;
                      setState(() {});
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: selectedListIndex != index
                              ? AppColors.appColors
                              : Colors.transparent,
                        ),
                        color: selectedListIndex == index
                            ? AppColors.appColors
                            : null,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "Conatct List ${index + 1}",
                        style: AppTextStyle.semiBold16.copyWith(
                            color: selectedListIndex != index
                                ? AppColors.appColors
                                : AppColors.whiteColor),
                      ),
                    ),
                  );
                }),
          ),
          if (parts.isNotEmpty)
            Expanded(
              child: ListView.builder(
                  itemCount: parts[selectedListIndex].length,
                  itemBuilder: (context, index) {
                    // if ((parts[selectedListIndex].phones != null &&
                    //     parts[selectedListIndex].phones!.isNotEmpty &&
                    //     parts[selectedListIndex]
                    //             .phones![0]
                    //             .value
                    //             .toString()
                    //             .length >
                    //         10)) {
                    //   if (!contactMobileNumberList.contains(GlobalSingleton
                    //       .contact[index].phones![0].value
                    //       .toString()
                    //       .replaceAll(" ", "")
                    //       .replaceFirst("+", ""))) {
                    //     contactMobileNumberList
                    //         .add(parts[selectedListIndex].phones![0].value);
                    //   }
                    // }

                    return (parts[selectedListIndex][index].phones != null &&
                            parts[selectedListIndex][index]
                                .phones!
                                .isNotEmpty &&
                            parts[selectedListIndex][index]
                                    .phones![0]
                                    .value
                                    .toString()
                                    .length >
                                10)
                        ? ListTile(
                            title: Text(parts[selectedListIndex][index]
                                .displayName
                                .toString()),
                            subtitle: Text(parts[selectedListIndex][index]
                                .phones![0]
                                .value
                                .toString()
                                .replaceAll(" ", "")
                                .replaceFirst("+91", "")
                                .replaceFirst("+", "")),
                            // trailing: InkWell(
                            //   onTap: () async {
                            //     String sss = GlobalSingleton
                            //         .contact[index].phones![0].value
                            //         .toString()
                            //         .replaceAll(" ", "")
                            //         .replaceFirst("+", "");
                            //     await Clipboard.setData(ClipboardData(text: sss));
                            //   },
                            //   child: const Icon(Icons.copy),
                            // ),
                          )
                        : const SizedBox();
                  }),
            ),
        ],
      ),
    );
  }
}


          // Expanded(
          //   child: ListView.builder(
          //       itemCount: parts[0].length,
          //       controller: _controller,
          //       itemBuilder: (context, index) {
          //         if ((GlobalSingleton.contact[index].phones != null &&
          //             GlobalSingleton.contact[index].phones!.isNotEmpty &&
          //             GlobalSingleton.contact[index].phones![0].value
          //                     .toString()
          //                     .length >
          //                 10)) {
          //           if (!contactMobileNumberList.contains(GlobalSingleton
          //               .contact[index].phones![0].value
          //               .toString()
          //               .replaceAll(" ", "")
          //               .replaceFirst("+", ""))) {
          //             contactMobileNumberList
          //                 .add(GlobalSingleton.contact[index].phones![0].value);
          //           }
          //         }

          //         return (GlobalSingleton.contact[index].phones != null &&
          //                 GlobalSingleton.contact[index].phones!.isNotEmpty &&
          //                 GlobalSingleton.contact[index].phones![0].value
          //                         .toString()
          //                         .length >
          //                     10)
          //             ? ListTile(
          //                 title: Text(GlobalSingleton.contact[index].displayName
          //                     .toString()),
          //                 subtitle: Text(GlobalSingleton
          //                     .contact[index].phones![0].value
          //                     .toString()),
          //                 // trailing: InkWell(
          //                 //   onTap: () async {
          //                 //     String sss = GlobalSingleton
          //                 //         .contact[index].phones![0].value
          //                 //         .toString()
          //                 //         .replaceAll(" ", "")
          //                 //         .replaceFirst("+", "");
          //                 //     await Clipboard.setData(ClipboardData(text: sss));
          //                 //   },
          //                 //   child: const Icon(Icons.copy),
          //                 // ),
          //               )
          //             : const SizedBox();
          //       }),
          // ),