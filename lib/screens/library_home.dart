import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:library_app/screens/contact.dart';
import 'package:library_app/widgets/book_card.dart';

final _firebase = FirebaseAuth.instance;

class LibraryHome extends StatefulWidget {
  const LibraryHome({super.key});

  @override
  State<LibraryHome> createState() => _LibraryHomeState();
}

class _LibraryHomeState extends State<LibraryHome> {
  int selectedPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text('Home'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 12),
          if (selectedPageIndex == 0)
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 10,
                children: const [
                  BookCard(
                      bookName: 'The Laws of Human Nature',
                      coverPage: 'assets/images/TheLawsOfHumanNature-1.png'),
                  BookCard(
                      bookName: 'Cracking The Coding Interview',
                      coverPage:
                          'assets/images/CrackingTheCodingInterview.png'),
                ],
              ),
            )
        ],
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
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                _firebase.signOut();
              },
            ),
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
          BottomNavigationBarItem(
            icon: Icon(Icons.supervised_user_circle),
            label: 'My Profile',
          ),
        ],
      ),
    );
  }
}
