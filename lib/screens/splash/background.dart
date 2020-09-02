import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

import '../../theme/colors.dart';

class Background extends StatelessWidget {
  final String animation;

  Background({this.animation});

  @override
  Widget build(BuildContext context) {
    return Container(
      
      color: accent,
      child: Container(
        transform: Matrix4.identity()..translate(.0, -48.0, .0),
        child: FlareActor('lib/assets/flares/liteintro.flr', animation: animation)
      )
    );
  }
}
