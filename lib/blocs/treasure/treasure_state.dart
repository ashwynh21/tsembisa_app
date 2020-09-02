part of 'treasure_bloc.dart';

@immutable
abstract class TreasureState {}

class InitialTreasureState extends TreasureState {}

class LoadingLocation extends TreasureState {}

class FoundLocation extends TreasureState {
  final Marker marker;

  FoundLocation({@required this.marker});
}

class FailedLocation extends TreasureState {
  final ApplicationException exception;

  FailedLocation({@required this.exception});
}
class CompleteLocation extends TreasureState {}