
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../theme/colors.dart';

class Purpose extends StatelessWidget {
  final Function proceed;

  Purpose({@required this.proceed});

  final BorderRadius topradius = BorderRadius.only(
      topLeft: Radius.circular(80),
      topRight: Radius.circular(80),
      bottomRight: Radius.circular(12),
      bottomLeft: Radius.circular(12)
  ),
  bottomradius = BorderRadius.only(
      topLeft: Radius.circular(20),
      topRight: Radius.circular(20),
      bottomRight: Radius.circular(80),
      bottomLeft: Radius.circular(80)
  );

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.24),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),

              child: Material(
                elevation: 4.0,
                borderRadius: topradius,

                child: ClipRRect(
                  borderRadius: topradius,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        height: 112,

                        decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage('lib/assets/images/corona.jpg'), fit: BoxFit.cover),

                          borderRadius: topradius,
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 112,

                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.64),

                          borderRadius: topradius,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),

              child: Material(
                elevation: 4.0,
                borderRadius: bottomradius,

                child: ClipRRect(
                  borderRadius: bottomradius,
                  child: Stack(
                    children: <Widget>[
                      Container(
                          width: double.infinity,
                          height: 180,
                          padding: EdgeInsets.all(16),

                          decoration: BoxDecoration(
                            borderRadius: bottomradius,
                          ),

                          child: Column(
                            children: <Widget>[
                              Container(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,

                                  children: <Widget>[
                                    Text('tsembisa ',
                                      style: TextStyle(
                                          color: primary,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Baloo Paaji 2"
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                  margin: EdgeInsets.only(top: 8),
                                  child: Text('Welcome to tsembisa, the version of phepha solely bound to the mission of combating COVID-19.',
                                    style: TextStyle(
                                        color: primary,
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: "Baloo Paaji 2",
                                        height: 1.24
                                    ),
                                  )
                              )
                            ],
                          )
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Container(
                width: 128,
                height: 44,
                margin: EdgeInsets.only(top: 44),
                child: Material(
                  color: Colors.white,
                  elevation: 4.0,
                  borderRadius: BorderRadius.all(Radius.circular(22)),

                  child: InkWell(
                      onTap: proceed,
                      borderRadius: BorderRadius.all(Radius.circular(22)),

                      child: Container(
                        margin: EdgeInsets.all(8.0),
                        child: Text(
                          'continue',
                          style: TextStyle(
                              color: accent,
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                              fontFamily: "Baloo Paaji 2",
                              height: 1.4
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )
                  ),
                )
            )
          ],
        )
      ),
    );
  }
}
