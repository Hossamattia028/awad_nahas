
import 'package:awad_nahas/features/cart/data/data_sources/cart_remote_data_source.dart';
import 'package:awad_nahas/features/cart/domain/repositories/cart_repository.dart';
import 'package:awad_nahas/features/cart/domain/use_cases/cart_usecase.dart';
import 'package:flutter/material.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;


@GenerateMocks(
  [
    CartRepository,
    CartRemoteDataSource,
    AddCartItemUseCase,
    GetAllCartListUseCase,
    RemoveCartItemUseCase,
    ApplyCouponUseCase
  ],
  customMocks:[MockSpec<http.Client>(as: #MockHttpClient)],
)
@GenerateNiceMocks([MockSpec<BuildContext>()])



void main(){

}