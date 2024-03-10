import 'package:awad_nahas/features/cart/data/models/cart_model.dart';
import 'package:awad_nahas/features/cart/domain/entities/cart_entity.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_event.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_state.dart';
import 'package:awad_nahas/features/order/data/models/coupon_model.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../mockito_data/test_helper.mocks.dart';

void main() {
  late MockAddCartItemUseCase mockAddCartItemUseCase;
  late MockGetAllCartListUseCase mockGetAllCartListUseCase;
  late MockRemoveCartItemUseCase mockRemoveCartItemUseCase;
  late MockApplyCouponUseCase mockApplyCouponUseCase;

  late CartBloc cartBloc;

  setUp(() {
    mockAddCartItemUseCase = MockAddCartItemUseCase();
    mockGetAllCartListUseCase = MockGetAllCartListUseCase();
    mockRemoveCartItemUseCase = MockRemoveCartItemUseCase();
    mockApplyCouponUseCase = MockApplyCouponUseCase();

    cartBloc = CartBloc(
        getAllCartListUseCase: mockGetAllCartListUseCase,
        addCartItemUseCase: mockAddCartItemUseCase,
        removeCartItemUseCase: mockRemoveCartItemUseCase,
        applyCouponUseCase: mockApplyCouponUseCase);
  });

  const res = CartEntity(
      id: 1,
      sessionID: 231,
      sessionValue: [
        CartModelProducts(
            quantity: 1,
            productID: 2,
            price: 20,
            discount: 1,
            imgPath: "imgPath",
            title: "title",
            sku: "sku")
      ],
      total: 200);

  blocTest<CartBloc, CartState>('get all cart list ',
      build: () {
        when(mockGetAllCartListUseCase())
            .thenAnswer((_) async => const Right(res));
        return cartBloc;
      },
      act: (bloc) => bloc.add(const FetchAllCartEvent()),
      expect: () => const [
            CartLoadingState(),
            CartSuccessfullyState(),
          ],
      wait: const Duration(seconds: 2));

  var couponModelResponse = CouponModel(isPercent: true,amount: 10,code: "first10");
  
  blocTest<CartBloc, CartState>(
      'get all products from products bloc by [event]',
      build: () {
        when(mockApplyCouponUseCase(dataSet: {'code': "first10"}))
            .thenAnswer((_) async => Right(couponModelResponse));
        return cartBloc;
      },
      act: (bloc) => bloc.add(const ImplementCouponDiscountEvent(couponTxt: "first10")),
      expect: () => const [
            CouponLoadingState(),
            CouponSuccessfullyState(),
          ],
      wait: const Duration(seconds: 4));
}
