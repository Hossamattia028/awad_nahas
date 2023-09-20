import 'package:awad_nahas/core/styles/my_fonts.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/features/categories/domain/entities/categories_entity.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

class AboutBrand extends StatelessWidget {
  final CategoriesEntity itemBrand;
  const AboutBrand({Key? key,required this.itemBrand}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String desc = itemBrand.desc.split('<ul>').last.split('</ul>').first.toString();
    return SingleChildScrollView(
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

          HtmlWidget(
            '''
      $desc
      ''',
            customStylesBuilder: (element) {
              if (element.classes.contains('name')) {
                return {'color': 'red'};
              }
              return null;
            },
            textStyle: TextStyle(fontFamily: primaryFontReg,color: DMUtil.getD2C()),
          ),
        ],
      ),
    );
  }
}
