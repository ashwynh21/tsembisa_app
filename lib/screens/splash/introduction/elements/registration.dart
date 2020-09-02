import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tsembisa/blocs/confirmation/confirmation_bloc.dart';
import 'package:tsembisa/blocs/registration/registration_bloc.dart';
import 'package:tsembisa/blocs/verification/verification_bloc.dart';
import 'package:tsembisa/components/error.dart';
import 'package:tsembisa/theme/colors.dart';
import 'package:tsembisa/screens/splash/introduction/elements/input.dart';

import 'countdown.dart';

class Registration extends StatefulWidget {
  final Function cont;

  Registration({@required this.cont});


  @override
  State<StatefulWidget> createState() => _RegistrationState();

}

class _RegistrationState extends State<Registration> with SingleTickerProviderStateMixin {
  final TextEditingController number = new TextEditingController(),
    pin = new TextEditingController(),
    id = new TextEditingController();

  final FocusNode otp = new FocusNode();

  final BorderRadius topradius = BorderRadius.only(
      topLeft: Radius.circular(80),
      topRight: Radius.circular(80),
      bottomRight: Radius.circular(12),
      bottomLeft: Radius.circular(12)
  ),
  bottomradius = BorderRadius.only(
      topLeft: Radius.circular(20),
      topRight: Radius.circular(20),
      bottomRight: Radius.circular(80),
      bottomLeft: Radius.circular(80)
  );

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<VerificationBloc>(create: (_) => new VerificationBloc()),
        BlocProvider<ConfirmationBloc>(create: (_) => new ConfirmationBloc()),

