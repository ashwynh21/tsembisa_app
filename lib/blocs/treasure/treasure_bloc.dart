import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';
import 'package:tsembisa/exceptions/exceptions.dart';
import 'package:tsembisa/services/user/user.service.dart';
import 'package:tsembisa_plugin/tsembisa_plugin.dart';

part 'treasure_event.dart';

part 'treasure_state.dart';

class TreasureBloc extends Bloc<TreasureEvent, TreasureState> {
  final UserService userservice = new UserService();

  TreasureBloc() : super(InitialTreasureState());

  @override
  Stream<TreasureState> mapEventToState(TreasureEvent event) async* {
    if(event is GetLocation) {
      yield LoadingLocation();

      Map<String, dynamic> location = await TsembisaPlugin.geolocation.getLocation();
      BitmapDescriptor icon = await BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(10,12)), 'lib/assets/icons/mark.png');

      Marker marker = new Marker(
          markerId: MarkerId('MyLocation'),
          position: LatLng(location['latitude'], location['longitude']),
          icon: icon
      );

      yield FoundLocation(marker: marker);
    }

    else if(event is UpdateLocation) {
      yield LoadingLocation();
      BitmapDescriptor icon = await BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(10,12)), 'lib/assets/icons/mark.png');

      Marker marker = new Marker(
          markerId: MarkerId('MyLocation'),
          position: event.location,
          icon: icon
      );

      yield FoundLocation(marker: marker);
    }
    else if(event is SubmitLocation) {
      yield LoadingLocation();

      userservice.setupgeofence(latitude: event.location.latitude, longitude: event.location.longitude)
      .then((value) {
        add(CompleteLocationEvent());
      })
      .catchError((error) {
        if(!(error is ApplicationException)) {
          error = ApplicationException(error.toString());
        }

        add(FailedLocationEvent(exception: error));
      });
    }

    else if(event is FoundLocationEvent) {
      yield FoundLocation(marker: event.marker);
    }
    else if(event is FailedLocationEvent) {
      yield FailedLocation(exception: event.exception);
    }
    else if(event is CompleteLocationEvent) {
      yield CompleteLocation();
    }
  }
}
