import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

class ProductDescriptionWidget extends StatelessWidget {
  final String txt;
  const ProductDescriptionWidget({Key? key, required this.txt}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 5),
      // physics: const NeverScrollableScrollPhysics(),
      child: HtmlWidget(
        '''
        $txt
        ''',
        customStylesBuilder: (element) {
          if (element.classes.contains('name')) {
            return {'color': 'red'};
          }
          return null;
        },
        textStyle: TextStyle(color: DMUtil.getD2C()),
      ),
    );
  }
}
