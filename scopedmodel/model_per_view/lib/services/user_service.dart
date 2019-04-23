import 'dart:convert';

import 'package:model_per_view/services/web_service.dart';
import 'package:model_per_view/models/user.dart';
import 'package:model_per_view/service_locator.dart';

/// Manages all user related interactions with the API and internals
class UserService {

  final WebService _webService = locator<WebService>();

  User _user;

  User get currentUser => _user;

  Future<bool> loginUser({String username, String password}) async {
     var loginResponse =
        await _webService.login(username: username, password: password);

      if(!loginResponse.hasError) {
        var userFromLogin = User.fromJson(json.decode(loginResponse.body));

        if(userFromLogin != null) {
          _user = userFromLogin;
          // NOTE: Save user to the shared preferences here
        }
      }

      return !loginResponse.hasError;
  }

  Future<bool> signupUser({String username, String password}) async {
     var signupResponse =
        await _webService.signup(username: username, password: password);

      if(!signupResponse.hasError) {
        var userFromSignup = User.fromJson(json.decode(signupResponse.body));

        if(userFromSignup != null) {
          _user = userFromSignup;
          // NOTE: Save user or token to the shared preferences here for next start
        }
      }

      return !signupResponse.hasError;
  }

  Future<bool> checkForUser() async {

    // NOTE: Check persistence service here if a user has been stored. If
    // null return false else return true

    return true;
  }
}