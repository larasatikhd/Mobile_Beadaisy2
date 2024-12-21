import 'package:flutter/material.dart';
import 'package:appbaru/app/modules/home/controllers/profile_controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ProfileController controller = ProfileController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController locationController = TextEditingController();

  bool isManualLocation = false;

  @override
  void initState() {
    super.initState();
    controller.loadProfileData();
  }

  Future<void> pickLocation() async {
    try {
      // Panggil fungsi pickLocation dari controller untuk memilih lokasi dari peta
      await controller.pickLocation(context);
    } catch (e) {
      print("Error picking location: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to pick location')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Row untuk heading
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Spacer(),
                    Text(
                      'Sightlancer',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(flex: 1),
                    PopupMenuButton<String>(
                      onSelected: (String value) {
                        if (value == 'Edit Account') {
                          // editAccount(context);
                        } else if (value == 'Delete Account') {
                          controller.deleteAccount(context);
                        } else if (value == 'Logout') {
                          controller.logout();
                          Navigator.pushReplacementNamed(context, '/welcome');
                        }
                      },
                      itemBuilder: (BuildContext context) {
                        return [
                          PopupMenuItem<String>(
                            value: 'Edit Account',
                            child: Text('Edit Account'),
                          ),
                          PopupMenuItem<String>(
                            value: 'Delete Account',
                            child: Text('Delete Account'),
                          ),
                          PopupMenuItem<String>(
                            value: 'Logout',
                            child: Text('Logout'),
                          ),
                        ];
                      },
                      icon: Icon(Icons.settings),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  'Complete Your Profile',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  'Don’t worry, only you can see your personal data. No one else will be able to see it.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.grey.shade300,
                          backgroundImage: controller.profileImage != null
                              ? FileImage(controller.profileImage!)
                              : null,
                          child: controller.profileImage == null
                              ? Icon(Icons.person, size: 50, color: Colors.grey)
                              : null,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: InkWell(
                            onTap: () => controller.pickImage(context),
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                color: Colors.brown,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.nameController.text.isNotEmpty
                                ? controller.nameController.text
                                : 'Name',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Gender: ${controller.selectedGender ?? 'Not specified'}',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Phone: ${controller.phoneController.text.isNotEmpty ? controller.phoneController.text : 'Not specified'}',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                TextField(
                  controller: controller.nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: controller.phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        '+62',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  ),
                ),
                SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  value: controller.selectedGender,
                  items: <String>['Male', 'Female', 'Other']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                        value: value, child: Text(value));
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      controller.selectedGender = newValue;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Select Gender',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                // Pilihan lokasi: Manual atau dari Peta
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Choose Location:"),
                    Row(
                      children: [
                        Text("Manual"),
                        Switch(
                          value: isManualLocation,
                          onChanged: (value) {
                            setState(() {
                              isManualLocation = value;
                            });
                          },
                        ),
                        Text("Map"),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20),
                isManualLocation
                    ? TextField(
                        controller: controller.locationController,
                        decoration: InputDecoration(
                          labelText: 'Enter Location Manually',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 20),
                        ),
                      )
                    : TextField(
                        controller: controller.locationController,
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: 'Location',
                          suffixIcon: IconButton(
                            icon: Icon(Icons.map),
                            onPressed: pickLocation,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () async {
                    bool success = await controller.completeProfile(context);
                    if (success) {
                      setState(() {});
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown,
                    padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Complete Profile',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    controller.deleteProfile(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Delete Profile',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
