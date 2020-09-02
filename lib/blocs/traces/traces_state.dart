part of 'traces_bloc.dart';

@immutable
abstract class TracesState {}

class InitialTracesState extends TracesState {}

class LoadingTraces extends TracesState {}

class FoundTracesState extends TracesState {
  final List<TraceModel> traces;

  FoundTracesState({@required this.traces});
}

class FailedTracesState extends TracesState {
  final ApplicationException exception;

  FailedTracesState({@required this.exception});
}