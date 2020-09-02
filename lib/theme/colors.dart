/*
this file will be used to setup the colors that we are going to be using in the
application. the idea here, since this is an upgrade of the old application is
to use material colors only so that they are able to integrate with the theme.

to note, we had to use actual const numbers to initialize the material colors
because when i used the alpha channel to adjust the opacity of the color it
wouldn't return a constant color so this is why,
 */

import 'package:flutter/material.dart';

const MaterialColor
  primary = const MaterialColor(0xFF2F563B, <int, Color>{
    50: Color(0x112F563B),
    100: Color(0x2A2F563B),
    200: Color(0x432F563B),
    300: Color(0x5C2F563B),
    400: Color(0x752F563B),
    500: Color(0x8E2F563B),
    600: Color(0xA72F563B),
    700: Color(0xC02F563B),
    800: Color(0xD92F563B),
    900: Color(0xFF2F563B),
  }),
  secondary = MaterialColor(0xFF8B9C68, <int, Color>{
    50: Color(0x118B9C68),
    100: Color(0x2A8B9C68),
    200: Color(0x438B9C68),
    300: Color(0x5C8B9C68),
    400: Color(0x758B9C68),
    500: Color(0x8E8B9C68),
    600: Color(0xA78B9C68),
    700: Color(0xC08B9C68),
    800: Color(0xD98B9C68),
    900: Color(0xFF8B9C68),
  }),
  accent = MaterialColor(0xFFBE8F3F, <int, Color>{
    50: Color(0x11BE8F3F),
    100: Color(0x2ABE8F3F),
    200: Color(0x43BE8F3F),
    300: Color(0x5CBE8F3F),
    400: Color(0x75BE8F3F),
    500: Color(0x8EBE8F3F),
    600: Color(0xA7BE8F3F),
    700: Color(0xC0BE8F3F),
    800: Color(0xD9BE8F3F),
    900: Color(0xFFBE8F3F),
  }),
  google = const MaterialColor(0xFFDC4E41, <int, Color>{
    50: Color(0x11DC4E41),
    100: Color(0x2ADC4E41),
    200: Color(0x43DC4E41),
    300: Color(0x5CDC4E41),
    400: Color(0x75DC4E41),
    500: Color(0x8EDC4E41),
    600: Color(0xA7DC4E41),
    700: Color(0xC0DC4E41),
    800: Color(0xD9DC4E41),
    900: Color(0xFFDC4E41),
  }),
  facebook = const MaterialColor(0xFF3B5998, <int, Color>{
    50: Color(0x113B5998),
    100: Color(0x2A3B5998),
    200: Color(0x433B5998),
    300: Color(0x5C3B5998),
    400: Color(0x753B5998),
    500: Color(0x8E3B5998),
    600: Color(0xA73B5998),
    700: Color(0xC03B5998),
    800: Color(0xD93B5998),
    900: Color(0xFF3B5998),
  }),
  highlight = const MaterialColor(0xFF00AA00, <int, Color>{
    50: Color(0x1100AA00),
    100: Color(0x2A00AA00),
    200: Color(0x4300AA00),
    300: Color(0x5C00AA00),
    400: Color(0x7500AA00),
    500: Color(0x8E00AA00),
    600: Color(0xA700AA00),
    700: Color(0xC000AA00),
    800: Color(0xD900AA00),
    900: Color(0xFF00AA00),
  }),
  error = const MaterialColor(0xFF880000, <int, Color>{
  50: Color(0x11880000),
  100: Color(0x2A880000),
  200: Color(0x43880000),
  300: Color(0x5C880000),
  400: Color(0x75880000),
  500: Color(0x8E880000),
  600: Color(0xA7880000),
  700: Color(0xC0880000),
  800: Color(0xD9880000),
  900: Color(0xFF880000),
  });