import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart'; 
import 'package:tourtango/api.dart'; 
class Favourite extends StatefulWidget {
  final String customerEmail;
  final int packageID;

  const Favourite({
    Key? key,
    required this.customerEmail,
    required this.packageID,
  }) : super(key: key);

  @override
  _FavouriteState createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  bool _isFavorited = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      _isFavorited = false;
    });
  }


  Future<void> _toggleFavorite() async {

    if (_isFavorited) {
      // Remove from favorites
      await deleteFromFavourites(customerEmail: widget.customerEmail, packageID: widget.packageID);
      setState(() {
        _isFavorited = false;
      });
      _showSnackBar('Removed from Favourites');
    } else {
      // Add to favorites
      await addToFavorites(customerEmail: widget.customerEmail, packageID: widget.packageID);
      setState(() {
        _isFavorited = true;
      });
      _showSnackBar('Added to Favourites');
    }

  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 20,
      onPressed: _toggleFavorite,
      icon: Icon(
        _isFavorited ? Ionicons.heart : Ionicons.heart_outline,
        color:_isFavorited ? Colors.red : null,
      ),
    );
  }
}
