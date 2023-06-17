class Kegiatan {
  String? kodeKegiatan;
  String? namaKegiatan;
  String? jenisKegiatan;

  Kegiatan({
    this.kodeKegiatan,
    this.namaKegiatan,
    this.jenisKegiatan,
  });

  factory Kegiatan.fromJson(Map<String, dynamic> json) => Kegiatan(
        kodeKegiatan: json['kode_kegiatan'],
        namaKegiatan: json['nama_kegiatan'],
        jenisKegiatan: json['jenis_kegiatan'],
      );

  Map<String, dynamic> toJson() => {
        'kode_kegiatan': this.kodeKegiatan,
        'nama_kegiatan': this.namaKegiatan,
        'jenis_kegiatan': this.jenisKegiatan,
      };
}
