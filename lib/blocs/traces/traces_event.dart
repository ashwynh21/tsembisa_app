part of 'traces_bloc.dart';

@immutable
abstract class TracesEvent {}

class ReadTraces extends TracesEvent {}

class FoundTraces extends TracesEvent {
  final List<TraceModel> traces;

  FoundTraces({@required this.traces});
}

class FailedTraces extends TracesEvent {
  final ApplicationException exception;

  FailedTraces({@required this.exception});
}