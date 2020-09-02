import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tsembisa/theme/colors.dart';

class CountDown extends StatefulWidget {
  /*
  * We are going to need a way to check when the timer stops so we add a
  * callback function
  * */
  final Function stopped;
  CountDown({Key key,
    @required this.stopped
  }) : super(key: key);

  @override
  _CountDownState createState() => _CountDownState();
}

class _CountDownState extends State<CountDown> {
  Timer _timer;
  int time = 60;

  @override
  void initState() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      time = time - 1;

      if(time < 1) {
        timer.cancel();

        widget.stopped();
      }
      setState((){});
    });
    super.initState();
  }
  @override
  void dispose() {
    _timer.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Text(
        '00:${time.toString().padLeft(2, '0')}',
        style: TextStyle(
          color: time < 1 ? error : accent
        ),
      )
    );
  }
}