import 'package:flutter/material.dart';
import 'package:library_app/widgets/category_view.dart';
import 'package:library_app/screens/search_loading.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.listOfBooks});
  final List<Future<dynamic>> listOfBooks;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return SearchLoading(text: t.text);
                    }));
                  },
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
          CategoryView(apiResponse: widget.listOfBooks[0], title: 'Science'),
          CategoryView(apiResponse: widget.listOfBooks[1], title: 'History'),
          CategoryView(apiResponse: widget.listOfBooks[2], title: 'Finance'),
          CategoryView(apiResponse: widget.listOfBooks[3], title: 'Fiction'),
          CategoryView(apiResponse: widget.listOfBooks[4], title: 'Adventure'),
          CategoryView(apiResponse: widget.listOfBooks[5], title: 'Fantasy'),
          CategoryView(apiResponse: widget.listOfBooks[6], title: 'Romance'),
        ],
      ),
    );
  }
}
