import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:appbaru/app/modules/home/controllers/welcome_controller.dart';
import 'package:appbaru/app/routes/app_pages.dart'; // Make sure to import the routes

class WelcomeScreen extends StatelessWidget {
  final WelcomeController controller = WelcomeController(); // Create an instance of the controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 30),
              // Image section
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 150,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(60),
                            image: DecorationImage(
                              image: AssetImage('assets/img/cincin2.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          height: 150,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(60),
                            image: DecorationImage(
                              image: AssetImage('assets/img/gelang.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 10),
                    Container(
                      height: 310,
                      width: 160,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(80),
                        image: DecorationImage(
                          image: AssetImage('assets/img/star.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              // Main text section
              Text(
                'Koleksi Aksesori Kekinian untuk Gaya Sehari-hari',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Temukan aksesoris yang disesuaikan sesuai keinginan Anda. Sempurnakan Gaya dengan Aksesoris ini!.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 40),
              // Main navigation button for registration
              ElevatedButton(
                onPressed: () {
                  Get.toNamed(Routes.REGISTER); // Navigate to RegisterPage
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  backgroundColor: Colors.brown,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'Register',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Text for sign in
              TextButton(
                onPressed: () {
                  Get.toNamed(Routes.LOGIN); // Navigate to LoginPage
                },
                child: Text(
                  'Sudah punya akun? Login',
                  style: TextStyle(
                    color: Colors.brown,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
