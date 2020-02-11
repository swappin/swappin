class User {
  final num _id;
  final String _name;
  final String _email;
  final String _cpf;
  final String _birth;
  final String _genre;
  final String _photo;
  final num _range;
  final num _experience;
  final Map<dynamic, dynamic> _badges;


  User(this._id, this._name, this._email, this._cpf, this._birth, this._genre, this._photo, this._range, this._experience, this._badges);

   num get id => _id;
   String get name => _name;
   String get email => _email;
   String get cpf => _cpf;
   String get birth => _birth;
   String get genre => _genre;
   String get photo => _photo;
   num get range => _range;
   num get experience => _experience;
   Map<dynamic, dynamic> get badges => _badges;
}
