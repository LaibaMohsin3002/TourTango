class Review {
  final int reviewID;
  final double rating;
  final String comment;

  Review({
    required this.reviewID,
    required this.rating,
    required this.comment,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      reviewID: json['reviewID'],
      rating: json['rating'],
      comment: json['comment'],
    );
  }
}
