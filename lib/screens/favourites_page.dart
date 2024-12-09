import 'package:flutter/material.dart';
import 'package:tourtango/api.dart';

class FavouritesPage extends StatefulWidget {
  final String customerEmail;

  FavouritesPage({required this.customerEmail});

  @override
  _FavouritesPageState createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  late Future<List<dynamic>> _favourites;

  @override
  void initState() {
    super.initState();
    _favourites = getFavourites(customerEmail: widget.customerEmail);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Favourites'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _favourites,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No favourites added.'));
          } else {
            final favourites = snapshot.data!;

            return ListView.builder(
              itemCount: favourites.length,
              itemBuilder: (context, index) {
                final favourite = favourites[index];
                final packageID = favourite['packageID'];
                final packageName = favourite['packageName'];
                final description = favourite['description'];
                final price = favourite['price'];
                final startDate = favourite['start_date'];
                final endDate = favourite['end_date'];
                final country = favourite['country'];

                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16),
                    title: Text(packageName,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 8),
                        Text('Description: $description'),
                        SizedBox(height: 4),
                        Text('Price: \$${price.toString()}'),
                        SizedBox(height: 4),
                        Text('Start Date: $startDate'),
                        SizedBox(height: 4),
                        Text('End Date: $endDate'),
                        SizedBox(height: 4),
                        Text('Country: $country'),
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () async {
                        await deleteFromFavourites(
                          customerEmail: widget.customerEmail,
                          packageID: packageID,
                        );
                        setState(() {
                          _favourites = getFavourites(
                              customerEmail: widget.customerEmail);
                        });
                      },
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
