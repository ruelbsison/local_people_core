import 'package:flutter/material.dart';
import '../../../core/widgets/loading_widget.dart';

class LoginScreen extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => LoginScreen());
  }

  @override
  Widget build(BuildContext context) {
    /*final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text('⛅', style: TextStyle(fontSize: 64)),
        Text(
          'Loading Weather',
          style: theme.textTheme.headline5,
        ),
        Center (
          //padding: EdgeInsets.all(16.0),
          child: LoadingWidget(),
        ),
      ],
    );*/
    final theme = Theme.of(context);
    return Scaffold(
      body: Center (
        //child: LoadingWidget(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding (
              padding: EdgeInsets.all(16.0),
              child: LoadingWidget(),
            ),
            //const Text('⛅', style: TextStyle(fontSize: 64)),
            Text(
              'Verifying access',
              style: theme.textTheme.headline5,
            ),
          ],
        )
      ),
    );
  }
}
