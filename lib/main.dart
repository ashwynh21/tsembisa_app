
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tsembisa/blocs/preferences/preferences_bloc.dart';
import 'package:tsembisa/screens/home/home.dart';

import 'package:tsembisa/screens/splash/introduction/introduction.dart';
import 'package:tsembisa/theme/colors.dart';
import 'package:tsembisa/theme/theme.dart';

void main() {
  Hive.initFlutter();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: accent,
    systemNavigationBarColor: accent,
  ));

  return runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      supportedLocales: [
        const Locale('en', 'US'),
      ],
      theme: PhephaThemeData,
      home: Phepha()
  ));
}

class Phepha extends StatelessWidget {
  /*
  * From the looks of things here we are still going to require the application
  * to start and control the start process of the application from smaller parts
  * of the application...so then let us create the application bloc to get the
  * functionality out...*/
  @override
  Widget build(BuildContext context) {
    return BlocProvider<PreferencesBloc>(
      create: (_) => new PreferencesBloc()..add(CheckPreferences()),

      child: BlocBuilder<PreferencesBloc, PreferencesState>(
          builder: (preferencescontext, state) {
            if(state is NoPreferences)
              return Introduction();
            if(state is FoundPreferences)
              return Home();

            return Container(
              color: accent,
            );
          }
        )
      );
  }
}
