import 'package:flutter/material.dart';
import 'package:library_app/widgets/book_details.dart';

class BookCard extends StatelessWidget {
  const BookCard({
    super.key,
    required this.bookName,
    required this.coverPage,
  });

  final String coverPage;
  final String bookName;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (ctx) {
              return SizedBox(
                height: double.infinity,
                child: BookDetails(bookName: bookName, coverPage: coverPage),
              );
            });
      },
      child: Stack(children: [
        Image.asset(
          coverPage,
          width: double.infinity,
          fit: BoxFit.fitWidth,
        ),
        Positioned(
          left: 0,
          bottom: 0,
          right: 0,
          child: Container(
            height: 35,
            color: Colors.black54,
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 7),
            child: Text(
              bookName,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              softWrap: true,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ]),
    );
  }
}