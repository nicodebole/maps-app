import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  StreamSubscription<Position>? positionStream;

  LocationBloc() : super(const LocationState()) {
    on<OnNewUserLocationEvent>((event, emit) => emit(state.copyWith(
        lastKnownPosition: event.newLocation,
        myLocationHistory: [...state.myLocationHistory, event.newLocation])));
    on<OnStartFollowingUser>(
        (event, emit) => emit(state.copyWith(followingUser: true)));
    on<OnStopFollowingUser>(
        (event, emit) => emit(state.copyWith(followingUser: false)));
  }

  Future getCurrentPosition() async {
    final position = await Geolocator.getCurrentPosition();
    print(position);
    add(OnNewUserLocationEvent(LatLng(position.latitude, position.longitude)));
  }

  void startFollowingUser() {
    add(OnStartFollowingUser());
    print('startFollowingUser');
    positionStream = Geolocator.getPositionStream().listen((event) {
      add(OnNewUserLocationEvent(LatLng(event.latitude, event.longitude)));
    });
  }

  void stopFollowingUser() {
    positionStream?.cancel();
    add(OnStopFollowingUser());
    print('stopFollowingUser');
  }

  @override
  Future<void> close() {
    positionStream?.cancel();
    return super.close();
  }
}
