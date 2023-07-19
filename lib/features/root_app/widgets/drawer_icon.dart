import 'package:flutter/material.dart';

class DrawerIcon extends StatelessWidget {
  final BuildContext ctx;
  const DrawerIcon({Key? key,required this.ctx}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: ()=> Scaffold.of(ctx).openEndDrawer(), child: const Icon(Icons.menu,color: Colors.white,));
  }
}
