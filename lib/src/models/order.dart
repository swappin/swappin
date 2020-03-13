class Order {
  final String _storeName;
  final String _storeAdress;
  final String _storePhoto;
  final num _storeScore;
  final double _storeLatitude;
  final double _storeLongitude;
  final String _status;
  final String _code;
  final String _photo;
  final String _note;
  final String _method;
  final DateTime _initialDate;
  final DateTime _finalDate;
  final num _total;
  final List<dynamic> _productList;
  final List<dynamic> _priceList;
  final List<dynamic> _amountList;

  Order(
    this._storeName,
    this._storeAdress,
    this._storePhoto,
    this._storeScore,
    this._storeLatitude,
    this._storeLongitude,
    this._status,
    this._code,
    this._photo,
    this._note,
    this._method,
    this._initialDate,
    this._finalDate,
    this._total,
    this._productList,
    this._priceList,
    this._amountList,
  );

  String get storeName => _storeName;

  String get storeAdress => _storeAdress;

  String get storePhoto => _storePhoto;

  num get storeScore => _storeScore;

  double get storeLatitude => _storeLatitude;

  double get storeLongitude => _storeLongitude;

  String get status => _status;

  String get code => _code;

  String get photo => _photo;

  String get note => _note;

  String get method => _method;

  DateTime get finalDate => _finalDate;

  DateTime get initialDate => _initialDate;

  num get total => _total;

  List<dynamic> get productList => _productList;

  List<dynamic> get priceList => _priceList;

  List<dynamic> get amountList => _amountList;
}
