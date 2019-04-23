import 'package:flutter/material.dart';
import 'package:model_per_view/scoped_models/sign_up_view_model.dart';
import 'package:model_per_view/ui/shared/font_styles.dart';
import 'package:model_per_view/ui/shared/ui_helpers.dart';
import 'package:model_per_view/ui/views/base_view.dart';

class SignUpView extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUpView> {
  String _passwordConfirmaionValidation;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool get _hasEnteredInformation =>
      emailController.text != '' &&
      passwordController.text != '' &&
      confirmPasswordController.text != '';

  @override
  Widget build(BuildContext context) {
    return BaseView<SignUpModel>(
        builder: (context, child, model) => Scaffold(
        backgroundColor: Color.fromARGB(255, 26, 27, 30),
        body: Container(
          padding: EdgeInsets.all(15.0),
          margin: EdgeInsets.only(top: 50.0),
          child: ListView(children: <Widget>[
            Text('SIGN UP', style: viewTitle),
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
            UIHelper.inputField(
                title: 'Confirm Password',
                placeholder: 'Confirm password',
                isPassword: true,
                controller: confirmPasswordController,
                validationMessage: _passwordConfirmaionValidation),
            _getFeedbackUI(model),
            UIHelper.verticalSpaceMedium(),
            _getSignUpButton(model)
          ]),
        )));
  }

  Widget _getFeedbackUI(SignUpModel model) {
    switch (model.state) {
      case ViewState.Busy:
        return Container(
          margin: EdgeInsets.only(top: 10.0),
          child: Center(
            child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor)),
          ),
        );
        break;
      case ViewState.Error:
        // NOTE: Place your Login error UI here
        return Center(child: Text('Could not sign up at this moment'));
      case ViewState.Success:
        // NOTE: Place your login success UI here
        return Center(child: Text('Signup Success'));
      case ViewState.WaitingForInput:
      default:
        return Container();
    }
  }

  Widget _getSignUpButton(SignUpModel model) {
    return UIHelper.fullScreenButton(
        title: 'SIGN UP',
        onTap: () async {
          var passwordValidationMessage = model.checkConfirmationPasswordValid(
              password: passwordController.text,
              confirmationPassword: confirmPasswordController.text);

          // No validation errors. Perform signup
          if (passwordValidationMessage == null && _hasEnteredInformation) {
            var viewState =
                model.signUpUser(username: 'Test', password: 'password');
            if (viewState == ViewState.Success) {
              // Navigate to a different view here
            }
          } else {
            setState(() {
              _passwordConfirmaionValidation = passwordValidationMessage;
            });
          }
        });
  }
}
