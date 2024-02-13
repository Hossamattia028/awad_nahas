import 'package:awad_nahas/features/products/data/models/product_model.dart';

class ProductResponseModel{
  final List<ProductModel> products;
  final int productsCount;
  const ProductResponseModel({required this.products,required this.productsCount});
}