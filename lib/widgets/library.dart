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
      children: [for (LibraryBook book in books) LibraryBookTile(book: book)],
    );
  }
}
