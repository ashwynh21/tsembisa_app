import 'package:flutter/material.dart';
import 'package:tsembisa/theme/colors.dart';

class Panel extends StatelessWidget {
  /*
  * For the panel we are going to need a background, title, and a callback
  * function to call when the user clicks on it...
  * */
  final String background, title;
  final Function callback;

  Panel({
    @required this.background,
    @required this.title,
    @required this.callback
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 212,
      width: 160,
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),

      child: Material(
        borderRadius: BorderRadius.circular(24),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Stack(
            fit: StackFit.expand,
            children: [
              /*First the background*/
              Image.asset(background, fit: BoxFit.cover,),
              /*Then the title text*/
              Container(
                alignment: Alignment.bottomLeft,
                margin: EdgeInsets.only(bottom: 8, left: 24, right: 24),
                child: Material(
                  color: Colors.transparent,
                  child: Text(title,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                ),
              ),
              /*The we add the touch effect on top*/
              Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(24),

                child: InkWell(
                  onTap: () {
                    if(callback != null) {
                      callback();
                    }
                  },
                  highlightColor: accent.withOpacity(0.24),
                  splashColor: accent.withOpacity(0.16),

                  borderRadius: BorderRadius.circular(24),
                )
              )
            ],
          )
        )
      ),
    );
  }
}