        BlocProvider<RegistrationBloc>(create: (_) => new RegistrationBloc()),
      ],
      child: Container(
        alignment: Alignment.center,

        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(top: 112),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,

              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),

                  child: Material(
                    elevation: 4.0,
                    borderRadius: topradius,

                    child: ClipRRect(
                      borderRadius: topradius,
                      child: Stack(
                        children: <Widget>[
                          Container(
                            width: double.infinity,
                            height: 112,

                            decoration: BoxDecoration(
                              image: DecorationImage(image: AssetImage('lib/assets/images/covid.jpg'), fit: BoxFit.cover),

                              borderRadius: topradius,
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            height: 112,

                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.64),

                              borderRadius: topradius,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                AnimatedSize(
                  vsync: this,
                  duration: Duration(milliseconds: 512),
                  curve: Curves.easeOutCubic,

                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),

                    child: Material(
                      elevation: 4.0,
                      borderRadius: bottomradius,

                      child: ClipRRect(
                        borderRadius: bottomradius,
                        child: Stack(
                          children: <Widget>[
                            Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),

                                decoration: BoxDecoration(
                                  borderRadius: bottomradius,
                                ),
                                constraints: BoxConstraints(
                                    minHeight: 128
                                ),

                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                                    children: <Widget>[
                                      /*
                                        Let us create a number field here that will allow user to input their number
                                        and the OTP they will get from the number
                                         */
                                      Container(

                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Input(
                                              hint: 'PIN',
                                              color: accent,
                                              icon: 'lib/assets/icons/profile.svg',
                                              type: TextInputType.number,
                                              action: TextInputAction.done,
                                              controller: id,
                                              submission: (String value) {
                                              },
                                              change: () {
                                              },

                                              anchor: Container(),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(left: 16, top: 4, bottom: 12, right: 16),

                                              child: FittedBox(
                                                fit: BoxFit.contain,
                                                child: Text(
                                                  'please enter your personal identity number',
                                                  style: TextStyle(
                                                    color: accent,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Input(
                                              hint: 'Mobile Number',
                                              color: accent,
                                              icon: 'lib/assets/icons/phone.svg',
                                              type: TextInputType.phone,
                                              action: TextInputAction.done,
                                              controller: number,
                                              submission: (String value) {
                                              },
                                              change: () {
                                              },

                                              anchor: Container(),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(left: 16, right: 16, top: 4),

                                              child: FittedBox(
                                                fit: BoxFit.contain,
                                                child: Text(
                                                  'please enter your mobile number, i.e. 7812 3456',
                                                  style: TextStyle(
                                                    color: accent,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      BlocBuilder<VerificationBloc, VerificationState>(
                                        builder: (verificationcontext, state) {
                                          if(state is SuccessVerification) {
                                            return Container(
                                                margin: EdgeInsets.only(top: 16),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Input(
                                                        hint: 'OTP',
                                                        controller: pin,
                                                        color: accent,
                                                        icon: 'lib/assets/icons/unlock.svg',
                                                        type: TextInputType.number,
                                                        focus: otp,
                                                        submission: (String value) {

                                                        },
                                                        change: () {

                                                        },
                                                        anchor: AnimatedContainer(
                                                          duration: Duration(milliseconds: 320),
                                                          curve: Curves.easeOutCubic,

                                                          width: 64,
                                                          height: 44,

                                                          child: Center(child: CountDown(
                                                            stopped: () {
                                                              BlocProvider.of<VerificationBloc>(verificationcontext).add(ResetVerificationEvent());
                                                            },
                                                          )),
                                                        )
                                                    ),

                                                    Container(
                                                      margin: EdgeInsets.only(left: 16, top: 4, right: 16),
                                                      child: FittedBox(
                                                        fit: BoxFit.contain,
                                                        child: Text(
                                                          'please check your SMSs for your 6 digit pin',
                                                          style: TextStyle(
                                                            color: accent,
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              );
                                          }

                                          return Container();
                                        },
                                      )
                                    ]
                                )
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                Container(
                  width: 128,
                  height: 44,
                  margin: EdgeInsets.only(top: 32, bottom: 8),

                  child: Material(
                      color: Colors.white,
                      elevation: 4.0,
                      borderRadius: BorderRadius.all(Radius.circular(22)),

                      child: BlocConsumer<RegistrationBloc, RegistrationState>(
                        listener: (_, state) {
                          if(state is FailedRegistration) {
                            showDialog(context: context,
                              builder: (BuildContext context) => Error(exception: state.exception),
                              barrierDismissible: true,
                            );
                          }

                          if(state is SuccessRegistration) {
                            widget.cont();
                          }
                        },
                        builder: (registrationcontext, registrationstate) {
                          return BlocConsumer<ConfirmationBloc, ConfirmationState>(
                            listener: (_, state) {
                              if(state is FailedConfirmation) {
                                showDialog(context: context,
                                  builder: (BuildContext context) => Error(exception: state.exception),
                                  barrierDismissible: true,
                                );
                              }

                              /*
                              * Here we check if the confirmation was a success and begin
                              * running the registration process through for the users
                              * account
                              * */
                              if(state is SuccessConfirmation) {
                                BlocProvider.of<RegistrationBloc>(registrationcontext).add(StartRegistrationEvent(
                                  mobile: number.text,
                                  pin: id.text
                                ));
                              }
                            },
                            builder: (confirmationcontext, confirmationstate) {

                              return BlocConsumer<VerificationBloc, VerificationState>(
                                  listener: (_, state) {
                                    if(state is FailedVerification) {
                                      showDialog(context: context,
                                        builder: (BuildContext context) => Error(exception: state.exception),
                                        barrierDismissible: true,
                                      );
                                    }
                                  },
                                  builder: (verificationcontext, verificationstate) {

                                    return InkWell(
                                        onTap: () {
                                          if(verificationstate is InitialVerificationState || verificationstate is FailedVerification) {
                                            BlocProvider.of<VerificationBloc>(verificationcontext).add(GetVerificationEvent(
                                                mobile: number.text,
                                                pin: id.text
                                            ));
                                          } else if(verificationstate is SuccessVerification) {
                                            BlocProvider.of<ConfirmationBloc>(confirmationcontext).add(GetConfirmationEvent(
                                                mobile: number.text,
                                                otp: pin.text
                                            ));
                                          }
                                        },
                                        borderRadius: BorderRadius.all(Radius.circular(22)),

                                        child: Container(
                                            margin: EdgeInsets.all(8.0),
                                            child: () {
                                              if(verificationstate is LoadingVerification || confirmationstate is LoadingConfirmation || registrationstate is LoadingRegistration) {
                                                return Center(
                                                  child: Container(
                                                      width: 24,
                                                      height: 24,
                                                      child: CircularProgressIndicator()
                                                  ),
                                                );
                                              }

                                              return Text(
                                                    () {
                                                  if(verificationstate is SuccessVerification)
                                                    return 'confirm';

                                                  return 'verify';
                                                } (),
                                                style: TextStyle(
                                                    color: accent,
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.normal,
                                                    fontFamily: "Baloo Paaji 2",
                                                    height: 1.4
                                                ),
                                                textAlign: TextAlign.center,
                                              );
                                            } ()
                                        )
                                    );
                                  }
                              );
                            },
                          );
                        }
                      ),
                    )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

}