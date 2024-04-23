// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:library_app/model/library_book.dart';
import 'package:firebase_storage/firebase_storage.dart';

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
  File? _selectedImage;

  void _uploadBook() async {
    try {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('cover_pages')
          .child('${bookName}_$authorName.jpg');
      await storageRef.putFile(_selectedImage!);
      final imageUrl = await storageRef.getDownloadURL();
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(error.toString()),
          duration: const Duration(seconds: 2),
        ));
      }
    }
  }

  void _saveBook() {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    if (_selectedImage == null) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Upload Cover page'),
        duration: Duration(seconds: 2),
      ));
      return;
    }
    if (!isAvailable && _selectedDate == null) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Select Availability Date'),
        duration: Duration(seconds: 2),
      ));
      return;
    }
    _form.currentState!.save();
    _uploadBook();
  }

  void _selectPicture() async {
    ImageSource? source;
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Choose Image Source'),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    child: Icon(
                      Icons.camera_alt,
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.7),
                      size: 100,
                    ),
                    onTap: () {
                      setState(() {
                        source = ImageSource.camera;
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                  const Text(
                    'Camera',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    child: Icon(
                      Icons.image,
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.7),
                      size: 100,
                    ),
                    onTap: () {
                      setState(() {
                        source = ImageSource.gallery;
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                  const Text(
                    'Gallery',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(
      source: source!,
      maxWidth: 600,
    );

    if (pickedImage == null) {
      return;
    }
    setState(() {
      _selectedImage = File(pickedImage.path);
    });
  }

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
        child: SingleChildScrollView(
          child: Card(
            margin: const EdgeInsets.all(20),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Form(
                key: _form,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (_selectedImage != null)
                      GestureDetector(
                          onTap: _selectPicture,
                          child: Image.file(
                            _selectedImage!,
                            fit: BoxFit.fitHeight,
                            height: 200,
                          )),
                    if (_selectedImage == null)
                      TextButton.icon(
                        icon: const Icon(Icons.camera_alt),
                        label: const Text("Take Picture"),
                        onPressed: _selectPicture,
                      ),
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
                      decoration:
                          const InputDecoration(labelText: 'Author Name'),
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
                    const SizedBox(height: 15),
                    Center(
                      child: ElevatedButton(
                        onPressed: _saveBook,
                        child: const Text('Add book'),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
