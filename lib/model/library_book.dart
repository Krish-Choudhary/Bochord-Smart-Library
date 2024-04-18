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
  final DateTime availabilityDate;

  String get formattedDate {
    return formatter.format(availabilityDate);
  }
}
