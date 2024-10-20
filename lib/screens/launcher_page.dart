import 'package:flutter/material.dart';
import 'package:gallery_app/main.dart';
import 'package:gallery_app/providers/auth_provider.dart';
import 'package:gallery_app/screens/home_screen.dart';
import 'package:gallery_app/screens/login_screen.dart';
import 'package:provider/provider.dart';

class LauncherPage extends StatefulWidget {
  static const String routeName = '/';

  const LauncherPage({super.key});

  @override
  State<LauncherPage> createState() => _LauncherPageState();
}

class _LauncherPageState extends State<LauncherPage> {
  @override
  void didChangeDependencies() {
    final authProvider = context.read<FirebaseAuthProvider>();
    Future.delayed(const Duration(seconds: 0), () {
      if (authProvider.currentUser != null) {
        Navigator.pushReplacementNamed(context, HomeScreen.routeName);
      } else {
        Navigator.pushReplacementNamed(context, LoginScreen.routeName);
      }
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
