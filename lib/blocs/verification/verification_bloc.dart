import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tsembisa/exceptions/exceptions.dart';
import 'package:tsembisa/helpers/validation.dart';
import 'package:tsembisa/services/verification/verification.service.dart';

part 'verification_event.dart';
part 'verification_state.dart';

class VerificationBloc extends Bloc<VerificationEvent, VerificationState> {
  final VerificationService verificationservice = new VerificationService();

  VerificationBloc() : super(InitialVerificationState());

  @override
  Stream<VerificationState> mapEventToState(VerificationEvent event) async* {
    if(event is GetVerificationEvent) {
      yield LoadingVerification();

      if(isNumber(event.mobile) && isPIN(event.pin)) {
        verificationservice.sms(mobile: event.mobile)
          .then((value) {
            add(FinishVerificationEvent());
           })
          .catchError((error) {
            if(!(error is ApplicationException)) {
              error = ApplicationException(error.toString());
            }

            add(FailedVerificationEvent(exception: error));
          });
      } else {
        yield FailedVerification(exception: ValidationException('Oops, either mobile number or PIN is invalid!'));
      }
    } else if(event is ResetVerificationEvent) {
      yield InitialVerificationState();
    }

    else if(event is FinishVerificationEvent) {
      yield SuccessVerification();
    }
    else if(event is FailedVerificationEvent) {
      yield FailedVerification(exception: event.exception);
    }
  }
}
