import 'package:flutter/material.dart';
import 'package:appbaru/app/modules/home/controllers/product_controller.dart';
import 'package:appbaru/app/modules/home/views/search.dart';

class ProductDetailPage extends StatefulWidget {
  final ProductDetailController controller =
      ProductDetailController(); // Instance controller
  
  // Menambahkan item sebagai parameter
  final Item item;

  // Constructor untuk menerima item
  ProductDetailPage({required this.item});

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  // Menyimpan gambar yang dipilih
  int selectedImageIndex = 0;

  // Daftar gambar thumbnail yang ingin ditampilkan
  List<String> thumbnailImages = [
    'assets/img/img1.jpg', // Gambar pertama
    'assets/img/love.jpg', 
    'assets/img/img2.jpg',  
    'assets/img/img3.jpg',   
    'assets/img/cincin2.png',   
    'assets/img/img4.jpg', 
    'assets/img/star.jpg',
    'assets/img/strep.png',
    'assets/img/love.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Product Details",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Image and gallery section
          Container(
            height: 300,
            child: Stack(
              children: [
                Center(
                  child: Image.asset(
                    thumbnailImages[selectedImageIndex], // Menggunakan gambar yang dipilih
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 60,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        // Image Thumbnails
                        for (var i = 0; i < thumbnailImages.length; i++)
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedImageIndex = i; // Update gambar yang dipilih
                                });
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.asset(
                                  thumbnailImages[i], // Menggunakan gambar dari list
                                  fit: BoxFit.cover,
                                  width: 60,
                                  height: 60,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Product Details
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Female's Style",
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(height: 8),
                Text(
                  widget.item.title, // Menggunakan judul dari item
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      widget.item.rating.toString(), // Menggunakan rating dari item
                      style: TextStyle(fontSize: 16),
                    ),
                    Icon(Icons.star, color: Colors.amber),
                  ],
                ),
                SizedBox(height: 16),
                Text(
                  "Product Details",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Read more",
                  // Menggunakan detail dari item
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(height: 16),

                // Size selection
                Text(
                  "Select Size",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    for (var size in ['S', 'M', 'L', 'XL', 'XXL'])
                      ChoiceChip(
                        label: Text(size),
                        selected: widget.controller.selectedSize == size,
                        onSelected: (isSelected) {
                          if (isSelected) {
                            widget.controller.setSize(size);
                          }
                        },
                      ),
                  ],
                ),
                SizedBox(height: 16),

                // Color selection
                Text(
                  "Select Color : Brown",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    for (var color in [
                      const Color.fromARGB(255, 198, 139, 175),
                      const Color.fromARGB(255, 203, 82, 165),
                      Colors.black
                    ])
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: GestureDetector(
                          child: CircleAvatar(
                            backgroundColor: color,
                            radius: 16,
                            child: widget.controller.selectedColor == color
                                ? Icon(Icons.check,
                                    color: Colors.white, size: 16)
                                : null,
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 16),

                // Price and Add to Cart
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Total Price",
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text(
                          "\$${widget.item.price.toString()}", // Menggunakan harga dari item
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.shopping_bag),
                      label: Text("Add to Cart"),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: const Color.fromARGB(255, 238, 144, 205),
                        padding:
                            EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
