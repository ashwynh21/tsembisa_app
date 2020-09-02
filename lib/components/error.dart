
import 'package:flutter/cupertino.dart';
import 'package:tsembisa/exceptions/exceptions.dart';
import 'package:tsembisa/theme/colors.dart';
import 'package:flutter/material.dart';

class Error extends StatefulWidget {
  final ApplicationException exception;

  Error({
    @required this.exception,
  });

  @override
  State<StatefulWidget> createState() => _ErrorState();
}

class _ErrorState extends State<Error> with SingleTickerProviderStateMixin{


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Center(
        child: Material(
          color: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                  child: Text(
                    widget.exception.runtimeType.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      shadows: [
                        Shadow(blurRadius: 2)
                      ],
                      fontSize: 24,
                    ),
                  )
              ),
              AnimatedSize(
                duration: Duration(milliseconds: 320),
                curve: Curves.easeOutCubic,
                vsync: this,

                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 48),

                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                        bottomLeft: Radius.circular(80),
                        bottomRight: Radius.circular(80)
                    ),

                    child: Container(
                      color: Colors.white,

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,

                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top:16, left: 12, right: 12),

                            child: Text((widget.exception.message != null) ? widget.exception.message.toString() : '',
                              style: TextStyle(
                                color: error,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                height: 1.24
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),

                          Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(bottom: 12),

                            child: MaterialButton(
                              shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(16.0)),

                              color: error,
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              child: Container(
                                height: 32,
                                width: 64,
                                child: Center(
                                  child: Text('OK',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
