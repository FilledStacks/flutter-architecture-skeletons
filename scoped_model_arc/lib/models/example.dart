class Example {
  String name;
  String surname;
  bool hasAccount;

  Example({this.name, this.surname, this.hasAccount});

  Example.initialState() :
  name = '', surname = '', hasAccount = false;
}