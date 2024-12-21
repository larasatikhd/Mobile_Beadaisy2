import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/gps_controller.dart';

class GPSView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final gpsController = Get.put(GPSController()); // Inisialisasi Controller

    return Scaffold(
      appBar: AppBar(
        title: Text('Location & Navigation'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.center, // Rata tengah secara horizontal
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "Store Coordinates:\nLatitude: ${gpsController.storeLat}\nLongitude: ${gpsController.storeLng}",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Address: Jl. Veteran No.2, Penanggungan, Kec. Klojen, Kota Malang, Jawa Timur 65111",
              style: TextStyle(fontSize: 14, color: Colors.black54),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                gpsController.openStoreLocation(); // Lokasi tetap toko
              },
              child: Text(
                "Show Store Location",
                style: TextStyle(color: Colors.black),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 208, 114, 121),
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                try {
                  // Mendapatkan lokasi saat ini
                  await gpsController.getCurrentLocation();

                  // Menampilkan lokasi saat ini menggunakan snackbar
                  Get.snackbar(
                    "Current Location",
                    "Latitude: ${gpsController.currentLocation.value?.latitude}, "
                        "Longitude: ${gpsController.currentLocation.value?.longitude}",
                    snackPosition: SnackPosition.BOTTOM,
                  );

                  // Navigasi ke toko
                  gpsController.navigateToStore();
                } catch (e) {
                  // Menampilkan error jika gagal mengambil lokasi
                  Get.snackbar("Error", e.toString(),
                      snackPosition: SnackPosition.BOTTOM);
                }
              },
              child: Text(
                "Navigate to Store",
                style: TextStyle(color: Colors.black),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(175, 111, 76, 1),
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}