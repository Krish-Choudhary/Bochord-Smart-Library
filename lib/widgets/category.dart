import 'package:flutter/material.dart';
import 'package:library_app/widgets/bookloading.dart';

class Category extends StatelessWidget {
  const Category({
    required this.apiResponse,
    super.key,
  });

  final dynamic apiResponse;
  String st(String s) {
    int count = 0;
    String ans = "";
    for (int i = 0; i < s.length; i++) {
      if (count == 3) {
        break;
      }
      if (s[i] == ' ') {
        count++;
      }
      ans = ans + s[i];
    }
    return "$ans...";
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 270,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 9,
          itemBuilder: (context, index) {
            return (Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return BookLoading(
                        c: apiResponse["items"][index + 1]["volumeInfo"]
                            ["industryIdentifiers"][0]["identifier"]);
                  }));
                },
                child: Column(
                  children: [
                    Container(
                      height: 230,
                      width: 150,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 3,
                              blurRadius: 8,
                              offset: const Offset(2, 2))
                        ],
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: NetworkImage(apiResponse["items"][index + 1]
                                ["volumeInfo"]["imageLinks"]["thumbnail"]),
                            fit: BoxFit.cover),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      (apiResponse["items"][index + 1]["volumeInfo"]["title"])
                                  .length >
                              20
                          ? st(apiResponse["items"][index + 1]["volumeInfo"]
                              ["title"])
                          : apiResponse["items"][index + 1]["volumeInfo"]
                              ["title"],
                      style: TextStyle(
                          color: Colors.grey[900], fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ));
          }),
    );
  }
}
