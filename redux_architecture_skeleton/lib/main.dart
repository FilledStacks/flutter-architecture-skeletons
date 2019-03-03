import 'package:flutter/material.dart';
import 'package:redux_dev_tools/redux_dev_tools.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_architecture_skeleton/redux/app_state.dart';
import 'package:redux_architecture_skeleton/redux/reducers.dart';
import 'package:redux_architecture_skeleton/redux/middleware.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final DevToolsStore<AppState> store = DevToolsStore<AppState>(appStateReducer,
      initialState: AppState.initialState(),
      middleware: createAppStateMiddleware());

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: 'Redux architecture starting kit',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: StoreBuilder<AppState>(
            builder: (BuildContext context, Store<AppState> store) => Column()),
      ),
    );
  }
}

class _ExampleViewModel {
  final String name;

  final String surname;

  final bool hasAccount;

  _ExampleViewModel(
      {@required this.name, @required this.surname, @required this.hasAccount});

  factory _ExampleViewModel.create(Store<AppState> store) {
    return _ExampleViewModel(
        name: store.state.example.name,
        surname: store.state.example.surname,
        hasAccount: store.state.example.hasAccount);
  }
}

class ExampleView extends StatelessWidget {
  ExampleView();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ExampleViewModel>(
        // Converter is a function that takes the store and converts it
        // into the viewmodel that we want to pass to the decendent widget.
        // This can be as granular as we want it to be.
        converter: (Store<AppState> store) => _ExampleViewModel.create(store),
        builder: (BuildContext context, _ExampleViewModel viewModel) =>
            Scaffold(
                body: Column(children: <Widget>[
                  Row(children: [Text('Name:'), Text(viewModel.name)]),
                  Row(children: [Text('Surname:'), Text(viewModel.surname)]),
                  Row(children: [
                    Text('hasAccount:'),
                    Text(viewModel.hasAccount.toString())
                  ]),
        ])));
  }
}
