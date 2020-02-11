class Bag {
  final String _userName;
  final String _storeName;
  final String _storeAdress;
  final String _storePhoto;
  final num _storeScore;
  final String _productName;
  final String _code;
  final String _note;
  final String _photo;
  final num _price;
  final num _amount;
  final num _change;

  Bag(
      this._userName,
      this._storeName,
      this._storeAdress,
      this._storePhoto,
      this._storeScore,
      this._productName,
      this._code,
      this._note,
      this._photo,
      this._price,
      this._amount,
      this._change);

  String get userName => _userName;

  String get storeName => _storeName;

  String get storeAdress => _storeAdress;

  String get storePhoto => _storePhoto;

  num get storeScore => _storeScore;

  String get productName => _productName;

  String get code => _code;

  String get note => _note;

  String get photo => _photo;

  num get price => _price;

  num get amount => _amount;

  num get change => _change;
}
