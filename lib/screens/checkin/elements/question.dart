import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tsembisa/blocs/checkin/checkin_bloc.dart';
import 'package:tsembisa/components/error.dart';
import 'package:tsembisa/screens/checkin/elements/heart/heart.dart';
import 'package:tsembisa/screens/checkin/elements/heart/heart_controller.dart';
import 'package:tsembisa/theme/colors.dart';

class Question extends StatefulWidget {
  final HeartController controller;

  Question({@required this.controller});

  @override
  State<StatefulWidget> createState() => _QuestionState();
}

class _QuestionState extends State<Question> {

  @override
  Widget build(BuildContext context) {

    return Container(
      width: MediaQuery.of(context).size.width,
        height: 80,
        child: Row(
          children: [
            BlocProvider<CheckinBloc>(
              create: (_) => new CheckinBloc(),
              child: BlocConsumer<CheckinBloc, CheckinState>(
                listener: (checkincontext, state) {
                  if(state is FailedCheckin) {
                    showDialog(context: context,
                      builder: (BuildContext context) => Error(exception: state.exception),
                      barrierDismissible: true,
                    );
                  }
                },
                builder: (checkincontext, state) {
                  return Material(
                      color: primary,
                      borderRadius: BorderRadius.circular(24),
                      child: Container(
                          width: 64,
                          height: 64,
                          color: Colors.transparent,

                          child: Stack(
                            children: [
                              state is LoadingCheckin ?
                              Center(
                                child: Container(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.white))
                                ),
                              ) :
                              Center(
                                child: SvgPicture.asset('lib/assets/icons/heart.svg', width: 28,)
                              ),
                              InkWell(
                                borderRadius: BorderRadius.circular(24),
                                highlightColor: accent.withOpacity(0.24),
                                splashColor: accent.withOpacity(0.16),

                                onTap: () {

                                  /*
                                  * Here we get the event bloc to submit the incident*/
                                  BlocProvider.of<CheckinBloc>(checkincontext).add(MakeCheckin(
                                      value: (widget.controller.offset * 5).round()
                                  ));
                                },
                              )
                            ],
                          )
                      )
                  );
                }
              ),
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    margin: EdgeInsets.only(left: 16),
                    child: Text(
                      'How are you feeling right now?',
                      style: TextStyle(
                          color: accent,
                          fontSize: 16
                      ),
                    )
                ),
                Container(
                    child: HeartBar(
                      controller: widget.controller,
                    )
                )
              ],
            )
          ],
        )
    );
  }
}