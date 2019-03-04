import 'dart:math';

import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_dev_tools/redux_dev_tools.dart';
import 'package:flutter_redux_dev_tools/flutter_redux_dev_tools.dart';

import 'package:redux_architecture_skeleton/ui/viewmodels/example_viewmodel.dart';
import 'package:redux_architecture_skeleton/redux/app_state.dart';

class ExampleView extends StatefulWidget {
  @override
  _ExampleViewState createState() => _ExampleViewState();
}

class _ExampleViewState extends State<ExampleView> {
  static const TextStyle titleStyle = TextStyle(fontSize: 25.0, fontWeight: FontWeight.w700);

  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ExampleViewModel>(
        // Converter is a function that takes the store and converts it
        // into the viewmodel that we want to pass to the decendent widget.
        // This can be as granular as we want it to be.
        converter: (Store<AppState> store) => ExampleViewModel.create(store),
        builder: (BuildContext context, ExampleViewModel viewModel) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                viewModel.setExampleData(
                    nameController.text,
                    surnameController.text,
                    Random().nextBool());
              },
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                _getVerticalSpacing(20.0),
                Text('Name', style: titleStyle),
                Text(viewModel.name),
                _getVerticalSpacing(20.0),
                Text('Surname', style: titleStyle),
                Text(viewModel.surname),
                _getVerticalSpacing(20.0),
                Text('hasAccount', style: titleStyle),
                Text(viewModel.hasAccount.toString()),
                _getVerticalSpacing(10.0),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                  TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Colors.grey[200],
                      hintText: 'Enter name'
                    ),
                    controller: nameController),
                    _getVerticalSpacing(10.0),
                    TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Colors.grey[200],
                      hintText: 'Enter surname'
                    ),
                    controller: surnameController)
                ]),    
              ]),
            ));
        });
  }

  Widget _getVerticalSpacing(double height) {
    return Container(height: height);
  }
}
