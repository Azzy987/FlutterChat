import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterchat/AppTheme.dart';
import 'package:flutterchat/Theme/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool darkMode = false;

void main() {

  runApp(Home());
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
        return BlocProvider(builder: (context)=> ThemeBloc(),
        child: BlocBuilder<ThemeBloc, ThemeState>(builder: (BuildContext context,ThemeState state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: state.themeData,
            home: OnBoardingScreens(),
          );
        },

        )
        );
  }
}

class OnBoardingScreens extends StatefulWidget {
  @override
  _OnBoardingScreensState createState() => _OnBoardingScreensState();
}

class _OnBoardingScreensState extends State<OnBoardingScreens> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hello'),
        actions: <Widget>[
          darkMode
              ? IconButton(
                  icon: Icon(Icons.brightness_4),
                  onPressed: (){
                    darkMode = false;
                   // setSelectedTheme(darkMode);
                    BlocProvider.of<ThemeBloc>(context).dispatch(ThemeChanged(theme: AppTheme.BlueLight));
                  },
                )
              : IconButton(
                  icon: Icon(Icons.brightness_6),
                  onPressed: (){
                    darkMode = true;
                    //setSelectedTheme(darkMode);
                    BlocProvider.of<ThemeBloc>(context).dispatch(ThemeChanged(theme: AppTheme.BlueDark));

                  })
        ],
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return SecondScreen();
            }));
          },
          child: Text('Second'),
        ),
      ),
    );
  }
  Future<void> setSelectedTheme(bool value) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool("darkMode", value);
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Center(
          child: Text('hello second'),
        ),
      ),
    );
  }
}
