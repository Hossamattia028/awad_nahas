import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/styles/my_fonts.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/features/categories/data/data_sources/category_remote_data_source.dart';
import 'package:awad_nahas/features/categories/domain/entities/categories_entity.dart';
import 'package:awad_nahas/features/categories/presentation/bloc/cateogries_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';



class AboutBrand extends StatefulWidget {
  final CategoriesEntity itemBrand;
  const AboutBrand({Key? key,required this.itemBrand}) : super(key: key);

  @override
  State<AboutBrand> createState() => _AboutBrandState();
}

class _AboutBrandState extends State<AboutBrand> {

  late CategoriesBloc categoriesBloc;
  @override
  void initState() {
    categoriesBloc = CategoriesBloc.get(context);
    _getDesc();
    super.initState();
  }

  _getDesc()async {
    categoriesBloc.desc = await CategoryRemoteDataSource.getBrandDesc(id: widget.itemBrand.slug.toString());
    if(categoriesBloc.desc != ""){
      if(mounted)setState(() {});
    }
    // String desc = widget.itemBrand.desc.split('<ul>').last.split('</ul>').first.toString();
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(10.w),
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          const SizedBox(height: 10,),
          // Html(
          //     style: {
          //       'body': Style(
          //           color: DMUtil.getD2C()),
          //       'p': Style(
          //           color: DMUtil.getPC())
          //     },
          //     data: desc )

          categoriesBloc.desc.trim()==""?
          CircularProgressIndicator(color: DMUtil.getRED(),):
          HtmlWidget(
            '''
      ${categoriesBloc.desc}
      ''',
            customStylesBuilder: (element) {
              if (element.classes.contains('name')) {
                return {'color': 'red'};
              }
              return null;
            },
            textStyle: TextStyle(
                fontFamily: primaryFontReg,
                color: DMUtil.getD2C(),
                fontSize: AppStyle.small.sp,
                height: 1.3
            ),
          ),
          SizedBox(height: 100.w,),
        ],
      ),
    );
  }
}
