import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tsembisa/theme/colors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:tsembisa/configurations/environment.dart' as environment;

class Update extends StatelessWidget {
  final int update;

  Update({@required this.update});

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
                    'Tsembisa Update',
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
              Container(
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

                          child: Text('an update is available from version ${environment.version} to $update',
                            style: TextStyle(
                                color: primary,
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

                            color: primary,
                            onPressed: () {
                              Navigator.of(context).pop();
                              launchupdate();
                            },
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            child: Container(
                              height: 32,
                              width: 64,
                              child: Center(
                                child: Text('update',
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
              )
            ],
          ),
        ),
      ),
    );
  }

  launchupdate() async {
    const url = 'http://portal.ndma.org.sz/files/tsembisa.apk';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
