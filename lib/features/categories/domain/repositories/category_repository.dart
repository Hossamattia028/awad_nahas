import 'package:awad_nahas/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:awad_nahas/features/categories/domain/entities/categories_entity.dart';
import 'package:awad_nahas/features/categories/domain/entities/slider_entity.dart';

abstract class CategoryRepository {
  Future<Either<Failure, List<CategoriesEntity>>> getAllCategories();
  Future<Either<Failure, List<CategoriesEntity>>> getAllBrands();
  Future<Either<Failure, List<SliderEntity>>> getAllSliders();
}
