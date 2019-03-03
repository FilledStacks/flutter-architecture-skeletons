import 'dart:math';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:redux_dev_tools/redux_dev_tools.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_architecture_skeleton/redux/app_state.dart';
import 'package:redux_architecture_skeleton/redux/reducers.dart';
import 'package:redux_architecture_skeleton/redux/middleware.dart';
import 'package:redux_architecture_skeleton/redux/actions/example_actions.dart';

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
            builder: (BuildContext context, Store<AppState> store) => ExampleView()),
      ),
    );
  }
}

class _ExampleViewModel {
  final String name;

  final String surname;

  final bool hasAccount;

  final Function(String, String, bool) setExampleData;

  _ExampleViewModel({
    @required this.name, 
    @required this.surname, 
    @required this.hasAccount,
    @required this.setExampleData});

  factory _ExampleViewModel.create(Store<AppState> store) {

    void _setExampleData(String name, String surnmae, bool hasAccount) {
      store.dispatch(SetExampleDataAction(name: name, surname: surnmae, hasAccount: hasAccount));
    }

    return _ExampleViewModel(
        name: store.state.example.name,
        surname: store.state.example.surname,
        hasAccount: store.state.example.hasAccount,
        setExampleData: _setExampleData);
  }
}

class ExampleView extends StatefulWidget {
  @override
  _ExampleViewState createState() => _ExampleViewState();
}

class _ExampleViewState extends State<ExampleView> {

  TextEditingController name = TextEditingController();
  TextEditingController surname =TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ExampleViewModel>(
        // Converter is a function that takes the store and converts it
        // into the viewmodel that we want to pass to the decendent widget.
        // This can be as granular as we want it to be.
        converter: (Store<AppState> store) => _ExampleViewModel.create(store),
        builder: (BuildContext context, _ExampleViewModel viewModel) =>
            Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: (){
                  viewModel.setExampleData(
                    '${viewModel.name} - ${Random().nextInt(100)}',
                    '${viewModel.surname} - ${Random().nextInt(100)}',
                    Random().nextBool()
                  );
                },
              ),
                body: Column(children: <Widget>[
                  Container(height: 55.0),
                  Row(children: [Text('Name:'), Text(viewModel.name)]),
                  Row(children: [Text('Surname:'), Text(viewModel.surname)]),
                  Row(children: [
                    Text('hasAccount:'),
                    Text(viewModel.hasAccount.toString())
                  ]),
        ])));
  }
}
