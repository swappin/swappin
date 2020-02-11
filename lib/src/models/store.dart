class Store {
  final String _name;
  final String _adress;
  final String _photo;
  final String _delivery;
  final String _description;
  final double _latitude;
  final double _longitude;
  final double _meter;
  final num _score;
  final List _subcategories;

  Store(
      this._name,
      this._adress,
      this._photo,
      this._delivery,
      this._description,
      this._meter,
      this._latitude,
      this._longitude,
      this._score,
      this._subcategories,
      );

  String get name => _name;

  String get adress => _adress;

  String get photo => _photo;

  String get delivery => _delivery;

  String get description => _description;

  double get meters => _meter;

  double get latitude => _latitude;

  double get longitude => _longitude;

  num get score => _score;

  List get subcategories => _subcategories;
}
