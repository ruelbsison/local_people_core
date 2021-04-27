import 'dart:io';
import 'package:flutter/material.dart';
import '../../../core/widgets/loading_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LoginScreen extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => LoginScreen());
  }

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {

  // @override
  // void initState() {
  //   super.initState();
  //   // Enable hybrid composition.
  //   if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  // }

  @override
  Widget build(BuildContext context) {
    /*WebView(
      javascriptMode: JavascriptMode.unrestricted,
      initialUrl: authorizationUrl.toString(),
      navigationDelegate: (navReq) {
        if (navReq.url.startsWith(redirectUrl)) {
          responseUrl = Uri.parse(navReq.url);
          return NavigationDecision.navigate;
        }
        return NavigationDecision.prevent;
      },
    ),*/

    var loading = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(),
        Text(" Authenticating ... Please wait")
      ],
    );

    final theme = Theme.of(context);
    return SafeArea(
        child: Scaffold (
          backgroundColor: theme.primaryColor,
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
                  style: theme.textTheme.headline6,
                ),
              ],
            )
          ),
        ),
    );
  }
}
