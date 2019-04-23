import 'package:flutter/material.dart';
import 'package:model_per_view/scoped_models/login_view_model.dart';
import 'package:model_per_view/ui/shared/font_styles.dart';
import 'package:model_per_view/ui/shared/ui_helpers.dart';
import 'package:model_per_view/ui/views/base_view.dart';
import 'package:model_per_view/enums/view_state.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  BaseView<LoginModel>(
        builder: (context, child, model) =>Scaffold(
        backgroundColor: Color.fromARGB(255, 26, 27, 30),
        body: Container(
                padding: EdgeInsets.all(15.0),
                margin: EdgeInsets.only(top: 50.0),
                child: ListView(children: <Widget>[
                  Text('LOGIN', style: viewTitle),
                  UIHelper.verticalSpaceLarge(),
                  UIHelper.inputField(
                      title: 'Email',
                      placeholder: 'Enter username',
                      controller: emailController),
                  UIHelper.verticalSpaceMedium(),
                  UIHelper.inputField(
                      title: 'Password',
                      placeholder: 'Enter password',
                      isPassword: true,
                      controller: passwordController),
                  UIHelper.verticalSpaceMedium(),
                  _getFeedbackUI(model),
                  UIHelper.verticalSpaceMedium(),
                  _getLoginButton(model)
                ]),
              )));
  }

  Widget _getFeedbackUI(LoginModel model) {
    switch (model.state) {
      case ViewState.Busy:
        return Center(
          child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).primaryColor)),
        );
        break;
      case ViewState.Error:
        return Text('Could not log in at this moment');
      case ViewState.Success:
        return Center(child: Text('Login Success'));
      case ViewState.WaitingForInput:
      default:
        return Container();
    }
  }

  Widget _getLoginButton(LoginModel model) {
    return GestureDetector(
      onTap: () async {
        var viewState = model.login(username: 'Test', password: 'password');
        if (viewState == ViewState.Success) {
          // Navigate to a different view here
        }
      },
      child: Container(
        width: double.infinity,
        height: 40.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: Color.fromARGB(255, 9, 202, 172)),
        child: Center(
            child:
                Text('LOGIN', style: TextStyle(fontWeight: FontWeight.w800))),
      ),
    );
  }
}
