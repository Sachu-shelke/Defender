import 'package:flutter/material.dart';
import 'package:defenders/constants/common_style.dart';
import 'package:defenders/widget/appbars/custom_app_bar.dart';

class DocumentsScreen extends StatefulWidget {
  const DocumentsScreen({super.key});

  @override
  State<DocumentsScreen> createState() => _DocumentsScreenState();
}

class _DocumentsScreenState extends State<DocumentsScreen> {
  final List _documentList = [
    {
      "title": "Id Card",
      "onPress": () {
        // getIt<AppRouter>().push(const IdCardRoute());
      },
    },
    {
      "title": " Prime Invoice",
      "onPress": () {
        // getIt<AppRouter>().push(const InVoiceRoute());
      },
    },
    {
      "title": "Insurance Cover",
      "onPress": () {
        // getIt<AppRouter>().push(const InsuranceCoverRoute());
      },
    },
    {
      "title": "Rank Certificate",
      "onPress": () {
        // getIt<AppRouter>().push(const RankCertificateRoute());
      },
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Documents'),
      body: ListView.builder(
        itemCount: _documentList.length,
        itemBuilder: (BuildContext context, int i) {
          return Padding(
            padding:
                const EdgeInsets.only(top: 15, right: 10, left: 10, bottom: 5),
            child: Container(
              decoration: CommonStyleDecoration.boxDecoration(),
              child: DocumentIconWidget(
                title: _documentList[i]['title'],
                data: const [],
                onPress: _documentList[i]['onPress'],
              ),
            ),
          );
        },
      ),
    );
  }
}

class DocumentIconWidget extends StatelessWidget {
  final String? title;
  final Function()? onPress;
  final List<dynamic>? data;
  // ignore: use_key_in_widget_constructors
  const DocumentIconWidget({
    required this.title,
    this.onPress,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onPress,
        child: ListTile(
          leading: const Icon(Icons.download),
          title: Text(
            title!,
            textScaleFactor: 1.0,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          trailing: const Icon(Icons.chevron_right),
        ));
  }
}
