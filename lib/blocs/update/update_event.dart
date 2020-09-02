part of 'update_bloc.dart';

@immutable
abstract class UpdateEvent {}

class CheckUpdate extends UpdateEvent {}