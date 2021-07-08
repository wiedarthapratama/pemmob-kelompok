import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tugas11kelompok/controller/api_controller.dart';
import 'package:tugas11kelompok/model/produk.dart';

class EditPage extends StatefulWidget {
  @override
  _EditPageState createState() => _EditPageState();
  final Produk produk;
  EditPage(this.produk);
}

class _EditPageState extends State<EditPage> {
  TextEditingController namaCtrl = TextEditingController();
  TextEditingController jenisCtrl = TextEditingController();
  TextEditingController stokCtrl = TextEditingController();
  TextEditingController hargaCtrl = TextEditingController();

  ApiController apiController = ApiController();

  @override
  void initState() {
    namaCtrl.text = widget.produk.namaBarang;
    jenisCtrl.text = widget.produk.jenis;
    stokCtrl.text = widget.produk.stok.toString();
    hargaCtrl.text = widget.produk.harga.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        title: Text('Edit Form'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 16.0),
                    child: TextFormField(
                      controller: namaCtrl,
                      decoration: InputDecoration(
                          border: InputBorder.none, labelText: 'Nama Produk'),
                    ),
                  )),
              SizedBox(
                height: 10,
              ),
              Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 16.0),
                    child: TextFormField(
                      controller: jenisCtrl,
                      decoration: InputDecoration(
                          border: InputBorder.none, labelText: 'Jenis'),
                    ),
                  )),
              SizedBox(
                height: 10,
              ),
              Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 16.0),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: stokCtrl,
                      decoration: InputDecoration(
                          border: InputBorder.none, labelText: 'Stok'),
                    ),
                  )),
              SizedBox(
                height: 10,
              ),
              Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 16.0),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: hargaCtrl,
                      decoration: InputDecoration(
                          border: InputBorder.none, labelText: 'Harga'),
                    ),
                  )),
              SizedBox(
                height: 10,
              ),
              MaterialButton(
                onPressed: () async {
                  if (namaCtrl.text.isEmpty &&
                      jenisCtrl.text.isEmpty &&
                      stokCtrl.text.isEmpty &&
                      hargaCtrl.text.isEmpty) {
                    Get.snackbar("Informasi", "harap isi semua field");
                  } else {
                    // try {
                    int hasil = await apiController.updateProduk(
                        widget.produk.kode.toString(),
                        namaCtrl.text,
                        jenisCtrl.text,
                        stokCtrl.text,
                        hargaCtrl.text);
                    print(hasil);
                    if (hasil == 200) {
                      // Get.snackbar("Informasi", "berhasil menambah data");
                      Get.back(result: 'mantap');
                    } else {
                      Get.snackbar("Informasi", "gagal menambah data");
                    }
                    // } catch (e) {
                    //   Get.snackbar("Informasi", "Terjadi Kesalahan");
                    // }
                  }
                },
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32.0, vertical: 8.0),
                      child: Text(
                        'Ubah',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
