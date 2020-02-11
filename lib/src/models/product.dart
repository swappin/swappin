class Product {
  final String _name;
  final String _code;
  final String _photo;
  final String _description;
  final String _storeName;
  final String _storeAdress;
  final String _storePhoto;
  final num _storeScore;
  final num _distance;
  final num _price;
  final num _promotionPrice;
  final bool _isPromotion;
  final bool _isEnable;
  final List<dynamic> _productKeywords;

  Product(
    this._name,
    this._code,
    this._photo,
    this._description,
    this._storeName,
    this._storeAdress,
    this._storePhoto,
    this._storeScore,
    this._distance,
    this._price,
    this._promotionPrice,
    this._isPromotion,
    this._isEnable,
    this._productKeywords,
  );

  String get name => _name;

  String get code => _code;

  String get photo => _photo;

  String get description => _description;

  String get storeName => _storeName;

  String get storeAdress => _storeAdress;

  String get storePhoto => _storePhoto;

  num get storeScore => _storeScore;

  num get distance => _distance;

  num get price => _price;

  num get promotionPrice => _promotionPrice;

  bool get isPromotion => _isPromotion;

  bool get isEnable => _isEnable;

  List<dynamic> get productKeywords => _productKeywords;
}
