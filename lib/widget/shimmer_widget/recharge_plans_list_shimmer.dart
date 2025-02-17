// import 'package:flutter/material.dart';

// class RechargePlansListShimmer extends StatelessWidget {
//   const RechargePlansListShimmer({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//         itemCount: 10,
//         shrinkWrap: true,
//         itemBuilder: (context, index) {
//           return RechargePlansListNodeContainer(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const TextShimmer(
//                   height: 32,
//                   width: 60,
//                   radius: 6,
//                 ),
//                 SizedBox(height: 20.h),
//                 const TextShimmer(),
//                 SizedBox(height: 10.h),
//                 const TextShimmer(width: double.infinity),
//                 SizedBox(height: 4.h),
//                 const TextShimmer(width: 160)
//               ],
//             ),
//           );
//         });
//   }
// }
