import 'package:scoped_model/scoped_model.dart';
import 'package:model_per_view/services/user_service.dart';
import 'package:model_per_view/service_locator.dart';
import 'base_model.dart';

export 'package:model_per_view/enums/view_state.dart';

class LoginModel extends BaseModel {
  UserService _userService = locator<UserService>();

  Future<bool> login({String username, String password}) async {
    // Update state to loading so we can show indicator
     setState(ViewState.Busy);

    var loginResult =
        await _userService.loginUser(username: username, password: password);

    // determine state of the view based on response.
    var loginStateBasedOnReponse =
        loginResult ? ViewState.Success : ViewState.Error;

    // Update the view state based on the response
    setState(loginStateBasedOnReponse);

    return true;
  }
}
