import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fltproject_v2/components/text_field.dart';
import 'package:fltproject_v2/pages/drawer.dart';
import 'package:fltproject_v2/pages/profile_page.dart';
import 'package:flutter/material.dart';

import '../components/wall_post.dart';
import 'NBA_Api.dart';
import 'admin_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);


  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final currentUser = FirebaseAuth.instance.currentUser!;
  final textController = TextEditingController();
  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  void postMessage(){
    if(textController.text.isNotEmpty){
      FirebaseFirestore.instance.collection("User Posts").add({
        'UserEmail': currentUser.email,
        'Message': textController.text,
        'TimeStamp': Timestamp.now(),
      });
    }

    //clear the textField
    setState((){
      textController.clear();
    });
  }

  void goToAdminPage(){
    Navigator.pop(context);

    Navigator.push(context,MaterialPageRoute(builder: (context) => AdminPage(),),);
  }

  void goToApi(){
    Navigator.pop(context);

    Navigator.push(context,MaterialPageRoute(builder: (context) => NbaApi(),),);
  }

  void goToProfilePage(){
    Navigator.pop(context);

    Navigator.push(context,MaterialPageRoute(builder: (context) => ProfileScreen(),),);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text("xiaohongshu"),
        backgroundColor: Colors.grey[900],
        actions: [
          IconButton(
              onPressed: signOut,
              icon: Icon(Icons.logout),
          ),
        ],
      ),
      drawer: MyDrawer(
        onProfileTap: goToProfilePage,
        onSignOut: signOut,
        onAdminTap: goToAdminPage,
        onNBATap: goToApi,
      ),
      body: Center(
        child: Column(
          children: [
            //the wall
        
        Expanded(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
          .collection("User Posts").orderBy(
            "TimeStamp",
            descending: false,).snapshots(),
        builder: (context, snapshot){
              if(snapshot.hasData){
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index){
                    final post = snapshot.data!.docs[index];
                  return WallPost(
                    message:post['Message'],
                    user:post['UserEmail'],
                  );
                    },
                );
              }else if (snapshot.hasError){
                return Center(
                  child: Text("Error: ${snapshot.error}"),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
        },
        ),
        ),


            //post message
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Row(
                children: [
                  Expanded(
                    child: MyTextField(
                      controller: textController,
                      hintText: "Write ur wish here, it will happen soon.. ",
                      obscureText: false,
                    ),
                  ),

                  IconButton(
                      onPressed: postMessage,
                      icon: const Icon(Icons.arrow_circle_up)),
                ],
              ),
            ),

            //login as
            Text("Login as :" + currentUser.email!,
            style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 50,),
          ],
        ),
      ),
    );
  }



}
