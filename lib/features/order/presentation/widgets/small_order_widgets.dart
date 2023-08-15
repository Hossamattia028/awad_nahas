import 'package:awad_nahas/core/strings/enum/order_enum.dart';
import 'package:awad_nahas/core/styles/my_colors.dart';
import 'package:awad_nahas/features/order/presentation/bloc/order_event.dart';
import 'package:awad_nahas/features/order/presentation/widgets/order_tracking_widgets/order_card_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
          bloc.add(ChangeCurrentOrdersEvent(type: index==0?ORDER_STATUS.PENDING:ORDER_STATUS.COMPLETED,index: index,));
          var list = bloc.getCurrentOrdersByType();
          // if(state is OrderLoadingState) return const Center(child: CircularProgressIndicator(),);
          return Scrollbar(
            child: ListView.separated(
                padding: EdgeInsets.symmetric(vertical: 15.w, horizontal: 20.w),
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  var item = list[index];
                  return OrderCardDetails(enableTracking: true,item: item,);
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
