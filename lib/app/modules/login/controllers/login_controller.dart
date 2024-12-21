import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Deklarasi untuk email dan password
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Fungsi untuk menangani login
  Future<void> login() async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // Tampilkan notifikasi jika login berhasil
      Get.snackbar(
        'Success!',
        'Login Berhasil',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      // Lanjutkan ke halaman utama
      Get.offNamed('/home');
    } catch (e) {
      // Jika ada kesalahan
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  // Optional: Membersihkan controller ketika tidak lagi digunakan
  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
