import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:timeago/timeago.dart';
import 'package:tsembisa/blocs/checkin/checkin_bloc.dart';
import 'package:tsembisa/blocs/history/history_bloc.dart';
import 'package:tsembisa/components/error.dart';
import 'package:tsembisa/screens/checkin/elements/background.dart';
import 'package:tsembisa/screens/checkin/elements/heart/heart_controller.dart';
import 'package:tsembisa/screens/checkin/elements/question.dart';
import 'package:tsembisa/theme/colors.dart';

class Checkin extends StatelessWidget {
  final HeartController controller = new HeartController();

  /*
  * To be able to make a checkin occur we are going to need the user logic here
  * to be able to reference the submission function of the application...so then
  * since it is going to be need the one time, then we should probably instantiate
  * it here...
  * */

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        color: Colors.white,

        child: MultiBlocProvider(
          providers: [
            BlocProvider<CheckinBloc>(create: (_) => CheckinBloc()),
            BlocProvider<HistoryBloc>(create: (_) => HistoryBloc()..add(ReadHistory()))
          ],
          child: Stack(
            children: [
              Background(),

              SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(top: 256, left: 32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 24),
                        child: Text(
                          'Check in',
                          style: TextStyle(
                              fontSize: 32,
                              color: primary,
                              fontWeight: FontWeight.w600
                          ),
                        )
                      ),

                      /*
                      * Here we need to consider how the and what criteria we need to evaluate
                      * our systems
                      * */

                      /*
                      * Let us begin with asking the user how they are feeling*/
                      Question(controller: controller),

                      /*
                      * Here we should consider adding the checkin history*/
                      Container(
                        height: 0.5,
                        width: MediaQuery.of(context).size.width - 64,
                        color: Colors.black.withOpacity(0.16),
                        margin: EdgeInsets.symmetric(vertical: 24),
                      ),

                      BlocListener<CheckinBloc, CheckinState>(
                        listener: (_, state) {
                          if(state is SubmittedCheckin) {
                            BlocProvider.of<HistoryBloc>(_).add(ReadHistory());
                          }
                        },
                        child: BlocBuilder<HistoryBloc, HistoryState>(
                          builder: (historycontext, state) {
                            if(state is SuccessHistory) {
                              return Column(
                                children: state.history.map((e) {
                                  return Container(
                                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                                    child: Opacity(
                                      opacity: int.parse(e.description) * (20 / 100) * 0.68 + 0.32,
                                      child: Row(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(right: 8),
                                            child: Text(e.description,
                                              style: TextStyle(
                                                color: Color(0xFFff6243),
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold
                                              ),
                                            )
                                          ),
                                          Container(
                                            height: 20,
                                            margin: EdgeInsets.only(right: 32),
                                            width: 20,
                                            child: SvgPicture.asset('lib/assets/icons/heart.svg')
                                          ),
                                          Container(
                                              margin: EdgeInsets.only(right: 8),
                                              child: Text(format(e.subtime),
                                                style: TextStyle(
                                                    color: Color(0xFFff6243),
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold
                                                ),
                                              )
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }).toList(),
                              );
                            }

                            return Container();
                          }
                        ),
                      ),

                      Container(
                        height: 64,
                      )
                    ],
                  ),
                )
              ),


              /*
              * and here we will have the send button...*/
              BlocConsumer<CheckinBloc, CheckinState>(
                  listener: (checkincontext, state) {
                    if(state is FailedCheckin) {
                      showDialog(context: context,
                        builder: (BuildContext context) => Error(exception: state.exception),
                        barrierDismissible: true,
                      );
                    }
                  },
                  builder: (checkincontext, state) {

                    return Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,

                      alignment: Alignment.bottomRight,

                      child: Container(
                          width: 180,
                          height: 64,

                          decoration: BoxDecoration(
                              color: primary,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(32),
                                  bottomLeft: Radius.circular(32)
                              )
                          ),

                          child: Stack(
                            children: [
                              Center(
                                child: state is LoadingCheckin ?
                                Container(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.white))
                                ) :
                                Text(
                                  'Send',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                              Material(
                                  color: Colors.transparent,

                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(32),
                                      bottomLeft: Radius.circular(32)
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      /*
                                      * Here we get the event bloc to submit the incident*/
                                      BlocProvider.of<CheckinBloc>(checkincontext).add(MakeCheckin(
                                          value: (controller.offset * 5).round()
                                      ));
                                    },
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(32),
                                        bottomLeft: Radius.circular(32)
                                    ),
                                    highlightColor: accent.withOpacity(0.24),
                                    splashColor: accent.withOpacity(0.16),
                                  )
                              ),
                            ],
                          )
                      ),
                    );
                  }
              ),
              /*
              * Here we will have the close button */
              Container(
                margin: EdgeInsets.only(top: 32, left: 32),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: SizedBox(
                      width: 80,
                      height: 80,

                      child: Center(
                        child: Material(
                          color: Colors.black.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(40),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.all(20),
                                child: SvgPicture.asset('lib/assets/icons/close.svg', color: Colors.black.withOpacity(0.48), width: 20),
                              ),

                              InkWell(
                                borderRadius: BorderRadius.circular(40),
                                highlightColor: Colors.black.withOpacity(0.24),
                                splashColor: Colors.black.withOpacity(0.16),
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          ),
                        ),
                      )
                  ),
                ),
              ),

            ],
          ),
        )
      )
    );
  }
}
