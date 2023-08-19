// import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:awad_nahas/core/styles/app_style.dart';
// import 'package:awad_nahas/core/utils/small_fun.dart';
// import 'package:awad_nahas/features/categories/data/models/categories_model.dart';
// import 'package:awad_nahas/features/products/presentation/screens/products_list.dart';
// import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
// import 'package:awad_nahas/features/shared_widgets/global_app_image.dart';


// class SearchCategoryCard extends StatelessWidget {
//   final CategoriesModel item;
//   const SearchCategoryCard({Key? key,required this.item}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: ()=> Util.pushPage(ProductListScreen(catID: item.id.toString()), context),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           CircleAvatar(
//             backgroundColor: DMUtil.getBCC(),
//             radius: 25.w,
//             child: ImageWidget(imgUrl: item.imgPath,fit: BoxFit.contain,width: 30,height:  46,),
//           ),
//           SizedBox(
//             height: 38.h,
//             width: item.title.length>10&&(!item.title.toString().contains(" "))?65.w:50.w,
//             child: CustomText(
//               text: item.title,
//               fontSize: AppStyle.small.sp,
//               alignCenter: true,
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
