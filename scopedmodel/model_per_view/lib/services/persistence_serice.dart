class PersistenceService {
  static PersistenceService _instance;

  static PersistenceService getInstance() { 
    if(_instance == null) {
      _instance =PersistenceService();
    }

    return _instance;
  }

  Future<bool> saveExampleToDisk() async {
    await Future.delayed(Duration(seconds: 2));
    return true;
  }
}