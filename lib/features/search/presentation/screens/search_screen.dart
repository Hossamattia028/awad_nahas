import 'package:awad_nahas/features/search/presentation/screens/search_category_list.dart';
import 'package:awad_nahas/features/search/presentation/screens/search_product_list.dart';
import 'package:flutter/material.dart';




class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 10),
      physics: NeverScrollableScrollPhysics(),
      child: Column(
        children:  [
          SearchCategoryList(),
          SearchProductList(),
        ],
      ),
    );
  }
}
