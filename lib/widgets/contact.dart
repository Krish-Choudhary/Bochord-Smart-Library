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
              backgroundImage: NetworkImage(
                  'https://iiitu.ac.in/wp-content/uploads/2022/01/mr_ankushkapoor.jpg'),
            ),
          ),
          // SizedBox(height: 10),
          // Center(child: Text("Mr. Ankush Kapoor",style: TextStyle(fontSize: 18),)),
          ListTile(
            title: Text('Name: Mr. Ankush Kapoor'),
          ),
          ListTile(
            title: Text('Designation: Librarian'),
          ),
          ListTile(
            leading: Icon(Icons.phone),
            title: Text('+919418953816'),
          ),
          ListTile(
            leading: Icon(Icons.email),
            title: Text('ankush@iiitu.ac.in'),
          ),
        ],
      ),
    );
  }
}
