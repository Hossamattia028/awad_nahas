import 'package:awad_nahas/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:awad_nahas/features/cart/domain/entities/cart_entity.dart';
import 'package:awad_nahas/features/cart/domain/repositories/cart_repository.dart';
import 'package:awad_nahas/features/order/data/models/coupon_model.dart';

class GetAllCartListUseCase{
  final CartRepository cartRepository;
  const GetAllCartListUseCase({required this.cartRepository});

  Future<Either<Failure,CartEntity>> call() async{
    return await cartRepository.getAllCartList();
  }
}

class AddCartItemUseCase{
  final CartRepository cartRepository;
  const AddCartItemUseCase({required this.cartRepository});

  Future<Either<Failure,bool>> call({required Map<String,dynamic> data}) async{
    return await cartRepository.addCartItem(data: data);
  }
}

class RemoveCartItemUseCase{
  final CartRepository cartRepository;
  const RemoveCartItemUseCase({required this.cartRepository});

  Future<Either<Failure,bool>> call({required int productID,}) async{
    return await cartRepository.removeCartItem(productID: productID,);
  }
}



class ApplyCouponUseCase{
  CartRepository cartRepository;
  ApplyCouponUseCase({required this.cartRepository});

  Future<Either<Failure,CouponModel>> call({required Map<String,dynamic> dataSet,}) async{
    return await cartRepository.applyCoupon(dataSet: dataSet,);
  }
}