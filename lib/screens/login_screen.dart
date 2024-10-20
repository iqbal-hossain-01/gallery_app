import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gallery_app/providers/auth_provider.dart';
import 'package:gallery_app/screens/home_screen.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LauncherPageState();
}

class _LauncherPageState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _errorMsg = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 48.0, vertical: 4.0),
                child: TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: 'Email Address',
                    prefixIcon: Icon(Icons.email),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is empty';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 48.0, vertical: 4.0),
                child: TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'Password',
                    prefixIcon: Icon(Icons.password),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is empty';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: _loginAdmin,
                child: RichText(
                  text: const TextSpan(
                    text: 'Login',
                    style: TextStyle(
                      color: Colors.black,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                _errorMsg,
                style: const TextStyle(
                  fontSize: 18.0,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _loginAdmin() async {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text;
      final password = _passwordController.text;
      EasyLoading.show(status: 'Please wait...');
      try {
        final isAdmin = await context.read<FirebaseAuthProvider>().login(email, password);
        if (isAdmin) {
          Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        } else {
          await context.read<FirebaseAuthProvider>().logout();
          setState(() {
            _errorMsg = 'মুরুব্বি মুরুব্বি উহ উহ, নো নো।';
          });
        }
      } on FirebaseAuthException catch (error) {
        setState(() {
          _errorMsg = 'Login failed: ${error.message}';
        });
      } finally {
        EasyLoading.dismiss();
      }
    }
  }
}
