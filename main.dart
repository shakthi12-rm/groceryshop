import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grocery Shop',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: GroceryShoppingPage(),
    );
  }
}

class GroceryShoppingPage extends StatefulWidget {
  @override
  _GroceryShoppingPageState createState() => _GroceryShoppingPageState();
}

class _GroceryShoppingPageState extends State<GroceryShoppingPage> {
  List<Item> items = [
    Item(name: 'Apples', price: 3.5, quantity: 0),
    Item(name: 'Bananas', price: 1.2, quantity: 0),
    Item(name: 'Oranges', price: 2.0, quantity: 0),
    Item(name: 'Milk', price: 1.5, quantity: 0),
    Item(name: 'Eggs', price: 2.5, quantity: 0),
    Item(name: 'Rice Flour', price: 50, quantity: 0),
    Item(name: 'Wheat Flour', price: 50, quantity: 0),
    Item(name: 'Tomato', price: 48.5, quantity: 0),
  ];

  double getTotalAmount() {
    double total = 0.0;
    for (var item in items) {
      total += item.price * item.quantity;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Adding a background image
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                'https://img.freepik.com/premium-photo/tomatoes-canned-food-isolated-blue_286136-18.jpg?ga=GA1.1.79731911.1731604377&semt=ais_hybrid'), // Make sure to add your image in the assets folder
            fit: BoxFit
                .cover, // This ensures the image covers the entire background
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // AppBar with a custom title
            AppBar(
              backgroundColor:
                  Colors.transparent, // Make the app bar transparent
              elevation: 0, // Remove the shadow for a clean look
              title:
                  Text('GROCERY MART', style: TextStyle(color: Colors.black)),
              centerTitle: true, // Center the title
            ),
            // Main content of the page
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          return Card(
                            margin: EdgeInsets.symmetric(vertical: 8),
                            child: ListTile(
                              title: Text(items[index].name),
                              subtitle: Text(
                                  '\$${items[index].price.toStringAsFixed(2)}'),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.remove),
                                    onPressed: () {
                                      setState(() {
                                        if (items[index].quantity > 0) {
                                          items[index].quantity--;
                                        }
                                      });
                                    },
                                  ),
                                  Text('${items[index].quantity}'),
                                  IconButton(
                                    icon: Icon(Icons.add),
                                    onPressed: () {
                                      setState(() {
                                        items[index].quantity++;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    // Total Amount and Checkout Button
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total: \$${getTotalAmount().toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white, // White text for visibility
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Checkout'),
                                    content: Text(
                                        'Your total amount is \$${getTotalAmount().toStringAsFixed(2)}.'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          // Perform checkout (reset cart or any other action)
                                          setState(() {
                                            for (var item in items) {
                                              item.quantity = 0;
                                            }
                                          });
                                          Navigator.of(context).pop();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                                content:
                                                    Text('Checkout complete!')),
                                          );
                                        },
                                        child: Text('Confirm'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Text('Checkout'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Item class
class Item {
  final String name;
  final double price;
  int quantity;

  Item({required this.name, required this.price, this.quantity = 0});
}
