import 'package:flutter/material.dart';

@immutable
abstract class DealsEvent{
  const DealsEvent();
}

class FetchAllDealsEvent extends DealsEvent{
  const FetchAllDealsEvent();
}
