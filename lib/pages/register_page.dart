import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fltproject_v2/components/text_field.dart';
import 'package:fltproject_v2/components/button.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({
    super.key,
    required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final confirmPasswordTextController = TextEditingController();

  void signUp()async{
    showDialog(
      context: context,
      builder: (context)=> const Center(
      child: CircularProgressIndicator(),
    ),);

    if(passwordTextController.text != confirmPasswordTextController.text){
      Navigator.pop(context);

      displayMessage("Password dont match!");
      return;
    }

    try{
      UserCredential userCredential =
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: emailTextController.text,
          password :passwordTextController.text,
      );

      //here
      FirebaseFirestore.instance.collection("users")
          .doc(userCredential.user!.email)
          .set({
        'username': emailTextController.text.split('@')[0],
        'bio' : 'Empty bio',
        'first name' : 'Empty first name',
        'last name' : 'Empty last name',
        'email' : emailTextController.text,
      });

    }on FirebaseAuthException catch(e){
      Navigator.pop(context);
      displayMessage(e.code);
    }

  }// end signUp

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
                  "Lets create a new account !",
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

                //confirm password textfield
                const SizedBox(height: 10,),
                MyTextField(
                    controller: confirmPasswordTextController,
                    hintText: 'confirm password',
                    obscureText: true),

                //sign in button
                const SizedBox(height: 25,),
                MyButton(
                  onTap: signUp,
                  text: 'Sign Up',),

                const SizedBox(height: 10,),
                //go to register page
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account ?",
                      style: TextStyle(
                        color:
                        Colors.grey[700],
                      ),
                    ),
                    const SizedBox(width: 4,),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text("Login now",
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
