import 'package:flutter/material.dart';

// Model Item
class Item {
  String title;
  String imageUrl;
  double price;
  int stock;
  String description; // Tambahkan deskripsi
  double rating; // Tambahkan rating kembali

  Item({
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.stock,
    required this.description,
    required this.rating,
  });
}

// Daftar produk awal
List<Item> items = [
  Item(
    title: "Butterfly Blue",
    imageUrl: "assets/img/img1.jpg",
    price: 83.97,
    stock: 10,
    description: "Gaun cantik dengan desain kupu-kupu biru.",
    rating: 4.9,
  ),
  Item(
    title: "White Love",
    imageUrl: "assets/img/love.jpg",
    price: 120.00,
    stock: 5,
    description: "Gaun putih elegan untuk acara spesial.",
    rating: 5.0,
  ),
];

class AdminProductPage extends StatefulWidget {
  @override
  _AdminProductPageState createState() => _AdminProductPageState();
}

class _AdminProductPageState extends State<AdminProductPage> {
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  final _imageUrlController = TextEditingController();
  final _stockController = TextEditingController();
  final _descriptionController = TextEditingController(); // Controller deskripsi
  double _rating = 0.0; // Controller rating

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Product Page'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(labelText: 'Product Title'),
                ),
                TextField(
                  controller: _priceController,
                  decoration: InputDecoration(labelText: 'Product Price'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: _imageUrlController,
                  decoration: InputDecoration(labelText: 'Image URL'),
                ),
                TextField(
                  controller: _stockController,
                  decoration: InputDecoration(labelText: 'Stock Quantity'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: _descriptionController,
                  decoration: InputDecoration(labelText: 'Product Description'),
                ),
                Row(
                  children: [
                    Text('Rating: ${_rating.toStringAsFixed(1)}'),
                    Slider(
                      min: 0,
                      max: 5,
                      divisions: 10,
                      value: _rating,
                      onChanged: (value) {
                        setState(() {
                          _rating = value;
                        });
                      },
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_titleController.text.isNotEmpty &&
                        _priceController.text.isNotEmpty &&
                        _imageUrlController.text.isNotEmpty &&
                        _stockController.text.isNotEmpty &&
                        _descriptionController.text.isNotEmpty) {
                      final newItem = Item(
                        title: _titleController.text,
                        imageUrl: _imageUrlController.text,
                        price: double.parse(_priceController.text),
                        stock: int.parse(_stockController.text),
                        description: _descriptionController.text,
                        rating: _rating,
                      );
                      setState(() {
                        items.add(newItem);
                      });
                      _titleController.clear();
                      _priceController.clear();
                      _imageUrlController.clear();
                      _stockController.clear();
                      _descriptionController.clear();
                      _rating = 0.0;
                    }
                  },
                  child: Text('Add Product'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Image.asset(items[index].imageUrl),
                  title: Text(items[index].title),
                  subtitle: Text(
                    "\$${items[index].price} - Stock: ${items[index].stock} - Rating: ${items[index].rating}\n${items[index].description}",
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          _showEditStockDialog(index);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            items.removeAt(index);
                          });
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Dialog untuk mengedit stok barang
  void _showEditStockDialog(int index) {
    final _editStockController = TextEditingController(
      text: items[index].stock.toString(),
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Stock for ${items[index].title}'),
          content: TextField(
            controller: _editStockController,
            decoration: InputDecoration(labelText: 'Stock Quantity'),
            keyboardType: TextInputType.number,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  items[index].stock = int.parse(_editStockController.text);
                });
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
}