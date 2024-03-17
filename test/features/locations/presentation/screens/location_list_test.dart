import 'dart:io';
import 'package:awad_nahas/features/locations/domain/entities/location_entity.dart';
import 'package:awad_nahas/features/locations/presentation/bloc/locations_bloc.dart';
import 'package:awad_nahas/features/locations/presentation/bloc/locations_event.dart';
import 'package:awad_nahas/features/locations/presentation/bloc/locations_state.dart';
import 'package:awad_nahas/features/locations/presentation/widgets/locations_list.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../../../../core/util_test.dart';


var dummyAddress = const LocationEntity(address1: "address1", address2: "address2", city: "city", phone: "201123876427", state: "state", country: "country",
      id: 0, type: "", lat: 23, long: 23, postCode: "postCode",
      lastName: "lastName", firstName: "firstName", email: "email", locationType: "locationType");

class MockLocationsBloc extends MockBloc<LocationsEvent, LocationsState>
    implements LocationsBloc {
  @override
  AddressEntity get userLocationsList => AddressEntity(shippingAddress: dummyAddress, billingAddress: dummyAddress);
  @override
  List<LocationEntity> get localUserLocationsList => [];
}

class FakeLocationState extends Fake implements LocationsState {}

void main() {
  late LocationsBloc locationsBloc;

  setUpAll(() {
    HttpOverrides.global = null;
    registerFallbackValue(FakeLocationState());
  });

  setUp(() async{
    await TestHelper.initalWidgetTesting();
    locationsBloc = MockLocationsBloc();
  });

  Widget rootWidget(Widget body) {
    return BlocProvider<LocationsBloc>.value(
      value: locationsBloc,
      child: ScreenUtilInit(
          designSize: const Size(375, 667),
          child: Localizations(delegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ], locale: const Locale('en'), child: MaterialApp(home: body))),
    );
  }

  testWidgets('location list widget', (tester) async {
    when(() => locationsBloc.state).thenReturn(const LocationsLoadingState());
    await tester.pumpWidget(rootWidget(const LocationsList()));
  });
}
