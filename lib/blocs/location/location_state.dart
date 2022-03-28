part of 'location_bloc.dart';

class LocationState extends Equatable {
  final bool followingUser;

  final LatLng? lastKnownPosition;
  final List<LatLng> myLocationHistory;

  const LocationState({
    myLocationHistory,
    this.lastKnownPosition,
    this.followingUser = false,
  }) : myLocationHistory = myLocationHistory ?? const [];

  LocationState copyWith({
    final bool? followingUser,
    final LatLng? lastKnownPosition,
    final List<LatLng>? myLocationHistory,
  }) =>
      LocationState(
        followingUser: followingUser ?? this.followingUser,
        lastKnownPosition: lastKnownPosition ?? this.lastKnownPosition,
        myLocationHistory: myLocationHistory ?? this.myLocationHistory,
      );

  @override
  List<Object?> get props =>
      [followingUser, lastKnownPosition, myLocationHistory];
}
