import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:defenders/config/theme/app_colors.dart';
import 'package:defenders/constants/method/common_method.dart';
import 'package:defenders/model/banner_model/banner_model.dart';
import 'package:defenders/widget/shimmer_widget/shimmer_container.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Banners extends StatelessWidget {
  final List<BannerList>? model;
  final List? localModel;
  const Banners({super.key, this.localModel, this.model});

  @override
  Widget build(BuildContext context) {
    if (model != null || localModel != null) {
      return BannerNode(
        model: model ?? [],
        localModel: localModel,
      );
    } else {
      return const ShimmerContainer(
        child: Center(),
        // child: SmallLoading(),
      );
    }
  }
}

class BannerNode extends StatefulWidget {
  final List<BannerList> model;
  final List? localModel;
  const BannerNode({
    super.key,
    required this.model,
    this.localModel,
  });

  @override
  State<BannerNode> createState() => _BannerNodeState();
}

class _BannerNodeState extends State<BannerNode> {
  int intIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: widget.localModel != null
              ? widget.localModel!.length
              : widget.model.length,
          itemBuilder:
              (BuildContext context, int itemIndex, int pageViewIndex) {
            return InkWell(
              onTap: () {},
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: widget.localModel != null
                    ? Image.asset(
                        widget.localModel![itemIndex],
                        fit: BoxFit.fill,
                      )
                    : Image.network(
                        widget.model[itemIndex].img!,
                        fit: BoxFit.fill,
                      ),
              ),
            );
          },
          options: CommonMethod.carouselOptions(onChanged: (index, page) {
            intIndex = index;
            setState(() {});
          }),
        ),
        const SizedBox(
          height: 10,
        ),
        Align(
          alignment: Alignment.center,
          child: AnimatedSmoothIndicator(
            activeIndex: intIndex,
            count: widget.model.length,
            effect: const ExpandingDotsEffect(
                dotWidth: 10.0,
                dotHeight: 10.0,
                activeDotColor: AppColors.secoundColors),
          ),
        ),
      ],
    );
  }
}

// class LocalStorageBanners extends StatelessWidget {
//   final List<BannerList>? model;
//   // final List<shooping.BannerList>? shoopingModel;
//   final double? size;
//   const LocalStorageBanners({Key? key, this.size, this.model})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     if (model != null) {
//       return LocalStorageBannerNode(
//         model: model ?? [],
//       );
//     } else {
//       return ShimmerContainer(
//         child: Container(
//           height: 160,
//           color: Colors.yellow,
//           width: MediaQuery.of(context).size.width,
//         ),
//       );
//     }
//   }
// }

// class LocalStorageBannerNode extends StatefulWidget {
//   final List<BannerList> model;
//   final double? size;
//   const LocalStorageBannerNode({
//     Key? key,
//     required this.model,
//     this.size,
//   }) : super(key: key);

//   @override
//   State<LocalStorageBannerNode> createState() => _LocalStorageBannerNodeState();
// }

// class _LocalStorageBannerNodeState extends State<LocalStorageBannerNode> {
//   int intIndex = 0;
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         CarouselSlider.builder(
//           itemCount: widget.model.length,
//           itemBuilder:
//               (BuildContext context, int itemIndex, int pageViewIndex) {
//             Uint8List? uint8list;
//             List dynamicList = jsonDecode(widget.model[itemIndex].img!);
//             List<int> intList = dynamicList.cast<int>().toList();
//             uint8list = Uint8List.fromList(intList);
//             return InkWell(
//               onTap: () {},
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(10),
//                 child: Image.memory(uint8list),
//               ),
//             );
//           },
//           options: CommonMethod.carouselOptions(
//               size: widget.size ?? 160,
//               onChanged: (index, page) {
//                 intIndex = index;
//                 setState(() {});
//               }),
//         ),
//         const SizedBox(
//           height: 10,
//         ),
//         Align(
//           alignment: Alignment.center,
//           child: AnimatedSmoothIndicator(
//             activeIndex: intIndex,
//             count: widget.model.length,
//             effect: const ExpandingDotsEffect(
//               dotWidth: 10.0,
//               dotHeight: 10.0,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
