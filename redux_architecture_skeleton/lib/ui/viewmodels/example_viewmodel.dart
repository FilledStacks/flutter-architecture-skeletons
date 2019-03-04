import 'package:flutter/foundation.dart';
import 'package:redux/redux.dart';
import 'package:redux_architecture_skeleton/redux/app_state.dart';
import 'package:redux_architecture_skeleton/redux/actions/example_actions.dart';

class ExampleViewModel {
  final String name;

  final String surname;

  final bool hasAccount;

  final Function(String, String, bool) setExampleData;

  ExampleViewModel({
    @required this.name, 
    @required this.surname, 
    @required this.hasAccount,
    @required this.setExampleData});

  // We don't have to use a factory here but it keeps more of the logic in this viewmodel
  // file so all viewmodel changes are done here. 
  factory ExampleViewModel.create(Store<AppState> store) {

    void _setExampleData(String name, String surnmae, bool hasAccount) {
      store.dispatch(SetExampleDataAction(name: name, surname: surnmae, hasAccount: hasAccount));
    }

    return ExampleViewModel(
        name: store.state.example.name,
        surname: store.state.example.surname,
        hasAccount: store.state.example.hasAccount,
        setExampleData: _setExampleData);
  }
}
