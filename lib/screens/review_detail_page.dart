import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tourtango/api.dart';

class ReviewDetailPage extends StatefulWidget {
  final int bookingID;

  const ReviewDetailPage({super.key, required this.bookingID});

  @override
  _ReviewDetailPageState createState() => _ReviewDetailPageState();
}

class _ReviewDetailPageState extends State<ReviewDetailPage> {
  double _rating = 0;
  final TextEditingController _commentController = TextEditingController();
  bool _hasExistingReview = false;
  Map<String, dynamic>? _existingReview;

  @override
  void initState() {
    super.initState();
    _fetchExistingReview();
  }

  Future<void> _fetchExistingReview() async {
    try {
      final review =
          await fetchReview(widget.bookingID); // Fetch existing review
      setState(() {
        _hasExistingReview = true;
        _existingReview = review;
        _rating = review['rating'];
        _commentController.text = review['comment'];
      });
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No existing reviews: $error')),
      );
    }
  }

  Future<void> _submitReview() async {
    if (_rating == 0 || _commentController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please provide a rating and comment.')),
      );
      return;
    }

    try {
      if (_hasExistingReview) {
        await updateReview(widget.bookingID, _rating,
            _commentController.text); // Update existing review
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Review updated successfully!')),
        );
      } else {
        await submitReview(widget.bookingID, _rating,
            _commentController.text); // Submit new review
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Review submitted successfully!')),
        );
      }
      Navigator.pop(context);
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to submit review: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Leave a Review')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_hasExistingReview)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Already Reviewed',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Rating: ${_existingReview!['rating'].toStringAsFixed(1)}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Comment: ${_existingReview!['comment']}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        // Allow modification of review
                        _hasExistingReview = false;
                      });
                    },
                    child: const Text('Modify Review'),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            if (!_hasExistingReview)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _hasExistingReview
                        ? 'Modify your Review'
                        : 'Rate your Experience',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  RatingBar.builder(
                    initialRating: _rating,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      setState(() {
                        _rating = rating;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _commentController,
                    decoration: const InputDecoration(
                      labelText: 'Leave a comment',
                    ),
                    maxLines: 5,
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: _submitReview,
                      child: Text(_hasExistingReview
                          ? 'Update Review'
                          : 'Submit Review'),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
