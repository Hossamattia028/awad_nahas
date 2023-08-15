import 'package:flutter/material.dart';
import 'package:awad_nahas/features/locations/domain/entities/location_entity.dart';


@immutable
abstract class LocationsEvent{
  const LocationsEvent();
}


class FetchUserLocationsEvent extends LocationsEvent{
  const FetchUserLocationsEvent();
}

class RemoveLocationEvent extends LocationsEvent{
  final int id;
  const RemoveLocationEvent({required this.id});
}


class UpdateLocationEvent extends LocationsEvent{
  final Map<String,dynamic> data;
  const UpdateLocationEvent({required this.data});
}

class AddLocationEvent extends LocationsEvent{
  final Map<String,dynamic> data;
  const AddLocationEvent({required this.data});
}

class UpdateCurrentLocationEvent extends LocationsEvent{
  final bool isShipping;
  const UpdateCurrentLocationEvent({required this.isShipping});
}


