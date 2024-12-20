import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final _firebase = FirebaseAuth.instance;

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  var _isAuthenticating = false;
  var _enteredEmail = '';
  var _enteredPassword = '';
  final _form = GlobalKey<FormState>();

  void _login() async {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();

    try {
      setState(() {
        _isAuthenticating = true;
      });
      await _firebase.signInWithEmailAndPassword(
          email: _enteredEmail, password: _enteredPassword);
    } on FirebaseAuthException catch (error) {
      if (context.mounted) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).clearSnackBars();
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.message ?? 'Authentication Failed'),
            duration: const Duration(seconds: 3),
          ),
        );
      }
      setState(() {
        _isAuthenticating = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('IIIT Una Login'),
        centerTitle: true,
        backgroundColor: Colors.amber.shade700,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 30.0),
            Hero(
              tag: 'appLogo',
              child: Image.asset(
                'assets/images/Iiit-una-logo.png',
                width: 150.0,
              ),
            ),
            const SizedBox(height: 40.0),
            Form(
              key: _form,
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'E-mail Id',
                      prefixIcon: const Icon(Icons.email),
                      border: OutlineInputBorder(
                        // Added border
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        // Customize focused border
                        borderSide: BorderSide(
                            color: Colors.amber.shade700, width: 2.0),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    autocorrect: false,
                    keyboardType: TextInputType.emailAddress,
                    textCapitalization: TextCapitalization.none,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Enter E-mail address';
                      }
                      if (!value.contains('@')) {
                        return 'Invalid e-mail address';
                      }
                      if (!value.contains('@iiitu.ac.in')) {
                        return 'Enter IIITU\'s email address';
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      _enteredEmail = newValue!;
                    },
                  ),
                  const SizedBox(height: 15.0),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: const Icon(Icons.lock),
                      border: OutlineInputBorder(
                        // Added border
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        // Customize focused border
                        borderSide: BorderSide(
                            color: Colors.amber.shade700, width: 2.0),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    autocorrect: false,
                    textCapitalization: TextCapitalization.none,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Invalid password';
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      _enteredPassword = newValue!;
                    },
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber.shade700,
                      minimumSize: const Size(double.infinity, 50.0),
                    ),
                    child: _isAuthenticating
                        ? const CircularProgressIndicator()
                        : const Text('Login'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
