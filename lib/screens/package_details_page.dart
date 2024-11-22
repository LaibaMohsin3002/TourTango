import 'package:flutter/material.dart';

class PackageDetailsPage extends StatelessWidget {
  final String packageName;

  PackageDetailsPage({required this.packageName});

  final List<String> customers = [
    'Customer A',
    'Customer B',
    'Customer C'
  ]; // Sample customers

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Package Details: $packageName'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Package Details:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Description of $packageName goes here...',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Customers Opted:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: customers.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(customers[index]),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

/*
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: IcefieldsPage(),
      ),
    );
  }
}

class IcefieldsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Stack(
            children: [
              Image.network(
                'https://via.placeholder.com/400x250', // Replace with the actual image URL
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 10,
                left: 10,
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {},
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: IconButton(
                  icon: Icon(Icons.favorite_border, color: Colors.white),
                  onPressed: () {},
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Icefields',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(Icons.location_on, color: Colors.grey, size: 16),
                            SizedBox(width: 4),
                            Text(
                              'Icefields, Alberta',
                              style: TextStyle(color: Colors.grey, fontSize: 14),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Text(
                      '\$2153',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.orange, size: 20),
                    Icon(Icons.star, color: Colors.orange, size: 20),
                    Icon(Icons.star, color: Colors.orange, size: 20),
                    Icon(Icons.star, color: Colors.orange, size: 20),
                    Icon(Icons.star, color: Colors.orange, size: 20),
                    SizedBox(width: 8),
                    Text('(5.0)', style: TextStyle(color: Colors.grey)),
                  ],
                ),
                SizedBox(height: 16),
                Text(
                  'People',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(5, (index) {
                    return ChoiceChip(
                      label: Text('${index + 1}'),
                      selected: index == 0, // Default selection
                      onSelected: (bool selected) {},
                    );
                  }),
                ),
                SizedBox(height: 16),
                Text(
                  'Description',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'This stretches for a straight 234 kilometers from Banff to Jasper. The Icefields Parkway offers you the picturesque panorama of Alberta’s most talked about mountain vistas.',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                child: Text('Book Trip Now', style: TextStyle(fontSize: 18)),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

*/
