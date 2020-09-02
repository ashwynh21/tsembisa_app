import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  /*
  * So now all we need here is a url to the user avatar to be able to place
  * it as part of the user interface we have built here...
  * */
  final String url;

  Avatar({@required this.url});

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
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(width / 2),
                  color: Colors.black.withOpacity(0.16)
                ),
              ),
              Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.24)
                ),
              )
            ],
          ),
          /*
          * Here we have the avatar of the user...*/
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: width * 2,
                height: height,
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.08),
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(width), bottomRight: Radius.circular(width))
                ),
              ),
              Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.16),
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(width / 4))
                ),

                child: ClipRRect(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(width / 4)),
                  child: url != null ? Image.network(url, fit: BoxFit.cover,) : null
                )
              )
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.16),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(width / 2),
                        bottomRight: Radius.circular(width / 2),
                        topRight: Radius.circular(width / 2),
                    )
                ),
              )
            ],
          )
        ],
      )
    );
  }
}
