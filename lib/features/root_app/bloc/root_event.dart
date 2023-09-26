import 'package:awad_nahas/core/strings/enum/drawer_enum.dart';
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




class FetchSettingEvent extends RootEvent{
  const FetchSettingEvent();
}

class SendMaintenanceEvent extends RootEvent{
  final Map<String,dynamic> data;
  const SendMaintenanceEvent({required this.data});
}



