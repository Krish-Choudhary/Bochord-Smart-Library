import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

class LibraryBook {
  LibraryBook({
    required this.author,
    required this.availabilityDate,
    required this.isAvailable,
    required this.thumbnail,
    required this.title,
  });

  final String title;
  final String thumbnail;
  final String author;
  final bool isAvailable;
  final DateTime? availabilityDate;

  String get formattedDate {
    return formatter.format(availabilityDate!);
  }

  factory LibraryBook.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>?> doc) {
    final Map<String, dynamic>? data = doc.data();
    return LibraryBook(
      author: data!['Author name'] as String,
      title: data['Book name'] as String,
      isAvailable: data['Availability'] as bool,
      availabilityDate: (data['Availability date'] as Timestamp).toDate(),
      thumbnail: data['Cover page'] as String,
    );
  }
}
