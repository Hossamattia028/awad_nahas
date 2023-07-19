import 'package:flutter/material.dart';


@immutable
abstract class CategoriesEvent{
  const CategoriesEvent();
}


class ChangeCategoriesEvent extends CategoriesEvent{
  final dynamic categoriesModel;
  const ChangeCategoriesEvent({required this.categoriesModel});
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