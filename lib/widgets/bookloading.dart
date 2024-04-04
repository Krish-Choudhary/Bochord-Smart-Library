// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:library_app/screens/bookdisplay.dart';

class BookLoading extends StatefulWidget {
  dynamic c;
  BookLoading({
    super.key,
    required this.c,
  });

  @override
  State<BookLoading> createState() => _BookLoadingState();
}

class _BookLoadingState extends State<BookLoading> {
  dynamic c2;

  @override
  void initState() {
    getdata();
    super.initState();
  }

  void getdata() async {
    try {
      Response r = await get(Uri.parse(
          "https://www.googleapis.com/books/v1/volumes?q=isbn:${widget.c}&key=AIzaSyAqxw3nnCxwNQXRmXb-ZFi8FTNyhz6kwGA"));
      c2 = jsonDecode(r.body);
      Navigator.of(context).pop();
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return BookDisplay(d: c2);
      }));
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Something went wrong: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return (const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    ));
  }
}
