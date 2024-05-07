import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/features/shared_widgets/global_widgets.dart';
import 'package:awad_nahas/features/wishlist/presentation/widgets/wishlist_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';



class WishListScreen extends StatelessWidget {
  final bool includeBackButton ;
  const WishListScreen({super.key,this.includeBackButton = true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DMUtil.getWC(),
      appBar: GlobalAppBar(
          title: translate("profile.wishlist"),
          leadingIcon:  includeBackButton ? const BackArrowButton(): null,
      ),
      body: const  WishListWidget(),
    );
  }
}
