import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/features/root_app/bloc/root_bloc.dart';
import 'package:awad_nahas/features/root_app/bloc/root_state.dart';
import 'package:awad_nahas/features/products/presentation/widgets/product_card.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';


class SearchProductList extends StatelessWidget {
  const SearchProductList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RootBloc,RootState>(
      builder: (ctx,state){
        var bloc = RootBloc.get(ctx);
        if(bloc.productSearchList.isEmpty)return const SizedBox.shrink();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: translate("search.product"),
              color: DMUtil.getDC(),
              fontSize: AppStyle.average.sp,
            ),
            ListView.separated(
              itemCount: bloc.productSearchList.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                var item = bloc.productSearchList[index];
                return ProductCard(item: item);
              },
              separatorBuilder: (context, index) => const SizedBox(height: 10),
            ),
          ],
        );
      },
    );
  }
}
