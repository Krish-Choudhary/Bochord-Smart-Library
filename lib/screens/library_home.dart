import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:library_app/model/library_book.dart';
import 'package:library_app/screens/admin_login.dart';
import 'package:library_app/screens/contact.dart';
import 'package:library_app/widgets/home_screen.dart';
import 'package:library_app/widgets/library.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firebase = FirebaseAuth.instance;
final _firestore = FirebaseFirestore.instance.collection('books');

class LibraryHome extends StatefulWidget {
  const LibraryHome({super.key});

  @override
  State<LibraryHome> createState() => _LibraryHomeState();
}

class _LibraryHomeState extends State<LibraryHome> {
  int selectedPageIndex = 0;

  List<LibraryBook> books = [];

  @override
  void initState() {
    super.initState();
    _fetchBooks();
  }

  Future<void> _fetchBooks() async {
    final results = await _firestore.get();
    books = results.docs.map((doc) => LibraryBook.fromFirestore(doc)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text('Home'),
      ),
      drawer: Drawer(
        child: ListView(
          // mainAxisSize: MainAxisSize.max,
          children: [
            // DrawerHeader(
            //   decoration: BoxDecoration(
            //     color: Theme.of(context).colorScheme.surface,
            //   ),
            //   child: Image.asset('assets/images/Iiit-una-logo.png'),
            // ),
            const SizedBox(height: 30),
            ListTile(
              leading: const Icon(Icons.perm_contact_calendar),
              title: const Text('Contact'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                  return const Contact();
                }));
              },
            ),
            ListTile(
              leading: const Icon(Icons.assignment_ind_outlined),
              title: const Text("Admin"),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return const AdminLogin();
                    },
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                _firebase.signOut();
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 12),
            if (selectedPageIndex == 0) const HomeScreen(),
            if (selectedPageIndex == 1) Library(books: books),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            selectedPageIndex = index;
          });
        },
        currentIndex: selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_rounded),
            label: 'ebooks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_library_sharp),
            label: 'Library',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.supervised_user_circle),
          //   label: 'My Profile',
          // ),
        ],
      ),
    );
  }
}
