import 'package:redux_architecture_skeleton/models/example.dart';
import 'package:redux_architecture_skeleton/redux/app_state.dart';
import 'package:redux_architecture_skeleton/redux/actions/example_actions.dart';

AppState appStateReducer(AppState state, action) {
  return AppState(
    example: exampleReducer(state.example, action)
  );
}

Example exampleReducer(Example state, action) {
  if(action is SetExampleDataAction) {
    return Example(
      name: action.name,
      surname: action.surname,
      hasAccount: action.hasAccount
    );
  }

  if(action is ClearExampleDataAction) {
    return Example.initialState();
  }

  // If there is logic defined for this action then return
  // the state passed in
  return state;
}