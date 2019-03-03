import 'package:redux_architecture_skeleton/models/example.dart';

class AppState {
  final Example example;

  AppState({this.example});

  AppState.initialState() : example = Example.initialState();
}