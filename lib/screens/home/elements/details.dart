import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tsembisa/screens/home/elements/single.dart';
import 'package:tsembisa/theme/colors.dart';
import 'articles.dart';

class Details extends StatefulWidget {
  final int initial;

  Details({@required this.initial});

  @override
  State<StatefulWidget> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  PageController controller;
  int page;

  @override
  void initState() {
    controller = PageController(initialPage: widget.initial);
    page = widget.initial;

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Stack(
          fit: StackFit.expand,
          children: [
            PageView.builder(
              itemCount: articles.length,
              scrollDirection: Axis.horizontal,
              physics: NeverScrollableScrollPhysics(),
              controller: controller,
              itemBuilder: (_, index) {
                return Single(index: index);
              },
            ),

            /*
            * Here we need a similar to navigation system to work with the pager
            * */
            Container(
              margin: EdgeInsets.only(top: 32, left: 32),
              child: Align(
                alignment: Alignment.topLeft,
                child: SizedBox(
                    width: 80,
                    height: 80,

                    child: Center(
                      child: Material(
                        color: Colors.black.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(40),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.all(20),
                              child: SvgPicture.asset('lib/assets/icons/close.svg', color: Colors.white, width: 20,),
                            ),

                            InkWell(
                              borderRadius: BorderRadius.circular(40),
                              highlightColor: Colors.black.withOpacity(0.24),
                              splashColor: Colors.black.withOpacity(0.16),
                              onTap: () {
                                Navigator.of(context).pop();
                              },

                            )
                          ],
                        ),
                      ),
                    )
                ),
              ),
            ),
            Container(
              alignment: Alignment.bottomRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      width: 64,
                      height: 64,

                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(32),
                              bottomLeft: Radius.circular(32)
                          )
                      ),

                      child: Stack(
                        children: [
                          Container(
                              padding: EdgeInsets.all(22),
                              child: SvgPicture.asset('lib/assets/icons/next.svg', color: primary,)
                          ),
                          Material(
                              color: Colors.transparent,

                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(32),
                                  bottomLeft: Radius.circular(32)
                              ),
                              child: InkWell(
                                onTap: () {
                                  page = page + 1;
                                  controller.animateToPage(page, duration: Duration(milliseconds: 320), curve: Curves.easeOutCubic);
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
              ),
            )
          ],
        )
      ),
    );
  }
}