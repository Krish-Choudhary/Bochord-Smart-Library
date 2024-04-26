// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:library_app/screens/admin_home.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() {
    return _AdminLoginState();
  }
}

class _AdminLoginState extends State<AdminLogin> {
  bool _isSending = false;
  String _userName = '';
  String _password = '';
  final _form = GlobalKey<FormState>();

  void _login() async {
    final isValid = _form.currentState!.validate();
    if (!isValid) return;
    _form.currentState!.save();
    setState(() {
      _isSending = true;
    });
    _form.currentState!.reset();
    final cred = await FirebaseFirestore.instance
        .collection('Admin')
        .doc('Credentials')
        .get();
    final response = cred.data();
    final usernameMatches = response!['username'] == _userName;
    final passwordMatches = response['password'] == _password;
    if (usernameMatches && passwordMatches) {
      if (!context.mounted) return;
      Navigator.of(context).pop();
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) {
          return const AdminHome();
        },
      ));
    } else {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).clearSnackBars();
      setState(() {
        _isSending = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          'Incorrect username and password',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 206, 42, 31),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Login'),
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Card(
            margin: const EdgeInsets.all(15),
            child: Form(
              key: _form,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: TextFormField(
                      decoration: const InputDecoration(labelText: 'Username'),
                      autocorrect: false,
                      enableSuggestions: false,
                      initialValue: '',
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null) {
                          return 'Username can\'t be null';
                        } else if (value.trim().isEmpty) {
                          return 'Enter username';
                        } else if (value.trim().length < 4) {
                          return 'Username is atleast 4 characters long';
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        setState(() {
                          _userName = newValue!;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextFormField(
                      decoration: const InputDecoration(labelText: 'Password'),
                      autocorrect: false,
                      enableSuggestions: false,
                      initialValue: '',
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      validator: (value) {
                        if (value == null) {
                          return 'Password can\'t be null';
                        } else if (value.trim().isEmpty) {
                          return 'Enter password';
                        } else if (value.trim().length < 5) {
                          return 'Password is atleast 5 characters long';
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        setState(() {
                          _password = newValue!;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: _isSending ? null : _login,
                    child: _isSending
                        ? const CircularProgressIndicator()
                        : const Text('Login'),
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
