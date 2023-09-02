import 'package:awad_nahas/core/strings/enum/drawer_enum.dart';
import 'package:awad_nahas/features/categories/domain/entities/categories_entity.dart';
import 'package:awad_nahas/features/products/domain/entities/products_entity.dart';
import 'package:flutter/material.dart';


@immutable
abstract class RootEvent  {
  const RootEvent();
}

class ChangeDrawerViewEvent extends RootEvent{
  final DrawerEnum drawerEnum;
  const ChangeDrawerViewEvent({required this.drawerEnum});
}

class ChangeIndex extends RootEvent {
  final int index;
  final String title;
  const ChangeIndex({required this.index,required this.title});
}

class ChangeCurrentCurrency extends RootEvent {
  final String val;
  const ChangeCurrentCurrency({required this.val});
}

class SearchEvent extends RootEvent {
  final String word;
  final List<CategoriesEntity> categoryList;
  final List<ProductsEntity> productList;
  const SearchEvent({required this.word,required this.categoryList,required this.productList});
}

class EnableSearchEvent extends RootEvent{
  final List<ProductsEntity>? productList;
  final bool? enable;
  const EnableSearchEvent({this.productList,this.enable});
}

class FetchSettingEvent extends RootEvent{
  const FetchSettingEvent();
}

class SendMaintenanceEvent extends RootEvent{
  final Map<String,dynamic> data;
  const SendMaintenanceEvent({required this.data});
}



