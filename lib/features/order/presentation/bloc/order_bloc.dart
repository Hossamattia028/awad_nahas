
import 'package:awad_nahas/core/strings/enum/order_enum.dart';
import 'package:awad_nahas/core/strings/enum/payment_enum.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/features/locations/data/models/location_model.dart';
import 'package:awad_nahas/features/locations/domain/entities/location_entity.dart';
import 'package:awad_nahas/features/locations/presentation/bloc/locations_bloc.dart';
import 'package:awad_nahas/features/order/data/models/confirm_order_data.dart';
import 'package:awad_nahas/features/order/data/models/coupon_model.dart';
import 'package:awad_nahas/features/order/data/models/issue_model.dart';
import 'package:awad_nahas/features/order/data/models/order_model.dart';
import 'package:awad_nahas/features/order/domain/use_cases/get_all_order_usecase.dart';
import 'package:awad_nahas/features/order/domain/use_cases/update_order_usecase.dart';
import 'package:awad_nahas/features/order/presentation/bloc/order_event.dart';
import 'package:awad_nahas/features/products/domain/entities/products_entity.dart';
import 'package:awad_nahas/features/shared_widgets/snackbars_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:awad_nahas/features/order/domain/entities/order.dart';
import 'package:awad_nahas/features/order/domain/use_cases/add_order_usecase.dart';
import 'package:awad_nahas/features/order/presentation/bloc/order_state.dart';
import 'package:flutter_translate/flutter_translate.dart';



class OrderBloc extends Bloc<OrderEvent,OrderState>{
  List<Orders> orderList = [];

  AddOrderUseCase addOrderUseCase;
  GetAllOrderUseCase getAllOrderUseCase;
  // GetAllDriversOrdersUseCase getAllDriversOrdersUseCase;
  UpdateOrderUseCase updateOrderUseCase;

  OrderBloc({
    required this.addOrderUseCase,
    required this.getAllOrderUseCase,
    required this.updateOrderUseCase,
}) : super(OrderInitialState()) {

    on<FetchAllOrderEvent>((event, emit) async{
       await getAllOrder(emit);
       // await getAllDriversOrders(emit);
    });

    on<AddOrderEvent>((event, emit) async{
      await addNewOrder(event,emit);
      await getAllOrder(emit);
    });

    on<UpdateOrderEvent>((event, emit) async{
      await updateOrder(event,emit);
      await getAllOrder(emit);
    });

    on<CancelOrderEvent>((event, emit) async{
      await cancelOrder(event,emit);
      await getAllOrder(emit);
    });

    on<ChangeCurrentOrdersEvent>((event, emit) {
      changeOrdersType(event,emit);
    });

    on<SetCurrentOrderEvent>((event, emit) {
      setCurrentOrder(event,emit);
    });

    on<UpdateConfirmedOrder>((event, emit) {
      updateFile(event,emit);
    });

    on<FilterOrderByDate>((event, emit) {
      filterOrderByDate(event,emit);
    });


  }
  static OrderBloc get(BuildContext context) => BlocProvider.of(context);

  filterOrderByDate(FilterOrderByDate event, emit){
    emit(OrderLoadingState());

    emit(OrderSuccessfullyState());
  }


  ORDER_STATUS currentOrdersType = ORDER_STATUS.PENDING;
  int currentTapOrdersIndex = 0;
  changeOrdersType(ChangeCurrentOrdersEvent event, emit){
    emit(OrderLoadingState());
    currentOrdersType = event.type;
    currentTapOrdersIndex = event.index;
    emit(OrderSuccessfullyState());
  }

  List<Orders> getCurrentOrdersByType(){
    return orderList.where((element) => OrderModel.getStatusViewCheck(element.status.toString()) == currentOrdersType).toList();
  }

  getAllOrder(emit)async{
    emit(OrderLoadingState());
    try{
      var res = await getAllOrderUseCase();
      res.fold((l) {
        emit(OrderErrorState(errors: l.toString()));
      },(data) {
        orderList = data.reversed.toList();
        emit(OrderSuccessfullyState());
      });
    }catch(e){
      emit(OrderErrorState(errors: e.toString()));
    }
  }


  Orders? currentOrder;
  setCurrentOrder(SetCurrentOrderEvent event,emit){
    if(event.order==null)return;
    emit(OrderLoadingState());
    currentOrder = event.order;
    confirmOrderData = null;
    emit(OrderSuccessfullyState());
  }


