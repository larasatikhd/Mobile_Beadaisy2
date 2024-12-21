import 'package:flutter/material.dart';
import 'package:appbaru/app/modules/home/controllers/search_controller.dart' as customSearch;
import 'package:appbaru/app/modules/home/views/product.dart';
import 'admin.dart'; // Import AdminProductPage

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String searchQuery = '';

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
        title: TextField(
          controller: _searchController,
          onChanged: (value) {
            setState(() {
              searchQuery = value;
            });
          },
          decoration: InputDecoration(
            hintText: 'Search',
            border: InputBorder.none,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Icon(Icons.search, color: Colors.black),
          ),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Results for "$searchQuery"',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return ItemCard(item: items[index]);
                    },
                  ),
                ),
              ],
            ),
          ),
          // Button to add products
          Positioned(
            top: 16,
            right: 16,
            child: GestureDetector(
              onTap: () {
                // Open AdminProductPage for CRUD
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AdminProductPage(),
                  ),
                );
              },
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.add,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ItemCard extends StatelessWidget {
  final Item item;

  const ItemCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to product detail page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailPage(item: item),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: AssetImage(item.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Icon(Icons.favorite_border),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.title, style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Text("\$${item.price}"),
                      Spacer(),
                      Icon(Icons.star, color: Colors.yellow, size: 16),
                      Text(item.rating.toString()),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductDetailPage extends StatelessWidget {
  final Item item;

  const ProductDetailPage({required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(item.title)),
      body: Column(
        children: [
          Image.asset(item.imageUrl),
          SizedBox(height: 16),
          Text(item.title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          Text("\$${item.price}", style: TextStyle(fontSize: 20)),
          Text("Rating: ${item.rating}", style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}

class Item {
  final String title;
  final String imageUrl;
  final double price;
  final double rating;

  Item({
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.rating,
  });
}

// Updated item list with 6 items
List<Item> items = [
  Item(
    title: "Butterfly Blue",
    imageUrl: "assets/img/img1.jpg",
    price: 83.97,
    rating: 4.9,
  ),
  Item(
    title: "White Love",
    imageUrl: "assets/img/love.jpg",
    price: 120.00,
    rating: 5.0,
  ),
  Item(
    title: "Black Pink",
    imageUrl: "assets/img/img3.jpg",
    price: 75.50,
    rating: 4.8,
  ),
  Item(
    title: "Blue Star",
    imageUrl: "assets/img/img2.jpg",
    price: 99.99,
    rating: 4.7,
  ),
  Item(
    title: "White Rings",
    imageUrl: "assets/img/cincin2.png",
    price: 150.00,
    rating: 4.6,
  ),
  Item(
    title: "Silver Rings",
    imageUrl: "assets/img/img4.jpg",
    price: 65.00,
    rating: 4.5,
  ),
];