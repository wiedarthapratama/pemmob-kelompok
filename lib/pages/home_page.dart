import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tugas11kelompok/controller/api_controller.dart';
import 'package:tugas11kelompok/helper/helper.dart';
import 'package:tugas11kelompok/model/produk.dart';
import 'package:tugas11kelompok/pages/edit_page.dart';
import 'package:tugas11kelompok/pages/form_page.dart';
import 'package:tugas11kelompok/pages/login_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
  final String loginEmail;
  HomePage(this.loginEmail);
}

class _HomePageState extends State<HomePage> {
  ApiController apiController = ApiController();
  bool loading = true;
  List<Produk> dataProduk = [];
  @override
  void initState() {
    getProduk();
    super.initState();
  }

  getProduk() async {
    try {
      var response = await apiController.getProduk();
      // if (response != null) {
      setState(() {
        loading = false;
        dataProduk = response;
      });
      // }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white70,
        appBar: AppBar(
          title: Text('Produk'),
          actions: [
            IconButton(
                onPressed: () {
                  Get.offAll(LoginPage());
                },
                icon: Icon(Icons.power_settings_new_outlined))
          ],
        ),
        floatingActionButton: widget.loginEmail == "admin@gmail.com"
            ? FloatingActionButton(
                onPressed: () async {
                  var res = await Get.to(() => FormPage());
                  if (res != null) {
                    getProduk();
                    setState(() {});
                  }
                },
                child: Icon(Icons.add),
              )
            : Container(),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              loading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container(
                      height: Get.height * 0.5,
                      width: Get.width,
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, i) {
                          return InkWell(
                            onTap: () async {
                              if (widget.loginEmail == "admin@gmail.com") {
                                var res =
                                    await Get.to(() => EditPage(dataProduk[i]));
                                if (res != null) {
                                  getProduk();
                                  setState(() {});
                                }
                              }
                            },
                            onLongPress: () async {
                              if (widget.loginEmail == "admin@gmail.com") {
                                var hapus = await apiController.deleteProduk(
                                    dataProduk[i].kode.toString());
                                if (hapus != null) {
                                  Get.snackbar(
                                      'Informasi', "Data Berhasil Dihapus");
                                  getProduk();
                                  setState(() {});
                                }
                              }
                            },
                            child: Card(
                              child: ListTile(
                                leading: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(50)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      dataProduk[i].jenis,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                title: Text(dataProduk[i].namaBarang,
                                    style: TextStyle(fontSize: 18)),
                                subtitle: Text(
                                  'Stok: ' + myNumberFormat(dataProduk[i].stok),
                                  style: TextStyle(fontSize: 14),
                                ),
                                trailing: Text('Rp. ' +
                                    myNumberFormat(dataProduk[i].harga)),
                              ),
                            ),
                          );
                        },
                        itemCount: dataProduk.length,
                      ),
                    ),
            ],
          ),
        ));
  }
}
