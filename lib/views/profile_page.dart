import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:newsapplication/views/first_page.dart';
import 'package:newsapplication/views/postnewspage.dart';
import '../components/text_box.dart';
import 'admin_page.dart';
import 'drawer.dart';
import 'edit_delete_newspage.dart';
import 'homepage.dart';
import 'login_page.dart';
import 'nba_api.dart';
import 'shownewspage.dart';

class ProfileScreen extends StatefulWidget {
  final String userId;

  const ProfileScreen({required this.userId, Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final currentUser = FirebaseAuth.instance.currentUser!;

  final usersCollection = FirebaseFirestore.instance.collection("users");

  void goPostNewsPage() {
    Navigator.pop(context);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PostNews(
          userId: '', // Pass the user ID here
          key: UniqueKey(), // Generate a unique key
        ),
      ),
    );
  }

  void goToAdminPage() {
    Navigator.pop(context);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AdminPage(),
      ),
    );
  }

  void goGetNews() {
    Navigator.pop(context);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GetNews(),
      ),
    );
  }

  void goEditDeletePage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditDeleteNews(key: UniqueKey(),)),
    );
  }

  void goToHomePage() {
    Navigator.pop(context);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(),
      ),
    );
  }

  void goToProfilePage() {
    Navigator.pop(context);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfileScreen(userId: ''),
      ),
    );
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
    Navigator.pop(context);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FirstPage(),
      ),
    );
  }

  void goToNbaApiPage() {
    Navigator.pop(context);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NbaApi(),
      ),
    );
  }

  Future<void> editField(String field) async {
    String newValue = "";
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.black,
        title: Text(
          "Edit" + field,
          style: const TextStyle(color: Colors.white),
        ),
        content: TextField(
          autofocus: true,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: "Enter new $field",
            hintStyle: TextStyle(color: Colors.white),
          ),
          onChanged: (value) {
            newValue = value;
          },
        ),
        actions: [
          TextButton(
            child: Text(
              'Cancel',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: Text(
              'Save',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () => Navigator.of(context).pop(newValue),
          ),
        ],
      ),
    );

    //update in firestore

    if (newValue.trim().length > 0) {
      await usersCollection.doc(currentUser.email).update({field: newValue});
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text("Profile Page"),
        backgroundColor: Color(0xFF668D2E),
        centerTitle: true, // Set centerTitle to true
      ),
      drawer: MyDrawer(
        onHomePageTap: goToHomePage,
        onProfileTap: goToProfilePage,
        onAdminTap: goToAdminPage,
        onNbaTap: goToNbaApiPage,
        onGetNewsTap: goGetNews,
        onPostNewsTap: goPostNewsPage,
        onEditDeleteTap: goEditDeletePage,
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(currentUser.email.toString())
            .snapshots(),
        builder: (context, snapshot) {
          //get user data
          if (snapshot.hasData) {
            final userData = snapshot.data!.data() as Map<String, dynamic>;

            return ListView(
              children: [
                const SizedBox(
                  height: 50,
                ),

                // profile pic
                const Icon(
                  Icons.person,
                  size: 72,
                ),

                const SizedBox(height: 10),
                //user email
                Text(
                  currentUser.email!,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey[700]),
                ),

                const SizedBox(height: 50),

                const Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: Text(
                    "My Details",
                    style: TextStyle(color: Colors.blueGrey),
                  ),
                ),

                MyTextBox(
                  text: userData['first name'] ?? '',
                  sectionName: 'First Name',
                  onPressed: () => editField('first name'),
                ),

                MyTextBox(
                  text: userData['last name'] ?? '',
                  sectionName: 'Last Name',
                  onPressed: () => editField('last name'),
                ),

                MyTextBox(
                  text: userData['email'] ?? '',
                  sectionName: 'Email',
                  onPressed: () => editField('email'),
                ),

                MyTextBox(
                  text: userData['bio'] ?? '',
                  sectionName: 'bio',
                  onPressed: () => editField('bio'),
                ),

                const SizedBox(
                  height: 50,
                ),

                const SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20), // Adjust the value to change the roundness
                    ),
                    primary: Colors.redAccent, // Change the color to your desired color
                  ),
                  onPressed: () {
                    signOut();
                  },
                  child: const Text(
                    'Sign Out',
                  ),
                )

              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error${snapshot.error}'),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
