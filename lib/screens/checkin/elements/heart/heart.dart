import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'heart_controller.dart';

class HeartBar extends StatefulWidget {
  final HeartController controller;

  HeartBar({Key key,
    @required this.controller
  }) : super(key: key);

  @override
  _HeartBarState createState() => _HeartBarState();
}

class _HeartBarState extends State<HeartBar> {
  double value = 50.0;

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.centerLeft,
        height: 48,
        width: MediaQuery.of(context).size.width * 0.6,
        child: Stack(
          children: <Widget>[
            Container(
              child: FlareActor('lib/assets/flares/hearts.flr',
                controller: widget.controller,
                alignment: Alignment.center,
                animation: 'slide',
                shouldClip: false,
                callback: (animation) => () {},
              ),
            ),
            Opacity(
              opacity: 0,
              child: Slider(min: 0, max: 100, divisions: 100, value: (value != null) ? value : 50,
                onChanged: (double value) {
                  setState(() {
                    value = value;

                    widget.controller.offset = value / 100;
                  });
                },),
            )
          ],
        )
    );
  }
}