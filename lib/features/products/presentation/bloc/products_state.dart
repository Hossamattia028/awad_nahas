
import 'package:flutter/material.dart';

@immutable
abstract class ProductsState{
  const ProductsState();
}



class ProductsInitialState extends ProductsState {}


class ProductsLoadingState extends ProductsState{
  const ProductsLoadingState();
}

class ProductsSuccessfullyState extends ProductsState{
  const ProductsSuccessfullyState();
}

class ProductsFailedState extends ProductsState{
  const ProductsFailedState();
}


class FilterByCategoryState extends ProductsState{
  const FilterByCategoryState();
}


class ProductCommentsLoadingState extends ProductsState{
  const ProductCommentsLoadingState();
}

class ProductCommentsSuccessfullyState extends ProductsState{
  const ProductCommentsSuccessfullyState();
}

class ProductCommentsFailedState extends ProductsState{
  const ProductCommentsFailedState();
}