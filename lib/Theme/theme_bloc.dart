import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../AppTheme.dart';
import './bloc.dart';

bool dark;


class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  @override

  ThemeState get initialState =>
      // Everything is accessible from the appThemeData Map.
      ThemeState(
          themeData: appThemeData[getSelectedTheme() == true
              ? AppTheme.BlueDark
              : AppTheme.BlueLight]);

  @override
  Stream<ThemeState> mapEventToState(
    ThemeEvent event,
  ) async* {
    if (event is ThemeChanged) {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      yield ThemeState(themeData: appThemeData[event.theme]);
      if (event.theme == AppTheme.BlueDark) {
        dark = true;
        print('dark $dark');
      } else {
        dark = false;
        print('dark $dark');

      }
      sharedPreferences.setBool("darkMode", dark);
      print(event.theme);
    }
  }

  Future<bool> getSelectedTheme() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
     dark = sharedPreferences.getBool("darkMode");
    print('Dark Theme : $dark');
    return dark;
  }

  ThemeData getTheme() {
    if (getSelectedTheme() == true) {
      return appThemeData[AppTheme.BlueDark];
    } else if (getSelectedTheme() == false) {
      return appThemeData[AppTheme.BlueLight];
    }
    return appThemeData[AppTheme.BlueLight];
  }
}
