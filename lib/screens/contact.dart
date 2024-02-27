import 'package:flutter/material.dart';

class Contact extends StatelessWidget {
  const Contact({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text("Contact Us"),
      ),
      body: ListView(
        children: const [
          SizedBox(height: 20),
          Center(
            child: CircleAvatar(
              radius: 100,
              backgroundImage: AssetImage('assets/images/IMG_8341 crop.JPG'),
            ),
          ),
          SizedBox(height: 20),
          // Center(child: Text("Mr. Ankush Kapoor",style: TextStyle(fontSize: 18),)),
          ListTile(
            visualDensity: VisualDensity(vertical: -3),
            title: Text('Name: Krish Choudhary'),
          ),
          ListTile(
            visualDensity: VisualDensity(vertical: -3),
            title: Text('Designation: Developer'),
          ),
          ListTile(
            visualDensity: VisualDensity(vertical: -3),
            leading: Icon(Icons.phone),
            title: Text('+918930901025'),
          ),
          ListTile(
            visualDensity: VisualDensity(vertical: -3),
            leading: Icon(Icons.email),
            title: Text('22224@iiitu.ac.in'),
          ),
        ],
      ),
    );
  }
}
