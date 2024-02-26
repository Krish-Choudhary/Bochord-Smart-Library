import 'package:flutter/material.dart';

class Contact extends StatelessWidget {
  const Contact({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: const [
          SizedBox(height: 20),
          Center(
            child: CircleAvatar(
              radius: 100,
              backgroundImage: NetworkImage(
                  'https://iiitu.ac.in/wp-content/uploads/2022/01/mr_ankushkapoor.jpg'),
            ),
          ),
        ],
      ),
    );
  }
}
