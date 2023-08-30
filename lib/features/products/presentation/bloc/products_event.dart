import 'package:awad_nahas/core/strings/enum/filter_enum.dart';
import 'package:awad_nahas/features/products/domain/entities/products_entity.dart';
import 'package:flutter/material.dart';

@immutable
abstract class ProductsEvent{
  const ProductsEvent();
}



class FetchAllProductsEvent extends ProductsEvent{
  const FetchAllProductsEvent();
}
class FetchAllProductsDataEvent extends ProductsEvent{
  final BuildContext ctx;
  const FetchAllProductsDataEvent({required this.ctx});
}

class FetchAllLatestProductsEvent extends ProductsEvent{
  const FetchAllLatestProductsEvent();
}

class FetchAllBestSellerProductsEvent extends ProductsEvent{
  const FetchAllBestSellerProductsEvent();
}

class FetchOffersProductsEvent extends ProductsEvent{
  final bool isPaginate ;
  const FetchOffersProductsEvent({this.isPaginate = false});
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