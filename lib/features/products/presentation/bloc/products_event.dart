import 'package:awad_nahas/core/strings/enum/filter_enum.dart';
import 'package:awad_nahas/features/categories/domain/entities/categories_entity.dart';
import 'package:awad_nahas/features/products/domain/entities/products_entity.dart';
import 'package:flutter/material.dart';

@immutable
abstract class ProductsEvent{
  const ProductsEvent();
}


class UpdateAllProductsEvent extends ProductsEvent{
  const UpdateAllProductsEvent();
}
class FetchAllProductsEvent extends ProductsEvent{
  const FetchAllProductsEvent();
}
class FetchAllProductsDataEvent extends ProductsEvent{
  final BuildContext ctx;
  const FetchAllProductsDataEvent({required this.ctx});
}
class FetchAllBestSellerProductsEvent extends ProductsEvent{
  const FetchAllBestSellerProductsEvent();
}

class FetchOffersProductsEvent extends ProductsEvent{
  final bool isPaginate ;
  const FetchOffersProductsEvent({this.isPaginate = false});
}

class UpdateSearchProductList extends ProductsEvent {
  final List<ProductsEntity>? productList;
  final SortEnum? sortEnum;
  const UpdateSearchProductList({this.productList,this.sortEnum});
}


class EnableSearchEvent extends ProductsEvent{
  final List<ProductsEntity>? productList;
  final bool? enable;
  const EnableSearchEvent({this.productList,this.enable});
}

class FilterByCategoryEvent extends ProductsEvent{
  final int catID;
  final BuildContext ctx;
  final bool isPaginate ;
  const FilterByCategoryEvent({required this.catID,required this.ctx,this.isPaginate = false});
}


class FilterFavProductsEvent extends ProductsEvent{
  final List wishList;
  const FilterFavProductsEvent({required this.wishList});
}

class ChangeCurrencyEvent extends ProductsEvent{
  const ChangeCurrencyEvent();
}

class UpdateCurrentProduct extends ProductsEvent{
  final ProductsEntity item;
  const UpdateCurrentProduct({required this.item});
}


class ShowCommentsEvent extends ProductsEvent{
  const ShowCommentsEvent();
}

class FetchProductCommentsEvent extends ProductsEvent{
  const FetchProductCommentsEvent();
}

class AddProductCommentEvent extends ProductsEvent{
  final String txt;
  const AddProductCommentEvent({required this.txt,});
}


class ChangeWidgetSizeEvent extends ProductsEvent{
  final double height;
  final int index;
  const ChangeWidgetSizeEvent({required this.height,required this.index});
}


class ChangeSortEvent extends ProductsEvent{
  final SortEnum sortEnum;
  const ChangeSortEvent({required this.sortEnum,});
}

class FilterProductEvent extends ProductsEvent{
  final FilterModel? filterModel;
  const FilterProductEvent({this.filterModel});
}

class EnableBrandFilterEvent extends ProductsEvent{
  const EnableBrandFilterEvent();
}
class EnableWeightFilterEvent extends ProductsEvent{
  const EnableWeightFilterEvent();
}

class FilterModel{
  final FilterPrice? filterPrice;
  final SearchModel? searchModel;
  final bool? isDiscount;
  final bool? isAvailable;
  final double? weight;
  final int? brandID;
  const FilterModel({this.filterPrice,this.searchModel,this.isDiscount,this.isAvailable,this.weight,this.brandID});
}

class SearchModel{
  final String word;
  final List<CategoriesEntity> categoryList;
  final List<CategoriesEntity> brandList;
  const SearchModel({required this.categoryList,required this.word,required this.brandList});
}
class FilterPrice{
  final double start;
  final double end;
  const FilterPrice({required this.start,required this.end});
}


class ShowFullContentEvent extends ProductsEvent{
  final bool? val;
  const ShowFullContentEvent({this.val});
}

