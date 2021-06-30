//import '../../authentication//authentication.dart';
//import '../../services/authentication_event.dart';
import 'package:local_people_core/core.dart';
import 'btn_facebook_widget.dart';
import 'btn_google_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../ui/blocs/bloc.dart';

class LoginFormWidget extends StatefulWidget {
  @override
  _LoginFormWidgetState createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  //AuthenticationBloc _authenticationBloc;
  LoginBloc _loginBloc;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  @override
  void initState() {
    //_authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    _loginBloc = BlocProvider.of<LoginBloc>(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.isSuccess) {
          //_authenticationBloc.add(LoggedIn());
        }

        if (state.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Login Failure'),
                    Icon(Icons.error),
                  ],
                ),
                backgroundColor: Colors.red,
              ),
            );
        }

        if (state.isSubmitting) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Processing ...'),
                    CircularProgressIndicator(
                      color: Color.fromRGBO(255, 99, 95, 1),
                    ),
                  ],
                ),
              ),
            );
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(10),
            // color: COLOR_CONST.WHITE,
          ),
          child: Form(
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Login to your account'),
                      //style: FONT_CONST.MEDIUM_DEFAULT_16),
                ),
                SpacerWidget(height: 20),
                _buildTextFieldUsername(),
                SpacerWidget(height: 14),
                _buildTextFieldPassword(),
                SpacerWidget(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Forgot password ?')
                    //style: FONT_CONST.REGULAR_GRAY4_12,
                  ),
                SpacerWidget(height: 20),
                _buildButtonLogin(state),
                SpacerWidget(height: 30),
                _buildTextOr(),
                SpacerWidget(height: 20),
                _buildSocialLogin(),
              ],
            ),
          ),
        );
      }),
    );
  }

  _buildSocialLogin() {
    return Container(
      height: 40,
      child: Row(
        children: <Widget>[
          BtnGoogleWidget(),
          SizedBox(width: 20),
          BtnFacebookWidget(),
        ],
      ),
    );
  }

  _buildTextOr() {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.center,
          child: Divider(
            //color: COLOR_CONST.BLACK_30,
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Container(
            //color: COLOR_CONST.WHITE,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
              child: Text(
                'Or',
                //style: FONT_CONST.REGULAR_GRAY5_10,
              ),
            ),
          ),
        )
      ],
    );
  }

  _buildButtonLogin(LoginState state) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: FlatButton(
        onPressed: () {
          if (isRegisterButtonEnabled()) {
            _loginBloc.add(LoginSubmitEmailPasswordEvent(
              email: _emailController.text,
              password: _passwordController.text,
            ));
          }
        },
        // color: isRegisterButtonEnabled()
        //  ? COLOR_CONST.DEFAULT
        //    : COLOR_CONST.GRAY1_50,
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(7.0),
        ),
        child: Text(
          'Login'.toUpperCase(),
          //style: FONT_CONST.SEMIBOLD_WHITE_18,
        ),
      ),
    );
  }

  bool isRegisterButtonEnabled() {
    return _loginBloc.state.isFormValid &&
        isPopulated &&
        !_loginBloc.state.isSubmitting;
  }

  _buildTextFieldPassword() {
    return Container(
      height: 50,
      padding: EdgeInsets.symmetric(horizontal: 17),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10),
        //color: COLOR_CONST.GRAY3,
      ),
      child: Center(
        child: TextFormField(
          controller: _passwordController,
          onChanged: (value) {
            _loginBloc.add(LoginPasswordChanged(password: value));
          },
          autovalidate: true,
          validator: (_) {
            return !_loginBloc.state.isPasswordValid
                ? 'Invalid Password'
                : null;
          },
          // style: FONT_CONST.REGULAR_GRAY1_12,
          maxLines: 1,
          keyboardType: TextInputType.text,
          obscureText: true,
          textAlign: TextAlign.left,
          decoration: InputDecoration.collapsed(
            hintText: 'Password',
          ),
        ),
      ),
    );
  }

  _buildTextFieldUsername() {
    return Container(
      height: 50,
      padding: EdgeInsets.symmetric(horizontal: 17),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10),
        //color: COLOR_CONST.GRAY3,
      ),
      child: Center(
        child: TextFormField(
          controller: _emailController,
          onChanged: (value) {
            _loginBloc.add(LoginEmailChanged(email: value));
          },
          autovalidate: true,
          validator: (_) {
            return !_loginBloc.state.isEmailValid ? 'Invalid Email' : null;
          },
          // style: FONT_CONST.REGULAR_GRAY1_12,
          maxLines: 1,
          keyboardType: TextInputType.text,
          textAlign: TextAlign.left,
          decoration: InputDecoration.collapsed(
            hintText: 'Email',
          ),
        ),
      ),
    );
  }
}
