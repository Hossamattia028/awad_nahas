import 'package:awad_nahas/core/error/failure.dart';
import 'package:awad_nahas/features/categories/domain/entities/categories_entity.dart';
import 'package:awad_nahas/features/categories/domain/entities/slider_entity.dart';
import 'package:awad_nahas/features/categories/domain/repositories/category_repository.dart';
import 'package:dartz/dartz.dart';


class GetAllCategoryUseCase {
  final CategoryRepository categoryRepository;

  GetAllCategoryUseCase({required this.categoryRepository});

  Future<Either<Failure, List<CategoriesEntity>>> call() async {
    return await categoryRepository.getAllCategories();
  }
}



class GetAllBrandsUseCase {
  final CategoryRepository categoryRepository;

  GetAllBrandsUseCase({required this.categoryRepository});

  Future<Either<Failure, List<CategoriesEntity>>> call() async {
    return await categoryRepository.getAllBrands();
  }
}



class GetAllSlidersUseCase {
  final CategoryRepository categoryRepository;

  GetAllSlidersUseCase({required this.categoryRepository});

  Future<Either<Failure, SliderEntity>> call({required String sliderTitle}) async {
    return await categoryRepository.getAllSliders(sliderTitle: sliderTitle);
  }
}

