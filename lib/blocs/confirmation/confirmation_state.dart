part of 'confirmation_bloc.dart';

@immutable
abstract class ConfirmationState {}

class InitialConfirmationState extends ConfirmationState {}

class LoadingConfirmation extends ConfirmationState {}

class SuccessConfirmation extends ConfirmationState {}

class FailedConfirmation extends ConfirmationState {
  final ApplicationException exception;

  FailedConfirmation({@required this.exception});
}