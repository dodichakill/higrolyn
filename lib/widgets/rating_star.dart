import 'package:flutter/material.dart';

class RatingStars extends StatefulWidget {
  final int initialRating;
  final ValueChanged<int> onRatingChanged;

  const RatingStars({
    super.key,
    this.initialRating = 0,
    required this.onRatingChanged,
  });

  @override
  _RatingStarsState createState() => _RatingStarsState();
}

class _RatingStarsState extends State<RatingStars> {
  late int _rating;

  @override
  void initState() {
    super.initState();
    _rating = widget.initialRating; // Set initial rating
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List.generate(5, (index) {
        return IconButton(
          key: Key('star_$index'), // Key unik untuk setiap bintang
          icon: Icon(
            Icons.star,
            size: 40,
            color: index < _rating
                ? Colors.orange
                : Colors.grey, // Set color based on rating
          ),
          onPressed: () {
            setState(() {
              _rating = index + 1; // Rating starts from 1 (index 0 = 1 star)
            });
            widget.onRatingChanged(
                _rating); // Pass the rating to the parent (ProfileNotifier)
          },
        );
      }),
    );
  }
}
