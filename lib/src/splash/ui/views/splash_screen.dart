import '../blocs/splash_bloc.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/*class SplashScreen extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => SplashScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          "assets/images/app-icon.png",
          key: const Key('splash_bloc_image'),
          height: 300.0,
          width: 300.0,
        ),
      ),
    );
  }
}*/

class SplashScreen extends StatefulWidget {
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
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        //color: Colors.blue,
        child: _buildSplashWidget(),
        /*child: BlocProvider(
          create: (_) => _splashBloc,
          child: BlocListener<SplashBloc, SplashState>(
            listener: (context, state) {
              if (state is SplashLoaded) {
                /* AppRouter.pushPageReplacement(
                  context,
                  MainScreen(),
                ); */
              }
            },
            child: _buildSplashWidget(),
          ),
        ),*/
      ),
    );
  }

  Widget _buildSplashWidget() {
    //BlocProvider.of<SplashBloc>(context).add(SplashEventStarted());
    //_splashBloc.add(SplashEventStarted());
    startTimeout();
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            "assets/images/company-logo.png",
            height: 300.0,
            width: 300.0,
          ),
        ],
      ),
    );
  }
}
