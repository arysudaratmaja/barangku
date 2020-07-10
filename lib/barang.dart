class Barang {
  int _id;
  String _nama;
  String _kode;
  String _harga;

  // konstruktor versi 1
  Barang(this._nama, this._kode, this._harga);

  // konstruktor versi 2: konversi dari Map ke Barang
  Barang.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._nama = map['nama'];
    this._kode = map['kode'];
    this._harga = map['harga'];
  }

  //getter dan setter (mengambil dan mengisi data kedalam object)
  // getter
  int get id => _id;
  String get nama => _nama;
  String get kode => _kode;
  String get harga=> _harga;
  // setter
  set nama(String value) {
    _nama = value;
  }
  set kode(String value) {
    _kode = value;
  }
  set harga(String value){
    _harga = value;
  }

  // konversi dari Barang ke Map
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = this._id;
    map['nama'] = nama;
    map['kode'] = kode;
    map['harga'] = harga;
    return map;
  }
}