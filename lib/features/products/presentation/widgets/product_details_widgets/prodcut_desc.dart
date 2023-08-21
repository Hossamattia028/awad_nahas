import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

class ProductDescriptionWidget extends StatelessWidget {
  final String txt;
  const ProductDescriptionWidget({Key? key, required this.txt}) : super(key: key);

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
    );
  }
}
