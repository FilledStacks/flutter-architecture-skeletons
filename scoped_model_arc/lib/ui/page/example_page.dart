import 'dart:math';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:scoped_model_arc/scoped_models/app_model.dart';

class ExamplePage extends StatefulWidget {
  ExamplePage({Key key}) : super(key: key);

  @override
  _ExamplePageState createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  static const TextStyle titleStyle =
      TextStyle(fontSize: 25.0, fontWeight: FontWeight.w700);

  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppModel>(
        builder: (context, child, model) => Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                model.setExampleData(
                    name: nameController.text,
                    surname: surnameController.text,
                    hasAccount: Random().nextBool());

                // Example of future in the state model
                model.saveDataToDisk().then((f) {
                  print('Saving data complete.');
                });
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
                    Text(model.name),
                    _getVerticalSpacing(20.0),
                    Text('Surname', style: titleStyle),
                    Text(model.surname),
                    _getVerticalSpacing(20.0),
                    Text('hasAccount', style: titleStyle),
                    Text(model.hasAccount.toString()),
                    _getVerticalSpacing(10.0),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          TextField(
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                  hintText: 'Enter name'),
                              controller: nameController),
                          _getVerticalSpacing(10.0),
                          TextField(
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                  hintText: 'Enter surname'),
                              controller: surnameController)
                        ]),
                  ]),
            )));
  }

  Widget _getVerticalSpacing(double height) {
    return Container(height: height);
  }
}
