import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tsembisa/screens/checkin/checkin.dart';
import 'package:tsembisa/screens/contact/contact.dart';
import 'package:tsembisa/theme/colors.dart';

class Navigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(left: 32),
            child: Row(
              children: [
                Container(
                    width: 44,
                    height: 44,
                    margin: EdgeInsets.only(right: 24),

                    child: Material(
                      color: Colors.transparent,
                      child: Stack(
                        children: [
                          Container(
                            margin: EdgeInsets.all(9),
                            child: SvgPicture.asset('lib/assets/icons/logout.svg', color: primary),
                          ),

                          InkWell(
                            borderRadius: BorderRadius.circular(32),
                            onTap: () {
                              SystemNavigator.pop();
                            },

                          )
                        ],
                      ),
                    )
                ),
                Container(
                    width: 44,
                    height: 44,
                    margin: EdgeInsets.only(right: 24),

                    child: Material(
                      color: Colors.transparent,
                      child: Stack(
                        children: [
                          Container(
                            margin: EdgeInsets.all(9),
                            child: SvgPicture.asset('lib/assets/icons/profile.svg', color: primary),
                          ),

                          InkWell(
                            borderRadius: BorderRadius.circular(32),
                            onTap: () {

                              Navigator.of(context).push(
                                  PageRouteBuilder(
                                      pageBuilder: (_, __, ___) => Contact()
                                  )
                              );
                            },

                          )
                        ],
                      ),
                    )
                ),
              ],
            ),
          ),

          Container(
            width: 64,
            height: 64,
            
            decoration: BoxDecoration(
              color: primary,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32),
                bottomLeft: Radius.circular(32)
              )
            ),

            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  child: SvgPicture.asset('lib/assets/icons/business.svg', color: Colors.white,)
                ),
                Material(
                  color: Colors.transparent,

                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      bottomLeft: Radius.circular(32)
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          pageBuilder: (_, __, ___) => Checkin()
                        )
                      );
                    },
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32),
                        bottomLeft: Radius.circular(32)
                    ),
                    highlightColor: accent.withOpacity(0.24),
                    splashColor: accent.withOpacity(0.16),
                  )
                ),
              ],
            )
          )
        ],
      )
    );
  }
}
