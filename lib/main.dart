import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gallery_app/firebase_options.dart';
import 'package:gallery_app/providers/auth_provider.dart';
import 'package:gallery_app/providers/gallery_provider.dart';
import 'package:gallery_app/screens/home_screen.dart';
import 'package:gallery_app/screens/launcher_page.dart';
import 'package:gallery_app/screens/login_screen.dart';
import 'package:gallery_app/themes/light_theme.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => GalleryProvider(),),
      ChangeNotifierProvider(create: (context) => FirebaseAuthProvider(),),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: lightTheme,
      builder: EasyLoading.init(),
      initialRoute: LauncherPage.routeName,
      routes: {
        LauncherPage.routeName : (context) => const LauncherPage(),
        LoginScreen.routeName : (context) => const LoginScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
      },
    );
  }
}
