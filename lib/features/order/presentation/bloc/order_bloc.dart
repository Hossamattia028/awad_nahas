import 'package:awad_nahas/core/strings/enum/order_enum.dart';
import 'package:awad_nahas/core/strings/enum/payment_enum.dart';
import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:awad_nahas/features/locations/data/models/location_model.dart';
import 'package:awad_nahas/features/locations/domain/entities/location_entity.dart';
import 'package:awad_nahas/features/locations/presentation/bloc/locations_bloc.dart';
import 'package:awad_nahas/features/order/data/data_sources/order_remote_data_source.dart';
import 'package:awad_nahas/features/order/data/models/coupon_model.dart';
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

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  List<Orders> orderList = [];

  AddOrderUseCase addOrderUseCase;
  GetAllOrderUseCase getAllOrderUseCase;
  UpdateOrderUseCase updateOrderUseCase;

  OrderBloc({
    required this.addOrderUseCase,
    required this.getAllOrderUseCase,
    required this.updateOrderUseCase,
  }) : super(OrderInitialState()) {
    on<FetchAllOrderEvent>((event, emit) async {
      await getAllOrder(false, emit);
    });

    on<AddOrderEvent>((event, emit) async {
      await addNewOrder(event, emit);
      await getAllOrder(event.orderStatus == WCStatusKey.wc_processing, emit);
    });

    on<ChangeCurrentOrdersEvent>((event, emit) {
      changeOrdersType(event, emit);
    });

    on<AmwalCheckOpening>((event, emit) {
      checkAmwalOpenStatus(event, emit);
    });
  }
  static OrderBloc get(BuildContext context) => BlocProvider.of(context);

  bool amwalIsOpen = false;
  checkAmwalOpenStatus(AmwalCheckOpening event, emit) {
    emit(const AmwalLoadingChangeState());
    amwalIsOpen = event.isOpen;
    emit(const AmwalSuccessfullyChangeState());
  }

  ORDER_STATUS currentOrdersType = ORDER_STATUS.PENDING;
  int currentTapOrdersIndex = 0;
  changeOrdersType(ChangeCurrentOrdersEvent event, emit) {
    emit(OrderLoadingState());
    currentOrdersType = event.type;
    currentTapOrdersIndex = event.index;
    emit(OrderSuccessfullyState());
  }

  List<Orders> getCurrentOrdersByType() {
    return orderList
        .where((element) =>
            OrderModel.getStatusViewCheck(element.status.toString()) ==
            currentOrdersType)
        .toList();
  }

  getAllOrder(bool orderProcessing, emit) async {
    if (orderProcessing) emit(OrderLoadingState());
    try {
      var res = await getAllOrderUseCase();
      res.fold((l) {
        debugPrint("getAllOrder: $l");
        emit(OrderErrorState(errors: l.toString()));
      }, (data) {
        orderList = data.reversed.toList();
        emit(OrderSuccessfullyState());
      });
    } catch (e) {
      debugPrint("getAllOrder: $e");
      emit(OrderErrorState(errors: e.toString()));
    }
  }

  addNewOrder(AddOrderEvent event, emit) async {
    if (event.orderStatus == WCStatusKey.wc_processing)emit(OrderLoadingState());
    try {
      LocationEntity? currentLoc = checkCurrentLocationAndReturnIt(event.context);
      if (currentLoc == null) return;
      var orderData = collectOrderData(
          cartList: event.list,
          totalPrice: event.totalPrice,
          locationEntity: currentLoc,
          payment: event.payment,
          apsData: event.apsData,
          amWalTransactionId: event.amWalTransactionId,
          couponModel: event.couponModel,
          couponVal: event.couponVal,
          taxTotal: event.taxTotal,
          orderStatus: event.orderStatus);
      var res = await addOrderUseCase(data: orderData);
      res.fold((l) {
        debugPrint("addNewOrder: $l");
        emit(OrderErrorState(errors: l.toString()));
      }, (data) {
        if (data.state == true &&
            event.orderStatus == WCStatusKey.wc_processing) {
          emit(AssignOrderSuccessfullyState(payment: event.payment));
        } else if (data.state == true && event.orderStatus == WCStatusKey.wc_pending) {
          if(data.orderID.toString() != "null" && data.orderID.toString() != "-1")emit(SendPendingOrderSuccessfullyState(orderID: data.orderID.toString(), payment: event.payment));
        } else {
          emit(OrderErrorState(errors: translate("toast.oops")));
        }
      });
    } catch (e) {
      debugPrint("addNewOrderError: $e");
      emit(OrderErrorState(errors: e.toString()));
    }
  }

  cancelOrder(CancelOrderEvent event, emit) async {
    emit(OrderLoadingState());
    try {
      // OrderResponse res = await _orderClient.cancelOrder(event.id.toString());
      // if(res.state==true){
      //   emit(OrderSuccessfullyState());
      // }else{
      //   emit(OrderErrorState(errors: res.msg.toString()));
      // }
    } catch (e) {
      debugPrint("addNewOrderError: $e");
      emit(OrderErrorState(errors: e.toString()));
    }
  }

  LocationEntity? checkCurrentLocationAndReturnIt(BuildContext context) {
    var location = LocationsBloc.get(context).currentCheckOutLocation;
    if (location != null) {
      return location;
    } else {
      SnackBarBuilder.showFeedBackMessage(
          context, translate("toast.location_mis"), DMUtil.getRED());
      return null;
    }
  }

  Map<String, dynamic> collectOrderData(
      {required List<ProductsEntity> cartList,
      required double totalPrice,
      required LocationEntity locationEntity,
      required PaymentOption payment,
      Map<String, dynamic>? apsData,
      String? amWalTransactionId,
      CouponModel? couponModel,
      double? couponVal,
      double? taxTotal,
      String? orderStatus}) {
    List<Map<String, dynamic>> list = [];
    for (var i in cartList) {
      list.add({
        "product_id": i.id,
        "product_title": i.title,
        "product_sku": i.sku,
        "qty": i.quantity,
        "price": i.price,
        "net_price": i.priceWithoutTax,
      });
    }
    var data = {
      "parent_id": "0",
      "num_items_sold": list.length.toString(),
      "total_sales": totalPrice.toString(),
      "tax_total": taxTotal.toString(),
      "shipping_total": "0",
      "net_total": totalPrice.toString(),
      "returning_customer": "0",
      "status": orderStatus ?? "wc-pending",
      "address": LocationModel.toJsonLocal(locationEntity, "shipping"),
      "billing_address": LocationModel.toJsonLocal(locationEntity, "billing"),
      "items": list,
      "payment_method_title": payment.paymentEnum == PaymentEnum.AMWAL
          ? "Quick Checkout"
          : payment.paymentEnum.name.toString(),
      "payment_method": payment.isApplePay != null && payment.isApplePay == true
          ? "aps_apple_pay"
          : _paymentMethod(payment
              .paymentEnum), // aps_cc for credit or amazon_payment_services
      if (payment.paymentEnum == PaymentEnum.PAYFORT) "aps_data": apsData,
      if (payment.paymentEnum == PaymentEnum.AMWAL)"amwal_transaction_id": amWalTransactionId,
      if (couponModel != null) "coupon": couponModel.code,
      if (couponModel != null) "coupon_amount": couponVal,
    };
    return data;
  }

  _paymentMethod(PaymentEnum payment) {
    switch (payment) {
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

  /// save order as pending before payment process
  setPendingOrder(OrderBloc orderBloc, CartBloc cartBloc, BuildContext context,
      PaymentOption paymentOption) {
    orderBloc.add(AddOrderEvent(
        list: cartBloc.cartList,
        totalPrice: cartBloc.totalPrice,
        context: context,
        payment: paymentOption,
        couponModel: cartBloc.couponModel == null ||
                cartBloc.checkCouponValue(cartBloc.couponModel!) == false
            ? null
            : cartBloc.couponModel,
        couponVal: cartBloc.couponValue ?? 0,
        taxTotal: cartBloc.vatValue,
        orderStatus: WCStatusKey.wc_pending));
  }

  ///track order while user pay
  trackOrder(Map<String, dynamic> data) async {
    await OrderRemoteDataSource.trackOrder(data: data);
  }
}
