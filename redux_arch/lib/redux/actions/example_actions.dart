/// This file contains examples of actions. For organizational purposes
/// I would recommend adding all the actions related to a model or functionality
/// in one file.

class SetExampleDataAction {
  final String name;
  final String surname;
  final bool hasAccount;

  SetExampleDataAction({this.name, this.surname, this.hasAccount});

  @override
  String toString() {
    // TODO: implement toString
    return '$name $surname, account: $hasAccount';
  }
}

/// Action fired when we want to reset the example data in AppState
class ClearExampleDataAction {}

/// Action fired when the middleware example action has been completed
class MiddlewareExampleCompleteAction {}