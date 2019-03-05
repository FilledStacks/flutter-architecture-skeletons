import 'package:redux/redux.dart';

import 'package:redux_arch/redux/app_state.dart';
import 'package:redux_arch/redux/actions/example_actions.dart';

List<Middleware<AppState>> createAppStateMiddleware() {
  return [

    // Typed middleware is more exmplicit and easier to follow. I find it useful
    // for when you want to write specific pieces of logic for certain actions 
    // only and keep it separated from the rest of the code.
    
    TypedMiddleware<AppState, SetExampleDataAction>(_exampleMiddleAction()),

    // You can also define non-typed middleware or generic middleware which will be run
    // for every action that is dispatced through the store. Somthing like logging all
    // actions can be done here
    _logAllActions()
  ];
}

Middleware<AppState> _exampleMiddleAction() {
  return (Store<AppState> store, action, NextDispatcher next) async {
    // Pass action on to the application to update the state
    next(action);

    // Do something here with the sate. Maybe Save it to disk
    await Future.delayed(Duration(seconds: 1));

    // Then dispatch an action if you want or do nothing
    next(MiddlewareExampleCompleteAction());
  };
}

Middleware<AppState> _logAllActions() {
  return (Store<AppState> store, action, NextDispatcher next) async {
    // Pass action on to the application to update the state
    next(action);

    print('${action.runtimeType} : ${action.toString()}');
  };
}