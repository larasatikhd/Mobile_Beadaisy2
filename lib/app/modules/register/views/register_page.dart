
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:appbaru/app/modules/register/controllers/register_controller.dart';

class RegisterPage extends StatelessWidget {
  final RegisterController controller = Get.put(RegisterController());
  
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                controller.register(
                  emailController.text,
                  passwordController.text,
                );
              },
              child: Text('Register'),
            ),
            TextButton(
              onPressed: () {
                Get.offNamed('/login'); // Navigate to login page
              },
              child: Text('Already have an account? Login'),
            ),
          ],
        ),
      ),
    );
  }
}