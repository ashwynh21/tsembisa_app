import 'package:flare_flutter/flare_controls.dart';
import 'package:flare_flutter/flare.dart';
import 'package:flare_dart/math/vec2d.dart';

class HeartController extends FlareControls {
  ActorAnimation wonk;
  double offset = 0;
  String animation;

  //
  Vec2D origin;

  HeartController({
    this.animation = 'slide',
  });
  @override
  void onCompleted(String name) {
    super.onCompleted(name);
  }
  @override
  // ignore: missing_return
  bool advance(FlutterActorArtboard artboard, double elapsed) {
    super.advance(artboard, elapsed);

    this.wonk.apply(this.offset * this.wonk.duration, artboard, 1.0);

    return true;
  }
  @override
  void initialize(FlutterActorArtboard artboard) {
    super.initialize(artboard);

    this.wonk = artboard.getAnimation(this.animation);
  }
}