import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/core/styles/my_fonts.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/features/order/presentation/bloc/order_bloc.dart';
import 'package:awad_nahas/features/order/presentation/bloc/order_state.dart';
import 'package:awad_nahas/features/order/presentation/widgets/top_status_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:awad_nahas/core/styles/my_colors.dart';
import 'package:awad_nahas/features/order/presentation/widgets/small_order_widgets.dart';



class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen>  with TickerProviderStateMixin{
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(vsync: this, length: 3);
    super.initState();
  }
  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DMUtil.getWC(),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 15.w, horizontal: 20.w),
            height: 40.h,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.horizontal(left: Radius.circular(20),right: Radius.circular(20))
            ),
            child: BlocBuilder<OrderBloc,OrderState>(
              builder: (ctx,state) {
                var bloc = OrderBloc.get(ctx);
                int currentTapOrdersIndex = bloc.currentTapOrdersIndex;
                return TabBar(
                  controller: tabController,
                  indicatorColor: Colors.transparent,
                  indicatorPadding: EdgeInsets.zero,
                  labelPadding: EdgeInsets.zero,
                  padding: EdgeInsets.zero,
                  labelColor: Colors.black,
                  tabs: [
                    SmallTapItem(title: translate("order.pending"),enable: currentTapOrdersIndex==0,),
                    SmallTapItem(title: translate("order.assigned_orders"),enable: currentTapOrdersIndex==1,),
                    SmallTapItem(title: translate("order.delivered_o"),enable: currentTapOrdersIndex==2,),
                  ],
                  labelStyle: const TextStyle(fontFamily: primaryFontSemiBold),
                );
              }
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: AppStyle.paddingFromTop.h+30),
            child: BlocBuilder<OrderBloc,OrderState>(
              builder: (ctx,state){
                return TabBarView(
                  controller: tabController,
                  children:  const [
                    OrderList(index: 0,),
                    OrderList(index: 1,),
                    OrderList(index: 2,),
                  ],
                );
              },
            )
          ),
        ],
      )
    );
  }
}


