import 'package:flutter/material.dart';

class BookCard extends StatelessWidget {
  const BookCard({super.key, required this.bookName, required this.coverPage});

  final String coverPage;
  final String bookName;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          coverPage,
          height: 265,
        ),
        Text(bookName),
      ],
    );
  }
}
