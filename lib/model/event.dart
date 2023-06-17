class Event {
  String? kodeEvent;
  String? namaEvent;
  String? deskripsiEvent;
  String? kodeKegiatan;
  String? tanggal;

  Event(
      {this.kodeEvent,
      this.namaEvent,
      this.kodeKegiatan,
      this.deskripsiEvent,
      this.tanggal});

  factory Event.fromJson(Map<String, dynamic> json) => Event(
        kodeEvent: json['kode_event'],
        namaEvent: json['nama_event'],
        deskripsiEvent: json['deskripsi_event'],
        kodeKegiatan: json['kode_kegiatan'],
        tanggal: json['tanggal'],
      );

  Map<String, dynamic> toJson() => {
        'kode_event': this.kodeEvent,
        'nama_event': this.namaEvent,
        'deskripsi_event': this.deskripsiEvent,
        'kode_kegiatan': this.kodeKegiatan,
        'tanggal': this.tanggal
      };
}
