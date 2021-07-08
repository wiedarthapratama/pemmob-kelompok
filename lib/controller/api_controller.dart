import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tugas11kelompok/model/produk.dart';

class ApiController {
  Future<int> login(String email, String password) async {
    // try {
    final response = await http.post(
        Uri.parse("https://api.yotowawa.com/public/api/login"),
        body: jsonEncode({"email": email, "password": password}),
        headers: {"Content-Type": "application/json"});
    print(response.body);
    if (response.statusCode == 200) {
      var hasil = jsonDecode(response.body);
      return hasil['code'];
    } else {
      return 500;
    }
  }

  Future<List<Produk>> getProduk() async {
    final response =
        await http.get(Uri.parse("https://api.yotowawa.com/public/api/produk"));
    print(response.body);
    if (response.statusCode == 200) {
      var bodyDecode = jsonDecode(response.body);
      List<dynamic> body = bodyDecode['data'];

      List<Produk> data = body
          .map(
            (dynamic item) => Produk.fromJson(item),
          )
          .toList();

      return data;
    } else {
      throw Exception("error saat mengambil data");
    }
  }

  Future<int> addProduk(
      String namaBarang, String jenis, String stok, String harga) async {
    // try {
    final response = await http.post(
        Uri.parse("https://api.yotowawa.com/public/api/produk"),
        body: jsonEncode({
          "nama_barang": namaBarang,
          "jenis": jenis,
          "stok": stok,
          "harga": harga
        }),
        headers: {"Content-Type": "application/json"});
    print(response.body);
    if (response.statusCode == 200) {
      var hasil = jsonDecode(response.body);
      return hasil['code'];
    } else {
      return 500;
    }
  }

  Future<int> deleteProduk(String id) async {
    // try {
    final response = await http.delete(
        Uri.parse("https://api.yotowawa.com/public/api/produk/$id"),
        headers: {"Content-Type": "application/json"});
    print(response.body);
    if (response.statusCode == 200) {
      var hasil = jsonDecode(response.body);
      return hasil['code'];
    } else {
      return 500;
    }
  }

  Future<int> updateProduk(String id, String namaBarang, String jenis,
      String stok, String harga) async {
    // try {
    final response = await http.put(
        Uri.parse("https://api.yotowawa.com/public/api/produk/$id"),
        body: jsonEncode({
          "nama_barang": namaBarang,
          "jenis": jenis,
          "stok": stok,
          "harga": harga
        }),
        headers: {"Content-Type": "application/json"});
    print(response.body);
    if (response.statusCode == 200) {
      var hasil = jsonDecode(response.body);
      return hasil['code'];
    } else {
      return 500;
    }
  }
}
