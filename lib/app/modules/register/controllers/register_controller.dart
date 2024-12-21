import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterController extends GetxController {
  // Firebase Auth instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Method for registering a new user
  Future<void> register(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Navigate to the login page after successful registration
      Get.offNamed('/login');
    } catch (e) {
      // Handle registration errors (e.g., show a message)
      Get.snackbar('Error', e.toString());
    }
  }
}