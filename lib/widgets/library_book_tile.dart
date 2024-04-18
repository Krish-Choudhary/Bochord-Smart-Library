import 'package:flutter/material.dart';
import 'package:library_app/model/library_book.dart';

class LibraryBookTile extends StatelessWidget {
  const LibraryBookTile({super.key, required this.book});
  final LibraryBook book;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: const Color.fromARGB(255, 242, 240, 235),
      leading: Image.network(
        book.thumbnail,
      ),
      title: Text(book.title),
      subtitle: Text(book.author),
      trailing: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          book.isAvailable
              ? const Text(
                  'Available',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 10, 119, 14),
                    fontSize: 16,
                  ),
                )
              : const Text(
                  'Not Available',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 126, 23, 16),
                    fontSize: 16,
                  ),
                ),
          !book.isAvailable
              ? Text(
                  book.formattedDate,
                  style: const TextStyle(fontSize: 14),
                )
              : const Text(""),
        ],
      ),
    );
  }
}
