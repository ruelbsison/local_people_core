import 'package:flutter/material.dart';
//import '../blocs/splash_bloc.dart';
//import 'dart:async';
//import 'package:flutter/material.dart';
//import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/widgets/logo_widget.dart';

class SplashScreen extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => SplashScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: SizedBox(
            width: 240,
            child: LogoWidget(),
          ),
        ),
      ),
    );
  }
}

/*class SplashScreen extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => SplashScreen());
  }

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //final SplashBloc _splashBloc = SplashBloc(SplashStateNotStarted());
  //SplashBloc _splashBloc;

  startTimeout() {
    return new Timer(Duration(seconds: 2), handleTimeout);
  }

  void handleTimeout() {
    splashCompleted();
  }

  splashCompleted() async {
    BlocProvider.of<SplashBloc>(context).add(SplashEventCompleted());
    //_splashBloc.add(SplashEventCompleted());
  }

  @override
  void initState() {
    super.initState();
    //BlocProvider.of<SplashBloc>(context).add(SplashEventStarted());
    //_splashBloc.add(SplashEventStarted());
    //startTimeout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: SizedBox(
            width: 240,
            child: LogoWidget(),
          ),
        ),
      ),
    );
  }
}*/