  addNewOrder(AddOrderEvent event,emit)async{
    emit(OrderLoadingState());
    try{
      LocationEntity? currentLoc  = checkCurrentLocationAndReturnIt(event.context);
      if(currentLoc==null)return;
      var orderData = collectOrderData(cartList:event.list,totalPrice: event.totalPrice,locationEntity: currentLoc,payment: event.payment,
          apsData: event.apsData,amWalTransactionId: event.amWalTransactionId,couponModel: event.couponModel);
      var res = await addOrderUseCase(data: orderData);
      res.fold((l) {
        emit(OrderErrorState(errors: l.toString()));
      },(data) {
        if(data){
          emit(AssignOrderSuccessfullyState());
        }else{
          emit(const OrderErrorState(errors: "error when add order"));
        }
      });
    }catch(e){
      debugPrint("addNewOrderError: $e");
      emit(OrderErrorState(errors: e.toString()));
    }
  }

  ConfirmOrderData? confirmOrderData;
  updateFile(UpdateConfirmedOrder event,emit){
    emit(OrderLoadingState());
    confirmOrderData = event.confirmOrderData;
    emit(OrderSuccessfullyState());
  }

  updateOrder(UpdateOrderEvent event,emit)async{
    emit(OrderLoadingState());
    var res = await updateOrderUseCase(data: event.data,fileR: event.file);
    res.fold((l) {
      emit(OrderErrorState(errors: l.toString()));
    },(data) {
      if(data){
        emit(ConfirmOrderSuccessfullyState());
      }else{
        emit(const OrderErrorState(errors: "error when add order"));
      }
    });
  }

  cancelOrder(CancelOrderEvent event,emit)async{
    emit(OrderLoadingState());
    try{
      // OrderResponse res = await _orderClient.cancelOrder(event.id.toString());
      // if(res.state==true){
      //   emit(OrderSuccessfullyState());
      // }else{
      //   emit(OrderErrorState(errors: res.msg.toString()));
      // }
    }catch(e){
      debugPrint("addNewOrderError: $e");
      emit(OrderErrorState(errors: e.toString()));
    }
  }


  LocationEntity? checkCurrentLocationAndReturnIt(BuildContext context){
    var location = LocationsBloc.get(context).currentCheckOutLocation;
    if(location != null){
      return location;
    }else{
      SnackBarBuilder.showFeedBackMessage(context, translate("toast.location_mis"), DMUtil.getRED());
      return null;
    }
  }

  Map<String, dynamic>  collectOrderData({
    required List<ProductsEntity> cartList,
    required double totalPrice,
    required LocationEntity locationEntity,
    required PaymentOption payment,
    Map<String, dynamic>? apsData,
    String? amWalTransactionId,
    CouponModel? couponModel,
  }){
    List<Map<String,dynamic>> list = [];
    for(var i in cartList){
      list.add({
        "product_id": i.id,
        "product_title" :i.title,
        "product_sku" :  i.sku,
        "qty": i.quantity,
        "price": i.price
      });
    }
    var data = {
      "parent_id": "0",
      "num_items_sold" : list.length.toString(),
      "total_sales" : totalPrice.toString(),
      "tax_total": "0",
      "shipping_total" : "0",
      "net_total" : totalPrice.toString(),
      "returning_customer" : "0",
      "status" : "wc-processing",
      "address": LocationModel.toJsonLocal(locationEntity, "shipping"),
      "billing_address":LocationModel.toJsonLocal(locationEntity, "billing"),
      "items":list,
      "payment_method_title": payment.paymentEnum==PaymentEnum.AMWAL?"Quick Checkout":payment.paymentEnum.name.toString(),
      "payment_method": payment.isApplePay!=null&&payment.isApplePay==true?"aps_apple_pay":_paymentMethod(payment.paymentEnum),// aps_cc for credit or amazon_payment_services
      if(payment.paymentEnum==PaymentEnum.PAYFORT)"aps_data": apsData,
      if(payment.paymentEnum==PaymentEnum.AMWAL)"amwal_transaction_id": amWalTransactionId,
      if(couponModel!=null)"coupon":couponModel.code,
      if(couponModel!=null)"coupon_amount":couponModel.amount,
    };
    return data;
  }


  _paymentMethod(PaymentEnum payment){
    switch(payment){
      case PaymentEnum.PAYFORT:
        return "aps_cc";
      case PaymentEnum.CASH:
        return "cash";
      case PaymentEnum.TAMARA:
        return "tamara-gateway-pay-in-3";
      case PaymentEnum.AMWAL:
        return "amwalcheckout";
    }
  }


  List<IssueModel> issueList = [
    IssueModel(id: 0, txt: "first issue"),
    IssueModel(id: 1, txt: "second  issue"),
  ];


}