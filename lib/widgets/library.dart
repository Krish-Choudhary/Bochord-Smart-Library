import 'package:flutter/material.dart';
import 'package:library_app/model/library_book.dart';
import 'package:library_app/widgets/library_book_tile.dart';

class Library extends StatelessWidget {
  const Library({super.key, required this.books});
  final List<LibraryBook> books;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 15),
        for (LibraryBook book in books)
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LibraryBookTile(book: book),
              const SizedBox(height: 10),
            ],
          )
      ],
    );
  }
}
