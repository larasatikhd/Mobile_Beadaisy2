import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController {
  File? profileImage;
  final ImagePicker picker = ImagePicker();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  String? selectedGender;
  double? latitude; // Latitude lokasi
  double? longitude; // Longitude lokasi
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  /// Log out user
  Future<void> logout() async {
    await auth.signOut();
  }

  /// Load user profile data from Firestore
  Future<void> loadProfileData() async {
    try {
      User? user = auth.currentUser;
      if (user != null) {
        DocumentSnapshot snapshot =
            await firestore.collection('profiles').doc("user_profile").get();
        if (snapshot.exists) {
          nameController.text = snapshot['name'] ?? '';
          phoneController.text = snapshot['phone'] ?? '';
          emailController.text = user.email ?? '';
          selectedGender = snapshot['gender'] ?? 'Not specified';
          locationController.text = snapshot['location'] ?? '';
          latitude = snapshot['latitude'] ?? 0.0;
          longitude = snapshot['longitude'] ?? 0.0;

          // Load profile image if available
          String? imageUrl = snapshot['profileImage'];
          if (imageUrl != null) {
            profileImage = File(imageUrl); // Assuming it's a file path or URL
          }
        }
      }
    } catch (e) {
      print('Error loading profile: $e');
    }
  }

  /// Pick an image from the gallery
  Future<void> pickImage(BuildContext context) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Image picked successfully!')),
      );
    }
  }

  /// Save or update profile including location
  Future<bool> completeProfile(BuildContext context) async {
    try {
      User? user = auth.currentUser;
      if (user != null) {
        await firestore.collection('profiles').doc("user_profile").set(
          {
            'name': nameController.text,
            'phone': phoneController.text,
            'gender': selectedGender,
            'location': locationController.text,
            'latitude': latitude,
            'longitude': longitude,
          },
          SetOptions(merge: true),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profile updated successfully!')),
        );
        return true;
      }
    } catch (e) {
      print('Error updating profile: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating profile.')),
      );
    }
    return false;
  }

  /// Pick a location using Google Maps
  Future<void> pickLocation(BuildContext context) async {
    print("pickLocation called");
    try {
      LatLng? pickedLocation = await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => MapPickerPage(),
        ),
      );
      print("Picked location: $pickedLocation");
      if (pickedLocation != null) {
        latitude = pickedLocation.latitude;
        longitude = pickedLocation.longitude;
        locationController.text =
            "Lat: ${pickedLocation.latitude}, Lng: ${pickedLocation.longitude}";
      }
    } catch (e) {
      print("Error in pickLocation: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to navigate to map')),
      );
    }
  }

  /// Reauthenticate user for sensitive operations
  Future<void> reauthenticateUser(String currentPassword) async {
    User? user = auth.currentUser;
    if (user != null && user.email != null) {
      AuthCredential credential = EmailAuthProvider.credential(
        email: user.email!,
        password: currentPassword,
      );
      await user.reauthenticateWithCredential(credential);
    }
  }

  /// Update email and password
  Future<bool> updateAccount(
      String email, String password, String currentPassword) async {
    try {
      await reauthenticateUser(currentPassword);
      User? user = auth.currentUser;
      if (user != null) {
        if (email.isNotEmpty && email != user.email) {
          await user.updateEmail(email);
        }
        if (password.isNotEmpty) {
          await user.updatePassword(password);
        }
        return true;
      }
    } on FirebaseAuthException catch (e) {
      print('FirebaseAuthException: ${e.message}');
    } catch (e) {
      print('Error: $e');
    }
    return false;
  }

  /// Delete profile from Firestore
  Future<void> deleteProfile(BuildContext context) async {
    try {
      User? user = auth.currentUser;
      if (user != null) {
        await firestore.collection('profiles').doc("user_profile").delete();
        nameController.clear();
        phoneController.clear();
        emailController.clear();
        passwordController.clear();
        selectedGender = null;
        profileImage = null;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profile deleted successfully!')),
        );
      }
    } catch (e) {
      print('Error deleting profile: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting profile.')),
      );
    }
  }

  /// Delete user account
  Future<void> deleteAccount(BuildContext context) async {
    try {
      User? user = auth.currentUser;
      if (user != null) {
        // Delete profile from Firestore
        await firestore.collection('profiles').doc(user.uid).delete();
        // Delete account from Firebase Authentication
        await user.delete();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Account deleted successfully!')),
        );
        // Navigate to login page
        Navigator.of(context).pushReplacementNamed('/login');
      }
    } catch (e) {
      print('Error deleting account: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting account.')),
      );
    }
  }
}

/// Page for selecting a location on Google Maps
class MapPickerPage extends StatefulWidget {
  @override
  _MapPickerPageState createState() => _MapPickerPageState();
}

class _MapPickerPageState extends State<MapPickerPage> {
  LatLng _initialPosition = LatLng(-6.200000, 106.816666); // Default to Jakarta
  LatLng? _pickedLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pick Location'),
        actions: [
          if (_pickedLocation != null)
            IconButton(
              icon: Icon(Icons.check),
              onPressed: () {
                Navigator.of(context).pop(_pickedLocation);
              },
            ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _initialPosition,
          zoom: 14,
        ),
        onTap: (LatLng location) {
          setState(() {
            _pickedLocation = location;
          });
        },
        markers: _pickedLocation != null
            ? {
                Marker(
                  markerId: MarkerId('picked-location'),
                  position: _pickedLocation!,
                ),
              }
            : {},
      ),
    );
  }
}
