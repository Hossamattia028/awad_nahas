
import 'package:awad_nahas/core/network/network.dart';
import 'package:awad_nahas/features/products/data/data_sources/products_remote_data_source.dart';
import 'package:awad_nahas/features/products/domain/repositories/products_repository.dart';
import 'package:awad_nahas/features/products/domain/use_cases/comment_usecase.dart';
import 'package:awad_nahas/features/products/domain/use_cases/products_usecase.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;


@GenerateMocks(
  [
    ProductsRepository,
    NetworkInfo,
    ProductsRemoteDataSource,
    GetAllProductCommentsUseCase,
    AddProductCommentUseCase,
    GetAllProductsUseCase
  ],
  customMocks:[MockSpec<http.Client>(as: #MockHttpClient)],
)



void main(){

}