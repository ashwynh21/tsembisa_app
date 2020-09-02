part of 'treasure_bloc.dart';

@immutable
abstract class TreasureEvent {}

class GetLocation extends TreasureEvent {}

class UpdateLocation extends TreasureEvent {
  final LatLng location;

  UpdateLocation({@required this.location});
}

class SubmitLocation extends TreasureEvent {
  final LatLng location;

  SubmitLocation({@required this.location});
}

class FoundLocationEvent extends TreasureEvent {

  final Marker marker;

  FoundLocationEvent({@required this.marker});
}
class FailedLocationEvent extends TreasureEvent {
  final ApplicationException exception;

  FailedLocationEvent({@required this.exception});
}
class CompleteLocationEvent extends TreasureEvent {}