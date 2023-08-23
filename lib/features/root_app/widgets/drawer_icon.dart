import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DrawerIcon extends StatelessWidget {
  final BuildContext ctx;
  final Color? color;
  const DrawerIcon({Key? key,required this.ctx,this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: ()=> Scaffold.of(ctx).openDrawer(), child: Icon(Icons.menu,color: color ?? DMUtil.getWC(),size: 28.w,));
  }
}
