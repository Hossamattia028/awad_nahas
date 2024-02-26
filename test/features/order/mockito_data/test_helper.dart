
import 'package:awad_nahas/core/network/network.dart';
import 'package:awad_nahas/features/categories/domain/repositories/category_repository.dart';
import 'package:awad_nahas/features/products/data/data_sources/products_remote_data_source.dart';
import 'package:awad_nahas/features/products/data/repositories/products_model_repository.dart';
import 'package:awad_nahas/features/products/domain/repositories/products_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;


@GenerateMocks(
  [
    ProductsRepository,
    NetworkInfo,
    ProductsRemoteDataSource
  ],
  customMocks:[MockSpec<http.Client>(as: #MockHttpClient)],
)



void main(){

}