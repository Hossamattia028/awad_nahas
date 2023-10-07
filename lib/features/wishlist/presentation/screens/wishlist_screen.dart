import 'package:awad_nahas/core/utils/dark_mode_utility.dart';
import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:awad_nahas/features/account/presentation/widgets/account_before_auth.dart';
import 'package:awad_nahas/features/shared_widgets/global_widgets.dart';
import 'package:awad_nahas/features/wishlist/presentation/widgets/wishlist_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';



class WishListScreen extends StatelessWidget {
  final bool includeBackButton ;
  const WishListScreen({Key? key,this.includeBackButton = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DMUtil.getWC(),
      appBar: GlobalAppBar(
          title: translate("profile.wishlist"),
          leadingIcon:  includeBackButton ? const BackArrowButton(): null,
      ),
      // body: Util.checkUser() ? const  WishListWidget() : const AccountNotAuth(),
      body: const  WishListWidget(),
    );
  }
}
