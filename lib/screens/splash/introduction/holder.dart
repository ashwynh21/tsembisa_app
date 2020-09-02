
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Holder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 24,
        width: 24,

        transform: Matrix4.identity()..translate(.0 , 40.0, .0),

        child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.white))
      ),
    );
  }
}
