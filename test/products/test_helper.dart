
import 'package:awad_nahas/features/categories/domain/repositories/category_repository.dart';
import 'package:awad_nahas/features/products/domain/repositories/products_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;


@GenerateMocks(
  [
    ProductsRepository
  ],
  customMocks:[MockSpec<http.Client>(as: #MockHttpClient)],
)



void main(){

}