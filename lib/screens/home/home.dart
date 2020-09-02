import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tsembisa/blocs/preferences/preferences_bloc.dart';
import 'package:tsembisa/blocs/services/services_bloc.dart';
import 'package:tsembisa/blocs/update/update_bloc.dart';
import 'package:tsembisa/screens/checkin/elements/heart/heart_controller.dart';
import 'package:tsembisa/screens/checkin/elements/question.dart';
import 'package:tsembisa/screens/home/elements/details.dart';
import 'package:tsembisa/screens/home/elements/name.dart';
import 'package:tsembisa/screens/home/elements/panel.dart';
import 'package:tsembisa/theme/colors.dart';
import './elements/avatar.dart';
import 'elements/navigation.dart';
import 'elements/articles.dart';
import 'elements/update.dart';

class Home extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _HomeState();
}
class _HomeState extends State<Home> {

  final HeartController controller = new HeartController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MultiBlocProvider(
          providers: [
            BlocProvider<ServicesBloc>(create: (_) => new ServicesBloc()..add(StartServices())),
            BlocProvider<UpdateBloc>(create: (_) => new UpdateBloc()..add(CheckUpdate()))
          ],
          child: MultiBlocListener(
              listeners: [
                BlocListener<ServicesBloc, ServicesState>(listener: (servicescontext, state) {}),
                BlocListener<UpdateBloc, UpdateState>(listener: (servicescontext, state) {
                  if(state is TriggerUpdate) {
                    showDialog(context: context,
                      builder: (BuildContext _) => Update(update: state.update),
                      barrierDismissible: true,
                    );
                  }
                })
              ],
              child: BlocBuilder<PreferencesBloc, PreferencesState>(
                  builder: (preferencescontext, preferencesstate) {
                    return Container(
                        color: Colors.white,

                        child: Stack(
                          children: [

                            SingleChildScrollView(
                              child: Stack(
                                children: [
                                  Avatar(
                                    /*
                            * Here we check if the state is right and then pass in the url*/
                                    url: (preferencesstate is FoundPreferences) ? "https://easygeni.com/account_photos/${(preferencesstate).user.pin}.jpg" : null,
                                  ),
                                  Container(

                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(

                                            margin: EdgeInsets.only(top: 180, left: 32),
                                            child: Name(names: (preferencesstate is FoundPreferences) ? preferencesstate.user.names : null,)

                                        ),
                                        Container(
                                            margin: EdgeInsets.only(top: 16),
                                            constraints: BoxConstraints(
                                                maxWidth: MediaQuery.of(context).size.width,
                                                maxHeight: 244
                                            ),
                                            child: NotificationListener<OverscrollIndicatorNotification>(
                                              onNotification: (overscroll) {
                                                overscroll.disallowGlow();

                                                return true;
                                              },
                                              child: ListView.builder(
                                                scrollDirection: Axis.horizontal,
                                                itemCount: articles.length,
                                                itemBuilder: (_, index) {
                                                  Panel panel = Panel(
                                                    background: articles[index]['image'],
                                                    title: articles[index]['topic'],
                                                    callback: () {
                                                      Navigator.push(preferencescontext,
                                                          PageRouteBuilder(
                                                              pageBuilder: (_, __, ___) => Details(
                                                                initial: index,
                                                              )
                                                          ));
                                                    },
                                                  );

                                                  if(index == 0) {
                                                    return Container(margin: EdgeInsets.only(left: 16), child: panel);
                                                  }
                                                  if(index == articles.length - 1) {
                                                    return Container(margin: EdgeInsets.only(right: 16), child: panel);
                                                  }

                                                  return panel;
                                                },
                                              ),
                                            )
                                        ),

                                        Container(
                                          margin: EdgeInsets.only(top: 32, left: 24, right: 24, bottom: 128),
                                          child: Material(
                                            borderRadius: BorderRadius.circular(24),
                                            child: Container(
                                                margin: EdgeInsets.only(top: 16, left: 16, right: 8, bottom: 16),

                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Center(
                                                        child: Question(controller: controller)
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(left: 8),
                                                      child: Text('tap the heart to save and send how you\'re feeling...',
                                                        style: TextStyle(
                                                            color: accent,
                                                            fontSize: 12
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                )
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                ],
                              ),
                            ),

                            Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,

                                alignment: Alignment.bottomCenter,
                                child: Navigation()
                            ),

                          ],
                        )
                    );
                  }
              )
          )
      ),
    );
  }
}