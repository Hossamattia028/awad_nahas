import 'package:awad_nahas/features/categories/domain/entities/categories_entity.dart';
import 'package:flutter/material.dart';


@immutable
abstract class CategoriesEvent{
  const CategoriesEvent();
}


class ChangeCategoriesEvent extends CategoriesEvent{
  final CategoriesEntity categoriesModel;
  const ChangeCategoriesEvent({required this.categoriesModel});
}

class ChangeCurrentBrand extends CategoriesEvent{
  final CategoriesEntity brandModel;
  const ChangeCurrentBrand({required this.brandModel});
}

class FetchAllCategoriesEvent extends CategoriesEvent{
  const FetchAllCategoriesEvent();
}

class SetProductsToCategoryEvent extends CategoriesEvent{
  final List list;
  final int catID;
  const SetProductsToCategoryEvent({required this.list,required this.catID});
}


class FetchMainSlidersEvent extends CategoriesEvent{
  const FetchMainSlidersEvent();
}

class FetchAnotherSliderAdsEvent extends CategoriesEvent{
  const FetchAnotherSliderAdsEvent();
}

class ChangeSliderIndexEvent extends CategoriesEvent{
  final int val ;
  const ChangeSliderIndexEvent({required this.val});
}