// welcome_controller.dart
import 'package:flutter/material.dart';

class WelcomeController {
  void navigateToNextScreen(BuildContext context) {
    Navigator.pushNamed(context, '/home');
  }

  void signIn(BuildContext context) {
    // Misalnya, bisa mengarahkan ke halaman sign-in
    Navigator.pushNamed(context, '/signIn');
  }
}
