import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:newsapplication/views/edit_delete_newspage.dart';
import 'package:newsapplication/views/first_page.dart';
import 'package:newsapplication/views/homepage.dart';
import 'package:newsapplication/views/postnewspage.dart';
import 'package:newsapplication/views/profile_page.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:newsapplication/views/shownewspage.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FirstPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}



