import 'package:scoped_model/scoped_model.dart';
import 'package:model_per_view/services/user_service.dart';
import 'package:model_per_view/service_locator.dart';
import 'base_model.dart';

export 'package:model_per_view/enums/view_state.dart';

class SignUpModel extends BaseModel {
  UserService _userService = locator<UserService>();

  Future<bool> signUpUser({String username, String password}) async {
    // Update state to loading so we can show indicator
     setState(ViewState.Busy);

    var signUpResponse =
        await _userService.signupUser(username: username, password: password);

    // determine state of the view based on response
    var signupStateBasedOnResponse =
        signUpResponse ? ViewState.Success : ViewState.Error;

    // Update the view state based on the response
   setState(signupStateBasedOnResponse);

    // Return the state so wherever the function was called van perform further functionality.
    // Example. Show a dialog to the user indicating that there was a failure
    return true;
  }

  String checkConfirmationPasswordValid(
      {String password, String confirmationPassword}) {
    if (password != confirmationPassword) {
      return 'Please confirm that your passwords are the same';
    }

    return null;
  }
}
