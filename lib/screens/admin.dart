import 'package:flutter/material.dart';
import 'package:library_app/model/library_book.dart';

class Admin extends StatefulWidget {
  const Admin({super.key});

  @override
  State<Admin> createState() {
    return _AdminState();
  }
}

class _AdminState extends State<Admin> {
  final _form = GlobalKey<FormState>();
  String bookName = '';
  String authorName = '';
  bool isAvailable = true;
  DateTime? _selectedDate;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(now.year, now.month, now.day + 30),
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget dropDown = DropdownButtonFormField(
      decoration: const InputDecoration(labelText: "Availability"),
      value: isAvailable,
      items: const [
        DropdownMenuItem(
          value: true,
          child: Text('Available',
              style: TextStyle(color: Color.fromARGB(255, 17, 145, 21))),
        ),
        DropdownMenuItem(
          value: false,
          child: Text(
            'Not-Available',
            style: TextStyle(color: Color.fromARGB(255, 150, 27, 19)),
          ),
        ),
      ],
      onChanged: (value) {
        setState(() {
          isAvailable = value!;
        });
      },
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add book"),
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(20),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Form(
              key: _form,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Book Name'),
                    autocorrect: false,
                    initialValue: bookName,
                    validator: (value) {
                      if (value == null) {
                        return 'Book name can\'t be null';
                      }
                      if (value.trim().length < 2) {
                        return 'Book name is too short';
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      setState(() {
                        bookName = newValue!;
                      });
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Author Name'),
                    autocorrect: false,
                    keyboardType: TextInputType.name,
                    initialValue: authorName,
                    textCapitalization: TextCapitalization.words,
                    validator: (value) {
                      if (value == null) {
                        return 'Author name can\'t be null';
                      }
                      if (value.trim().length < 4) {
                        return 'Author name is too short';
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      setState(() {
                        authorName = newValue!;
                      });
                    },
                  ),
                  isAvailable
                      ? Center(
                          child: SizedBox(
                            width: 150,
                            child: dropDown,
                          ),
                        )
                      : Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(child: dropDown),
                            const SizedBox(width: 25),
                            _selectedDate == null
                                ? const Text(
                                    'No date selected',
                                    style: TextStyle(fontSize: 16),
                                  )
                                : Text(
                                    formatter.format(_selectedDate!),
                                    style: const TextStyle(fontSize: 16),
                                  ),
                            const SizedBox(width: 15),
                            SizedBox(
                                width: 20,
                                child: GestureDetector(
                                  onTap: _presentDatePicker,
                                  child: const Icon(Icons.calendar_month),
                                )),
                            const SizedBox(width: 15),
                          ],
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
