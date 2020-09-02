import 'package:flutter/material.dart';
import 'package:tsembisa/theme/colors.dart';

class Name extends StatelessWidget {
  /*
  * Here we simply display the name of the user...
  * */
  final String names;

  Name({@required this.names});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text(
              'Hello,',
              style: TextStyle(
                fontSize: 32,
                color: primary,
                fontWeight: FontWeight.w600
              ),
            )
          ),
          Container(
            child: Text(
              names.split(',').fold("", (value, element) {
                return value + element[0] + element.toLowerCase().substring(1, element.length) + ' ';
              }),
              style: TextStyle(
                fontSize: 32,
                color: primary,
                fontWeight: FontWeight.w400,
                letterSpacing: -1
              ),
            )
          )
        ],
      )
    );
  }
}
