import 'package:newsapplication/views/login_page.dart';
import 'package:newsapplication/views/register_page.dart';
import 'package:flutter/material.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({Key? key}) : super(key: key);

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {

  // initially show the login page
  bool showLoginPage = true;

  //toggle between login and register page
  void togglePages() {
  setState(() {
    showLoginPage = !showLoginPage;
  });
}


  @override
  Widget build(BuildContext context) {
    if (showLoginPage){
      return LoginPage(onTap: togglePages);
    }else{
      return RegisterPage(onTap: togglePages);
    }
  }
}
