// ignore_for_file: must_be_immutable, library_private_types_in_public_api

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:defenders/config/theme/app_colors.dart';
import 'package:defenders/config/theme/app_text_style.dart';
import 'package:defenders/constants/app_sizes.dart';
import 'package:defenders/model/home_model/rank_details_count_model.dart';

class HomeTabel extends StatelessWidget {
  final String tabelName;
  final List<Silver> silverDetailsResponse;
  final int rank;
  const HomeTabel(
      {super.key,
      required this.rank,
      required this.tabelName,
      required this.silverDetailsResponse});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      color: const Color(0xFFF3FBFF),
      height: (silverDetailsResponse.length > 5
              ? 5
              : silverDetailsResponse.length) *
          70,
      child: silverDetailsResponse.isNotEmpty
          ? ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: silverDetailsResponse.length > 5
                  ? 5
                  : silverDetailsResponse.length,
              padding: EdgeInsets.zero,
              itemBuilder: ((context, index) {
                return Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  padding: const EdgeInsets.all(1),
                  child: InnerShadow(
                      blur: 5,
                      color: Colors.grey.withOpacity(0.5),
                      offset: const Offset(5, 5),
                      child: SilverDetails(
                        usermrid: silverDetailsResponse[index].mlmId.toString(),
                        date: DateFormat.yMd().format(DateTime.parse(
                            silverDetailsResponse[index]
                                .achiveDate
                                .toString())),
                        address:
                            silverDetailsResponse[index].address.toString(),
                        name: silverDetailsResponse[index].name.toString(),
                        index: (rank - index).toString(),
                        state: silverDetailsResponse[index].address.toString(),
                      )
                      // Container(
                      //   decoration: const BoxDecoration(
                      //     borderRadius: BorderRadius.all(Radius.circular(8)),
                      //     color: Color(0xFFE9EFEC),
                      //   ),
                      //   height: 100,
                      // ),
                      ),
                );
                // ListTile(
                //   title: SilverDetails(
                //     usermrid: silverDetailsResponse[index].mlmId.toString(),
                //     // date: DateFormat.yMd().format(DateTime.parse(
                //     //     silverDetailsResponse.userCreatedOn.toString())),
                //     name: silverDetailsResponse[index].name.toString(),
                //     index: (index + 1).toString(),
                //     state: silverDetailsResponse[index].address.toString(),
                //   ),
                // );
              }),
            )
          : Center(
              child: Text(
                'No Diamond member',
                style: AppTextStyle.semiBold18,
              ),
            ),
    );
  }
}

class SilverDetails extends StatelessWidget {
  const SilverDetails(
      {super.key,
      required this.usermrid,
      required this.date,
      required this.name,
      required this.address,
      required this.index,
      required this.state});
  final String usermrid;
  final String date;
  final String name;
  final String address;
  final String index;
  final String state;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 63,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xFFE7E7E7))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text('$index.'),
          ),
          const SizedBox(
            width: AppSizes.size10,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  usermrid,
                  style: const TextStyle(
                      color: AppColors.appColors,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  date,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  name,
                  maxLines: 1,
                  textAlign: TextAlign.end,
                  style: const TextStyle(
                      // color: Color.fromARGB(255, 255, 128, 0),
                      fontWeight: FontWeight.w600),
                ),
                if (address != "null")
                  Text(
                    address,
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w600),
                  ),
              ],
            ),
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
    );
  }
}

class InnerShadow extends SingleChildRenderObjectWidget {
  const InnerShadow({
    super.key,
    this.blur = 10,
    this.color = Colors.black38,
    this.offset = const Offset(10, 10),
    super.child,
  });

  final double blur;
  final Color color;
  final Offset offset;

  @override
  RenderObject createRenderObject(BuildContext context) {
    final _RenderInnerShadow renderObject = _RenderInnerShadow();
    updateRenderObject(context, renderObject);
    return renderObject;
  }

  @override
  void updateRenderObject(
      BuildContext context, _RenderInnerShadow renderObject) {
    renderObject
      ..color = color
      ..blur = blur
      ..dx = offset.dx
      ..dy = offset.dy;
  }
}

class _RenderInnerShadow extends RenderProxyBox {
  double? blur;
  Color? color;
  double? dx;
  double? dy;

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child == null) return;

    final Rect rectOuter = offset & size;
    final Rect rectInner = Rect.fromLTWH(
      offset.dx,
      offset.dy,
      size.width - dx!,
      size.height - dy!,
    );
    final Canvas canvas = context.canvas..saveLayer(rectOuter, Paint());
    context.paintChild(child!, offset);
    final Paint shadowPaint = Paint()
      ..blendMode = BlendMode.srcATop
      ..imageFilter = ImageFilter.blur(sigmaX: blur!, sigmaY: blur!)
      ..colorFilter = ColorFilter.mode(color!, BlendMode.srcOut);

    canvas
      ..saveLayer(rectOuter, shadowPaint)
      ..saveLayer(rectInner, Paint())
      ..translate(dx!, dy!);
    context.paintChild(child!, offset);
    context.canvas
      ..restore()
      ..restore()
      ..restore();
  }
}
