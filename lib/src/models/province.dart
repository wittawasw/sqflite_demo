class Province {
  final String code;
  final String nameTH;
  final String nameEN;

  const Province(this.code, this.nameTH, this.nameEN);

  Province.fromJson(Map<String, dynamic> json)
      : code = json['code'] as String,
        nameTH = json['name_th'] as String,
        nameEN = json['name_en'] as String;
}
