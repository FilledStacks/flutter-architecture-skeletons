class Example {
  final String name;
  final String surname;
  final bool hasAccount;

  Example({this.name, this.surname, this.hasAccount});

  Example.initialState() :
  name ='',
  surname = '',
  hasAccount = false;
}