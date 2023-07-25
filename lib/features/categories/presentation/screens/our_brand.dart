import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/categories/presentation/bloc/cateogries_bloc.dart';
import 'package:awad_nahas/features/categories/presentation/bloc/cateogries_event.dart';
import 'package:awad_nahas/features/categories/presentation/bloc/cateogries_state.dart';
import 'package:awad_nahas/features/categories/presentation/screens/brand_details.dart';
import 'package:awad_nahas/features/shared_widgets/global_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';

class OurBrandsScreen extends StatelessWidget {
  const OurBrandsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DMUtil.getWC(),
      appBar: GlobalAppBar(title: translate("app_bar.brands"),leadingIcon: const BackArrowButton()),
      body: BlocBuilder<CategoriesBloc,CategoriesState>(
        builder: (ctx,state){
          var bloc = CategoriesBloc.get(ctx);
          var list = bloc.brandList;
          return GridView.builder(
            itemCount: list.length,
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(vertical: 4.h,horizontal: 10.w),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10.h,
              mainAxisSpacing: 10.h,
              childAspectRatio: 1.2,
              mainAxisExtent: 170.h,
            ),
            itemBuilder: (BuildContext context, int index) {
              var item = list[index];
              return InkWell(
                onTap: (){
                  bloc.add(ChangeCurrentBrand(brandModel: item));
                  Util.pushPage(const BrandDetailsScreen(), context);
                },
                  child: Card(
                    elevation: 3,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Image.asset(item.imgPath),
                  )
              );
            },
          );
        },
      ),
    );
  }
}
