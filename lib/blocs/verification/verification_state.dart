part of 'verification_bloc.dart';

@immutable
abstract class VerificationState {}

class InitialVerificationState extends VerificationState {}

/*
* We are going to need a loading state, success state and failed state
* */
class LoadingVerification extends VerificationState {}

class SuccessVerification extends VerificationState {}

class FailedVerification extends VerificationState {
  final ApplicationException exception;

  FailedVerification({@required this.exception});
}
