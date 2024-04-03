import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:library_app/widgets/category_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<dynamic> c1;
  late Future<dynamic> c2;
  late Future<dynamic> c3;
  late Future<dynamic> c4;

  void getcategorydata() async {
    final u1 = Uri.parse(
        "https://www.googleapis.com/books/v1/volumes?q=subject:adventure&download=epub&orderBy=newest&key=AIzaSyAqxw3nnCxwNQXRmXb-ZFi8FTNyhz6kwGA");
    final u2 = Uri.parse(
        "https://www.googleapis.com/books/v1/volumes?q=subject:fantasy&download=epub&orderBy=newest&key=AIzaSyAqxw3nnCxwNQXRmXb-ZFi8FTNyhz6kwGA");
    final u3 = Uri.parse(
        "https://www.googleapis.com/books/v1/volumes?q=subject:horror&download=epub&orderBy=newest&key=AIzaSyAqxw3nnCxwNQXRmXb-ZFi8FTNyhz6kwGA");
    final u4 = Uri.parse(
        "https://www.googleapis.com/books/v1/volumes?q=subject:romance&download=epub&orderBy=newest&key=AIzaSyAqxw3nnCxwNQXRmXb-ZFi8FTNyhz6kwGA");

    c1 = http.get(u1).then((response) => json.decode(response.body));
    c2 = http.get(u2).then((response) => json.decode(response.body));
    c3 = http.get(u3).then((response) => json.decode(response.body));
    c4 = http.get(u4).then((response) => json.decode(response.body));
  }

  @override
  void initState() {
    getcategorydata();
    super.initState();
  }

  @override
  void dispose() {
    t.dispose();
    super.dispose();
  }

  TextEditingController t = TextEditingController();

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
    return SingleChildScrollView(
      child: Column(
        children: [
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                    controller: t,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.all(10),
                        hintText: "Search Book...",
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(40))),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) {
                    // return searchloading(text: t.text);
                    // }));
                  },
                  // splashColor: Color(0xfff012AC0),
                  // color: Colors.white,
                  child: const Text(
                    "SEARCH",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          CategoryView(apiResponse: c1, title: 'Adventure'),
          CategoryView(apiResponse: c2, title: 'Fantasy'),
          CategoryView(apiResponse: c3, title: 'Horror'),
          CategoryView(apiResponse: c4, title: 'Romance'),
        ],
      ),
    );
  }
}
