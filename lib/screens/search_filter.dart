import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:library_app/screens/bookloading.dart';

class SearchFilter extends StatefulWidget {
  const SearchFilter({required this.d, super.key});
  final dynamic d;

  @override
  State<SearchFilter> createState() => _SearchFilterState();
}

class _SearchFilterState extends State<SearchFilter> {
  String? isbn;

  getisbn(int index) {
    try {
      setState(() {
        isbn = widget.d["items"][index + 1]["volumeInfo"]["industryIdentifiers"]
            [0]["identifier"];
      });
    } catch (e) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Something went wrong"),
        duration: Duration(seconds: 2),
      ));
    }
  }

  String st(String s) {
    int count = 0;
    String ans = "";
    for (int i = 0; i < s.length; i++) {
      if (count == 15) {
        break;
      }
      count++;
      ans = ans + s[i];
    }
    return "$ans...";
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 1, 42, 192),
        title: const Text(
          "RESULT",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: ListView.builder(
          itemCount: widget.d["items"].length - 1,
          itemBuilder: (context, index) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              child: (Container(
                padding: const EdgeInsets.all(10),
                height: 270,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 1, 42, 192),
                    image: const DecorationImage(
                        opacity: 0.4,
                        image: AssetImage("assets/images/overlay.png"),
                        fit: BoxFit.cover)),
                child: Row(
                  children: [
                    Hero(
                      tag: widget.d["items"][index + 1]["id"],
                      child: Container(
                        height: 210,
                        width: 140,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: NetworkImage(widget.d["items"][index + 1]
                                    ["volumeInfo"]["imageLinks"]["thumbnail"]),
                                fit: BoxFit.cover)),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 25,
                        ),
                        Flexible(
                          child: Text(
                            (widget.d["items"][index + 1]["volumeInfo"]
                                            ["title"])
                                        .length >
                                    20
                                ? st(widget.d["items"][index + 1]["volumeInfo"]
                                    ["title"])
                                : widget.d["items"][index + 1]["volumeInfo"]
                                    ["title"],
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.lato(
                                textStyle: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Flexible(
                          child: Text(
                            (widget.d["items"][index + 1]["volumeInfo"]
                                            ["authors"][0])
                                        .length >
                                    18
                                ? "by ${st(widget.d["items"][index + 1]["volumeInfo"]["authors"][0])}"
                                : "by ${widget.d["items"][index + 1]["volumeInfo"]["authors"][0]}",
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                    color: Colors.grey[400],
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Page Count:- ${widget.d["items"][index + 1]["volumeInfo"]["pageCount"]}",
                          style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          (widget.d["items"][index + 1]["volumeInfo"]
                                      ["averageRating"]) ==
                                  null
                              ? "⭐ Not available"
                              : "⭐ ${widget.d["items"][index + 1]["volumeInfo"]["averageRating"]}",
                          style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            getisbn(index);
                            if (isbn != null) {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return BookLoading(c: isbn);
                              }));
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                          ),
                          // color: Colors.black,
                          child: const Text(
                            "DETAILS",
                            style: TextStyle(
                                color: Color.fromARGB(255, 1, 42, 192),
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )),
            );
          }),
    ));
  }
}
