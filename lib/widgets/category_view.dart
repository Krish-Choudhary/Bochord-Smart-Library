import 'package:flutter/material.dart';
import 'package:library_app/widgets/category.dart';

class CategoryView extends StatelessWidget {
  const CategoryView(
      {super.key, required this.apiResponse, required this.title});

  final dynamic apiResponse;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        const SizedBox(height: 5),
        FutureBuilder(
          future: apiResponse,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return Category(apiResponse: snapshot.data);
            }
          },
        ),
      ],
    );
  }
}
