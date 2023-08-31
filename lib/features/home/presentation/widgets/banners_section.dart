
import 'package:awad_nahas/features/home/presentation/widgets/small_banner.dart';
import 'package:awad_nahas/features/home/presentation/widgets/vertical_banner.dart';
import 'package:flutter/material.dart';


class BannersSection extends StatelessWidget {
  const BannersSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding:  EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          VerticalBannerWidget(),
          SizedBox(width: 10,),
          Expanded(
            child: Column(
              children: [
                SmallBannerWidget(position: "top",),
                SizedBox(height: 10,),
                SmallBannerWidget(position: "button",),
             ],
           ),
         ),

        ],
      ),
    );
  }
}
