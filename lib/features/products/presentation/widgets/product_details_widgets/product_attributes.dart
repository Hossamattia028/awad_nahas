import 'package:awad_nahas/core/styles/my_fonts.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

class ProductAttributes extends StatelessWidget {
  final String txt;
  const ProductAttributes({Key? key,required this.txt}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HtmlWidget(
      '''
      $txt
      ''',
      customStylesBuilder: (element) {
        if (element.classes.contains('name')) {
          return {'color': 'red'};
        }
        return null;
      },
      textStyle: TextStyle(color: DMUtil.getD2C(),height: 2,fontFamily: primaryFontReg),
    );
  }
}
