class Panitia {
  String? idPanitia;
  String? kodeEvent;
  String? noIden;
  String? namaPanitia;
  String? jenisKelamin;
  String? rolePanitia;

  Panitia({
    this.idPanitia,
    this.kodeEvent,
    this.noIden,
    this.namaPanitia,
    this.jenisKelamin,
    this.rolePanitia,
  });

  factory Panitia.fromJson(Map<String, dynamic> json) => Panitia(
        idPanitia: json['id_panitia'],
        kodeEvent: json['kode_event'],
        noIden: json['no_iden'],
        namaPanitia: json['nama_panitia'],
        jenisKelamin: json['jenis_kelamin'],
        rolePanitia: json['role_panitia'],
      );

  Map<String, dynamic> toJson() => {
        'id_panitia': this.idPanitia,
        'kode_event': this.kodeEvent,
        'nama_panitia': this.namaPanitia,
        'no_iden': this.noIden,
        'jenis_kelamin': this.jenisKelamin,
        'role_panitia': this.rolePanitia,
      };
}
