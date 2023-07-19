import 'package:awad_nahas/core/strings/enum/order_enum.dart';
import 'package:awad_nahas/core/styles/my_colors.dart';
import 'package:awad_nahas/core/styles/my_fonts.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/order/data/models/order_model.dart';
import 'package:awad_nahas/features/order/presentation/bloc/order_event.dart';
import 'package:awad_nahas/features/order/presentation/screens/order_details.dart';
import 'package:awad_nahas/features/order/presentation/widgets/order_status_widgets/assigned_image.dart';
import 'package:awad_nahas/features/order/presentation/widgets/order_status_widgets/delivered_widget.dart';
import 'package:awad_nahas/features/order/presentation/widgets/order_status_widgets/pending_title.dart';
import 'package:awad_nahas/features/shared_widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:awad_nahas/core/styles/app_style.dart';
import 'package:awad_nahas/features/shared_widgets/custom_text.dart';
import 'package:awad_nahas/features/order/presentation/bloc/order_bloc.dart';
import 'package:awad_nahas/features/order/presentation/bloc/order_state.dart';



class OrderList extends StatelessWidget {
  final int index;
  const OrderList({Key? key,required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => _buildRefresh(context),
      color: kPrimary,
      child: BlocBuilder<OrderBloc,OrderState>(
        builder: (ctx,state){
          var bloc = OrderBloc.get(ctx);
          bloc.add(ChangeCurrentOrdersEvent(type: index==0?ORDER_STATUS.PENDING:index==1?ORDER_STATUS.ASSIGNED:ORDER_STATUS.DELIVERED,index: index,));
          var list = bloc.getCurrentOrdersByType();
          if(state is OrderLoadingState) return const Center(child: CircularProgressIndicator(),);
          return Scrollbar(
            child: ListView.separated(
                padding: EdgeInsets.symmetric(vertical: 15.w, horizontal: 20.w),
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  var item = list[index];
                  return Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Align(
                          child: CustomText(
                            text: "${translate("order.code")}: ${item.orderId}",
                            color: Colors.black,
                            fontSize: AppStyle.small.sp,
                            fontFamily: primaryFontBold,
                          ),
                        ),
                        const SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Flexible(
                              flex: 4,
                              child: Center(
                                child: CustomButton(
                                  height: 30.h,
                                  width: 105.w,
                                  circular: 14,
                                  widget: CustomText(
                                    text: translate("order.order_details"),
                                    color: Colors.white,
                                    fontSize: AppStyle.small.sp+2,
                                    fontFamily: primaryFontBold,
                                  ),
                                  color: kPrimary,
                                  onPressed: (){
                                    OrderBloc.get(context).add(SetCurrentOrderEvent(order: item));
                                    Util.pushPage(OrderDetailsScreen(data: item,), context);
                                  },
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 2,
                              child: Stack(
                                children: [
                                  if(OrderModel.getStatusViewCheck(item.status.toString())==ORDER_STATUS.PENDING)...[
                                    const PendingTitleWidget(isSmall: true,),
                                  ]else if(OrderModel.getStatusViewCheck(item.status.toString())==ORDER_STATUS.ASSIGNED)...[
                                    const AssignedImageWidget(isSmall: true,),
                                  ]else if(OrderModel.getStatusViewCheck(item.status.toString())==ORDER_STATUS.DELIVERED)...[
                                    const DeliveredImageWidget(isSmall: true,),
                                  ],
                                ],
                              )

                            ),
                          ],
                        ),

                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(height: 15),
                itemCount: list.length),
          );
        },
      ),
    );
  }

  Future<void> _buildRefresh(BuildContext context) async {
    OrderBloc.get(context).add(const FetchAllOrderEvent());
  }
}
