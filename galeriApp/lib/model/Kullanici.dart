class Kullanici{

  late String _username;
  late String _isim;
  late String _soyisim;
  late String _password;
  late String _telefonNo;

  Kullanici(this._username, this._isim, this._soyisim, this._password,
      this._telefonNo);

  String get telefonNo => _telefonNo;

  set telefonNo(String value) {
    _telefonNo = value;
  }

  String get password => _password;

  set password(String value) {
    _password = value;
  }

  String get soyisim => _soyisim;

  set soyisim(String value) {
    _soyisim = value;
  }

  String get isim => _isim;

  set isim(String value) {
    _isim = value;
  }

  String get username => _username;

  set username(String value) {
    _username = value;
  }

}