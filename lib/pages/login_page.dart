import 'package:firebase_auth/firebase_auth.dart';
import 'package:fltproject_v2/auth/login_or_register.dart';
import 'package:flutter/material.dart';
import 'package:fltproject_v2/components/text_field.dart';

import '../components/button.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();


  void signIn()async{
    //show loading circle
    showDialog(
        context: context,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
    );
    
    
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailTextController.text,
        password: passwordTextController.text,
      );

      if (context.mounted) Navigator.pop(context);
    } on FirebaseAuthException catch (e){
      Navigator.pop(context);
      displayMessage(e.code);
    }
  }

    //display a dialog message
  void displayMessage(String message){
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(message),
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child :Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [
                const Icon( // logo
                  Icons.lock,
                  size: 100,
                ),

                //welcome back message
                const SizedBox(
                  height: 50 ,
                ),
                Text(
                  "welcome backl, you've been missed!",
                  style: TextStyle(
                    color: Colors.grey[700],
                  ),
                ),

                //email textfield
                const SizedBox(height: 25,),
                MyTextField(
                  controller: emailTextController,
                  hintText: "Email",
                  obscureText: false,
                ),

                //password textfield
                const SizedBox(height: 10,),
                MyTextField(
                    controller: passwordTextController,
                    hintText: 'password',
                    obscureText: true),

                //sign in button
                const SizedBox(height: 10,),
                MyButton(
                  onTap:signIn,
                  text: 'Sign In',),

                const SizedBox(height: 20,),
                //go to register page
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Not a member?",
                      style: TextStyle(
                        color:
                        Colors.grey[700],
                      ),
                    ),
                    const SizedBox(width: 4,),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text("Register now",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),

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
