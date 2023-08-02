
import 'package:awad_nahas/core/strings/enum/order_enum.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/authentication/domain/entities/user_entity.dart';
import 'package:awad_nahas/features/order/data/models/confirm_order_data.dart';
import 'package:awad_nahas/features/order/data/models/issue_model.dart';
import 'package:awad_nahas/features/order/data/models/order_model.dart';
import 'package:awad_nahas/features/order/domain/use_cases/get_all_order_usecase.dart';
import 'package:awad_nahas/features/order/domain/use_cases/update_order_usecase.dart';
import 'package:awad_nahas/features/order/presentation/bloc/order_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:awad_nahas/features/order/domain/entities/order.dart';
import 'package:awad_nahas/features/order/domain/use_cases/add_order_usecase.dart';
import 'package:awad_nahas/features/order/presentation/bloc/order_state.dart';



class OrderBloc extends Bloc<OrderEvent,OrderState>{

  String currentCityID = "Jeddah";
  /// this city list can be assign the order on it
  List<String> citiesList = [
    "Jeddah",
    "Riyadh",
    "Elkhobar",
  ];

  List<Orders> orderList = [
    Orders(items: [
      OrderItem(title: "Smeg Dolce & Gabbana 2 Slice Toaster 50’s Retro Style", price: 200, qty: "2"),
      OrderItem(title: "Smeg 90cm Freestanding Gas Hob 6 Burners & Full Electric Oven, Yellow", price: 200, qty: "2"),
    ])
  ];
  List<Orders> orderFilteredList = [
    Orders(items: [
      OrderItem(title: "Smeg Dolce & Gabbana 2 Slice Toaster 50’s Retro Style", price: 200, qty: "2"),
      OrderItem(title: "Smeg 90cm Freestanding Gas Hob 6 Burners & Full Electric Oven, Yellow", price: 200, qty: "2"),
    ])
  ];
  // List<Orders> driverOrdersList = [];
  int totalPrice = 0;


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
    orderFilteredList.clear();
    if(event.dateTime!=null){
      orderFilteredList = orderList.where((element) =>  Util.formatToDayFullMonthYear(DateTime.parse(element.date.toString())) == Util.formatToDayFullMonthYear(event.dateTime!)).toList();
    }
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
    List<Orders> list = [];
    return list.where((element) => OrderModel.getStatusViewCheck(element.status.toString()) == currentOrdersType).toList();
  }

  getAllOrder(emit)async{
    emit(OrderLoadingState());
    // try{
      var res = await getAllOrderUseCase();
      res.fold((l) {
        emit(OrderErrorState(errors: l.toString()));
      },(data) {
        // orderList = data.reversed.toList();
        emit(OrderSuccessfullyState());
      });
    // }catch(e){
    //   emit(OrderErrorState(errors: e.toString()));
    // }
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
    if(currentOrder==null)return;
    emit(OrderLoadingState());
    try{
      var res = await addOrderUseCase(data: collectOrderData());
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
    // try{
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
    // }catch(e){
    //   debugPrint("updateOrderError: $e");
    //   emit(OrderErrorState(errors: e.toString()));
    // }
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


  Map<String, dynamic>  collectOrderData(){
    var data = {
      'wordpress_order_code' : currentOrder!.code,
      'manager_id' : Util.getUserID(),
      'city' : currentCityID,
      'delivery_status' : 'PENDING',
      'grand_total' : currentOrder!.totalPrice,
      'customer_id' : currentOrder!.userId,
      'customer_email' : currentOrder!.userEmail,
      'customer_phone' : currentOrder!.userPhone,
      'customer_name' : currentOrder!.userName,
    };
    return data;
  }



  List<IssueModel> issueList = [
    IssueModel(id: 0, txt: "first issue"),
    IssueModel(id: 1, txt: "second  issue"),
  ];


}