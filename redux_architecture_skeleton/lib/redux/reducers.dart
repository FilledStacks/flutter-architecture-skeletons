import 'package:redux_architecture_skeleton/models/example.dart';
import 'package:redux_architecture_skeleton/redux/app_state.dart';
import 'package:redux_architecture_skeleton/redux/actions/example_actions.dart';

// What does a reducer do? tl;dr
// A reducer returns a new state based on the action passed through the store.

AppState appStateReducer(AppState state, action) {
  // The app state reducer returns a new instance of AppState where all
  // of it values are passed through their own reducers
  return AppState(
    example: exampleReducer(state.example, action)
    // <---- Here you would add a reducer for each of your modifiable AppState members
  );
}

// This reducer is specifically for Example. It receives the same action that
// the AppState reducer receives but it only operates on the example value from the current state
Example exampleReducer(Example state, action) {
  // For each action type return a new instance of Example

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