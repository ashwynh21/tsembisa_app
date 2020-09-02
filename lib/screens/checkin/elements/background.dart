import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  /*
  * Let us add a general set of size variables since everything here is very
  * geometric
  * */
  final double width = 84;
  final double height = 84;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.24)
                ),
              ),
              Container(
                width: width + 32,
                height: height + 32,
                margin: EdgeInsets.only(left: 24),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular((width + 32) / 2), bottomLeft: Radius.circular((width + 32) / 2)),
                    color: Colors.black.withOpacity(0.16)
                ),
              ),
              Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.32),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(width / 2),
                    bottomRight: Radius.circular(width / 2),
                    topRight: Radius.circular(width / 2)
                  )
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: width * 2,
                height: height,
                margin: EdgeInsets.only(right: 32),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.16),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(width), topRight: Radius.circular(width))
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
