part of 'update_bloc.dart';

@immutable
abstract class UpdateState {}

class InitialUpdateState extends UpdateState {}
class TriggerUpdate extends UpdateState {
  final int update;

  TriggerUpdate({@required this.update});
}