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
  late Future<dynamic> adventureBody;
  late Future<dynamic> horrorBody;
  late Future<dynamic> romanceBody;
  late Future<dynamic> fantasyBody;
  late Future<dynamic> fictionBody;
  late Future<dynamic> scienceBody;
  late Future<dynamic> healthBody;

  void getcategorydata() async {
    final adventureUrl = Uri.parse(
        "https://www.googleapis.com/books/v1/volumes?q=subject:adventure&download=epub&orderBy=newest&key=AIzaSyAqxw3nnCxwNQXRmXb-ZFi8FTNyhz6kwGA");
    final fantasyUrl = Uri.parse(
        "https://www.googleapis.com/books/v1/volumes?q=subject:fantasy&download=epub&orderBy=newest&key=AIzaSyAqxw3nnCxwNQXRmXb-ZFi8FTNyhz6kwGA");
    final horrorUrl = Uri.parse(
        "https://www.googleapis.com/books/v1/volumes?q=subject:horror&download=epub&orderBy=newest&key=AIzaSyAqxw3nnCxwNQXRmXb-ZFi8FTNyhz6kwGA");
    final romanceUrl = Uri.parse(
        "https://www.googleapis.com/books/v1/volumes?q=subject:romance&download=epub&orderBy=newest&key=AIzaSyAqxw3nnCxwNQXRmXb-ZFi8FTNyhz6kwGA");
    final fictionUrl = Uri.parse(
        "https://www.googleapis.com/books/v1/volumes?q=subject:fiction&download=epub&orderBy=newest&key=AIzaSyAqxw3nnCxwNQXRmXb-ZFi8FTNyhz6kwGA");
    final scienceUrl = Uri.parse(
        "https://www.googleapis.com/books/v1/volumes?q=subject:science&download=epub&orderBy=newest&key=AIzaSyAqxw3nnCxwNQXRmXb-ZFi8FTNyhz6kwGA");
        final healthUrl = Uri.parse(
        "https://www.googleapis.com/books/v1/volumes?q=subject:health&download=epub&orderBy=newest&key=AIzaSyAqxw3nnCxwNQXRmXb-ZFi8FTNyhz6kwGA");

    adventureBody =
        http.get(adventureUrl).then((response) => json.decode(response.body));
    fantasyBody =
        http.get(fantasyUrl).then((response) => json.decode(response.body));
    horrorBody =
        http.get(horrorUrl).then((response) => json.decode(response.body));
    romanceBody =
        http.get(romanceUrl).then((response) => json.decode(response.body));
    fictionBody =
        http.get(fictionUrl).then((response) => json.decode(response.body));
    scienceBody =
        http.get(scienceUrl).then((response) => json.decode(response.body));
        healthBody =
        http.get(healthUrl).then((response) => json.decode(response.body));
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
          CategoryView(apiResponse: scienceBody, title: 'Science'),
          CategoryView(apiResponse: fictionBody, title: 'Fiction'),
          CategoryView(apiResponse: adventureBody, title: 'Adventure'),
          CategoryView(apiResponse: horrorBody, title: 'Horror'),
          CategoryView(apiResponse: fantasyBody, title: 'Fantasy'),
          CategoryView(apiResponse: romanceBody, title: 'Romance'),
          CategoryView(apiResponse: healthBody, title: 'Health'),
        ],
      ),
    );
  }
}
