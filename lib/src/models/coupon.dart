class Coupon{
  final num _value;
  final String _photo;
  final String _validity;

  Coupon(this._value, this._photo, this._validity);

  num get value => _value;
  String get photo => _photo;
  String get validity => _validity;
}