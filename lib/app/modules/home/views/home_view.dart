import 'package:appbaru/app/modules/home/views/profile.dart';
import 'package:appbaru/app/modules/home/views/search.dart';
import 'package:appbaru/app/modules/http_screen/views/http_view.dart';
import 'package:appbaru/app/modules/home/views/gps_view.dart'; // Import halaman GPSView
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 230, 200, 200),
      body: SafeArea(
        child: Column(
          children: [
            // Search Bar with Location Icon
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  // Search Bar
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search Products',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                  // Location Icon
                  IconButton(
                    icon: Icon(Icons.location_on),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => GPSView()),
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            // Category Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildCategoryButton(
                  'Bracalets',
                  'assets/img/gelang2.png',
                  context,
                  size: 70, // Ukuran gambar diperbesar
                ),
                _buildCategoryButtonClothes(
                  'Catalog',
                  'assets/img/catalog.png',
                  context,
                  size: 70, // Ukuran gambar diperbesar
                ),
                _buildCategoryButton(
                  'Rings',
                  'assets/img/cincin.png',
                  context,
                  size: 70, // Ukuran gambar diperbesar
                ),
                _buildCategoryButton(
                  'Phone Strap',
                  'assets/img/phone.png',
                  context,
                  size: 70, // Ukuran gambar diperbesar
                ),
              ],
            ),
            SizedBox(height: 50),
            // Title
            Text(
              'BIG SALE',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 33,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            // Image Stack
            Expanded(
              child: Stack(
                children: [
                  Image.asset(
                    'assets/img/Idul Fitri.png',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                  Positioned(
                    left: 10,
                    bottom: 10,
                    child: Icon(Icons.arrow_back_ios),
                  ),
                  Positioned(
                    right: 10,
                    bottom: 10,
                    child: Icon(Icons.arrow_forward_ios),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            // Bottom Navigation Bar
            BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.notifications), // Ikon lonceng pemberitahuan
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Stack(
                    children: [
                      Icon(Icons.shopping_cart),
                      Positioned(
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.all(1),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          constraints:
                              BoxConstraints(minWidth: 12, minHeight: 12),
                          child: Text(
                            '3',
                            style: TextStyle(color: Colors.white, fontSize: 8),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: '',
                ),
              ],
              onTap: (index) {
                // Navigasi menggunakan Navigator.push
                switch (index) {
                  case 0:
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                    break;
                  case 1:
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HttpView()),
                    );
                    break;
                  case 3:
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfilePage()),
                    );
                    break;
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  // Tombol Kategori Default
  Widget _buildCategoryButton(
      String label, String imagePath, BuildContext context,
      {double size = 40}) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10), // Padding yang lebih kecil
          child: ClipOval(
            child: Image.asset(
              imagePath,
              height: size, // Ukuran gambar diperbesar
              width: size, // Ukuran gambar diperbesar
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: 5),
        Text(label),
      ],
    );
  }

  // Tombol Kategori Clothes dengan Navigasi
  Widget _buildCategoryButtonClothes(
      String label, String imagePath, BuildContext context,
      {double size = 40}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SearchScreen()),
        );
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10), // Padding yang lebih kecil
            child: ClipOval(
              child: Image.asset(
                imagePath,
                height: size, // Ukuran gambar diperbesar
                width: size, // Ukuran gambar diperbesar
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 5),
          Text(label),
        ],
      ),
    );
  }
}
