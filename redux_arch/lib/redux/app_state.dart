import 'package:redux_arch/models/example.dart';

class AppState {
  final Example example;

  AppState({this.example});

  AppState.initialState() : example = Example.initialState();
}