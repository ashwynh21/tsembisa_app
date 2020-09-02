import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tsembisa/blocs/preferences/preferences_bloc.dart';
import 'package:tsembisa/screens/splash/introduction/treasure.dart';

import '../background.dart';
import 'purpose.dart';
import 'elements/registration.dart';
import 'finished.dart';
import 'holder.dart';

class Introduction extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Introduction();
}

class _Introduction extends State<Introduction> {

  final PageController controller = new PageController();

  String animation = 'start';
  bool show = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if(controller.page == 1) {
          controller.animateToPage(0, duration: Duration(milliseconds: 256), curve: Curves.easeOutCubic);

          return false;
        }

        return true;
      },
      child: Stack(
        children: <Widget>[
          Background(animation: animation),

          FutureBuilder(
              future: Future.delayed(Duration(milliseconds: 2000)),
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.done)
                  show = true;

                return AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeOutCubic,

                  transform: Matrix4.identity()..translate(
                      show ? .0 : MediaQuery.of(context).size.width,
                      -MediaQuery.of(context).viewInsets.bottom / 2,
                      .0
                  ),

                  child: PageView.builder(
                    itemCount: 5,
                    controller: controller,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      switch(index) {
                        case 4:
                          return Holder();
                        case 3:
                          return Finished(
                            cont: () {
                              controller.animateToPage(4, duration: Duration(milliseconds: 360), curve: Curves.easeOutCubic);
                              Future.delayed(Duration(milliseconds: 500))
                                .then((_) {

                                  Future.delayed(Duration(seconds: 2))
                                    .then((_) {
                                      BlocProvider.of<PreferencesBloc>(context).add(CheckPreferences());
                                    });

                                  setState(() {
                                    animation = 'finish';
                                  });
                                });
                            },
                          );
                        case 2:
                          return Treasure(
                            proceed: () {
                              controller.animateToPage(3, duration: Duration(milliseconds: 360), curve: Curves.easeOutCubic);
                            },
                          );
                        case 1:
                          return Registration(
                            cont: () {
                              controller.animateToPage(2, duration: Duration(milliseconds: 360), curve: Curves.easeOutCubic);
                            },
                          );
                        case 0:
                        default:
                          return Purpose(
                            proceed: () {
                              controller.animateToPage(1, duration: Duration(milliseconds: 360), curve: Curves.easeOutCubic);
                            },
                          );
                      }
                    },
                  ),
                );
              }
          ),
        ],
      ),
    );
  }
}