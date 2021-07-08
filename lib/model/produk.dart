class Produk {
  final int kode;
  final String namaBarang;
  final String jenis;
  final int harga;
  final int stok;

  Produk(
      {required this.kode,
      required this.namaBarang,
      required this.jenis,
      required this.harga,
      required this.stok});

  factory Produk.fromJson(Map<String, dynamic> json) {
    return Produk(
      kode: json['kode'],
      namaBarang: json['nama_barang'],
      jenis: json['jenis'],
      harga: json['harga'],
      stok: json['stok'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kode'] = this.kode;
    data['nama_barang'] = this.namaBarang;
    data['jenis'] = this.jenis;
    data['harga'] = this.harga;
    data['stok'] = this.stok;
    return data;
  }
}
