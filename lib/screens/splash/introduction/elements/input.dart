import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tsembisa/theme/colors.dart';
import 'package:flutter_svg/svg.dart';

class Input extends StatelessWidget {
  final TextEditingController controller;
  final String hint, icon;
  final Color color;
  final TextInputType type;
  final TextInputAction action;
  final FocusNode focus;

  final Function(String) submission;
  final Function() change;

  final Widget anchor;

  Input({
    @required this.hint,
    @required this.icon,
    @required this.controller,
    this.focus,
    this.color = accent,
    this.action = TextInputAction.done,
    @required this.anchor,
    @required this.type,
    @required this.submission,
    @required this.change,
  });

  @override
  Widget build(BuildContext context) {
    return
      Material(
        color: color,
        elevation: .0,
        borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height),

        child: Container(
          margin: EdgeInsets.all(1.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height)
          ),
          width: MediaQuery.of(context).size.width,
          height: 44,

          child: Flex(
            direction: Axis.horizontal,

            children: <Widget>[
              Container(
                width: 18,
                height: 18,

                margin: EdgeInsets.symmetric(horizontal: 16),
                child: SvgPicture.asset(icon, color: color)
              ),

              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: hint,
                    hintStyle: TextStyle(
                      fontSize: 18,
                      color: color.withOpacity(.48),
                      height: .0,
                    ),
                    contentPadding: EdgeInsets.all(.0),
                  ),
                  focusNode: focus,

                  cursorColor: color.withOpacity(0.64),
                  cursorRadius: Radius.circular(1.0),
                  controller: controller,

                  onSubmitted: (value) {
                    if(submission != null)
                      submission(value);
                  },
                  onChanged: (value) {
                    if(change != null)
                      change();
                  },

                  keyboardType: type,
                  textInputAction: action,
                ),
              ),

              Container(
                constraints: BoxConstraints(
                  maxWidth: 64,
                ),
                child: () {
                  if(anchor != null)
                    return anchor;

                  return Container();
                }()
              )
            ],
          ),
        )
      );
  }
}
