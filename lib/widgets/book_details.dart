import 'package:flutter/material.dart';

class BookDetails extends StatelessWidget {
  const BookDetails({
    super.key,
    required this.bookName,
    required this.coverPage,
  });

  final String coverPage;
  final String bookName;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 15),
          Center(
            child: Image.asset(
              coverPage,
              width: 150,
            ),
          )
        ],
      ),
    );
  }
}
