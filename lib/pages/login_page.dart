import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tugas11kelompok/controller/api_controller.dart';
import 'package:tugas11kelompok/pages/home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  ApiController apiController = ApiController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                      controller: emailCtrl,
                      decoration: InputDecoration(
                          border: InputBorder.none, labelText: 'Email'),
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
                      controller: passwordCtrl,
                      obscureText: true,
                      decoration: InputDecoration(
                          border: InputBorder.none, labelText: 'Password'),
                    ),
                  )),
              SizedBox(
                height: 10,
              ),
              MaterialButton(
                onPressed: () async {
                  print(emailCtrl.text);
                  print(passwordCtrl.text);
                  if (emailCtrl.text.isEmpty && passwordCtrl.text.isEmpty) {
                    Get.snackbar("Informasi", "harap isi email&password");
                  } else {
                    // try {
                    int hasil = await apiController.login(
                        emailCtrl.text, passwordCtrl.text);
                    print(hasil);
                    if (hasil == 200) {
                      Get.snackbar("Informasi", "Login Berhasil");
                      Get.offAll(HomePage(emailCtrl.text));
                    } else {
                      Get.snackbar("Informasi", "login gagal");
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
                        'Login',
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
