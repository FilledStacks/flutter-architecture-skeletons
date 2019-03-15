import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:scoped_model_arc/scoped_models/app_model.dart';
import 'package:scoped_model_arc/ui/views/example_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scoped Model Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ScopedModel<AppModel>(
        model: AppModel(),
        child: ExampleView())
    );
  }
}
