import 'package:flutter/cupertino.dart';

class AlignChildRow extends StatelessWidget {
  final Widget child;
  final bool isStart ;
  const AlignChildRow({Key? key,required this.child,this.isStart =true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isStart?MainAxisAlignment.start:MainAxisAlignment.end,
      children: [child],
    );
  }
}
