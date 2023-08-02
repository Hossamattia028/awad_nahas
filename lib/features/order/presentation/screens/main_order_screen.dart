import 'package:awad_nahas/core/styles/my_colors.dart';
import 'package:awad_nahas/features/account/presentation/bloc/account_bloc.dart';
import 'package:awad_nahas/features/account/presentation/bloc/account_state.dart';
import 'package:awad_nahas/features/order/presentation/screens/order_screen.dart';
import 'package:awad_nahas/features/order/presentation/widgets/date_filter_widget.dart';
import 'package:awad_nahas/features/root_app/widgets/drawer_icon.dart';
import 'package:awad_nahas/features/shared_widgets/global_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainOrderScreen extends StatelessWidget {
  const MainOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  GlobalAppBar(
        justLogo: true,
        leadingIcon:  const DateFilterWidget(),
        title: '',
        whiteLogo: true,
        backGroundColor: kPrimary,
        icon: DrawerIcon(ctx: context,),
      ),
      body: BlocBuilder<AccountBloc,AccountState>(
        builder: (ctx,state){
          var user = AccountBloc.get(ctx).currentUser;
          // if(user==null)return const Center(child:  CircularProgressIndicator(color: Colors.black45,));
            return const OrderScreen();
        },
      ),
    );
  }
}
