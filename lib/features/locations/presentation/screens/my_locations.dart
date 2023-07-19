
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:awad_nahas/core/styles/my_colors.dart';
import 'package:awad_nahas/features/locations/presentation/widgets/add_new_location_button.dart';
import 'package:awad_nahas/features/locations/presentation/widgets/locations_list.dart';
import 'package:awad_nahas/features/shared_widgets/global_widgets.dart';

class MyLocationsScreen extends StatelessWidget {
  const MyLocationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const AddNewLocationButton(),
      appBar: GlobalAppBar(
        title: translate("profile.locations"),
        justLogo: true,
        leadingIcon: GlobalWidgets.backArrowButton(()=> Navigator.of(context).pop(),kText1,Alignment.center,),
      ),
      body: const LocationsList()
    );
  }
}
