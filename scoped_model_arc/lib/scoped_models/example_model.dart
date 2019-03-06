import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/foundation.dart';

import 'package:scoped_model_arc/models/example.dart';
import 'package:scoped_model_arc/services/persistence_serice.dart';

mixin ExampleModel on Model {
  Example _example = Example.initialState();

  PersistenceService persistenceService = PersistenceService.getInstance();

  String get name => _example.name ;

  String get surname => _example.surname;

  bool get hasAccount => _example.hasAccount;

  void setExampleData({
    @required String name,
    @required String surname,
    @required bool hasAccount
  }) {
    _example.name = name;
    _example.surname = surname;
    _example.hasAccount = hasAccount;

  }

  // Future that takes a few seconds to finish
  Future saveDataToDisk() async {
    print('Start to save data');
    await persistenceService.saveExampleToDisk();
  }

}