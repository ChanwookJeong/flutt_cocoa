import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../screens/sttings_sharedPreferences.dart';
import 'package:get/get.dart';

class BaseDrawer extends StatefulWidget {
  const BaseDrawer({super.key});

  @override
  State<BaseDrawer> createState() => _BaseDrawerState();
}

class _BaseDrawerState extends State<BaseDrawer> {
  final user = FirebaseAuth.instance.currentUser;
  final Stream<DocumentSnapshot> _usersStream = FirebaseFirestore.instance
      .collection("Users")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .snapshots();
  final _authentication = FirebaseAuth.instance;

  final spinkit = SpinKitFadingCircle(
    itemBuilder: (BuildContext context, int index) {
      return DecoratedBox(
        decoration: BoxDecoration(
          color: index.isEven ? Colors.red : Colors.green,
        ),
      );
    },
  );

  @override
  Widget build(BuildContext context) {
    final Stream<DocumentSnapshot> _usersStream = FirebaseFirestore.instance
        .collection("user")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
    return StreamBuilder<DocumentSnapshot>(
        stream: _usersStream,
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (!snapshot.hasData) {
            return spinkit;
          } else if (snapshot.hasError) {
            return Text('Something went wrong');
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            // return CircularProgressIndicator();
            return spinkit;
          }
          dynamic data = snapshot.data;
          final String userImage = data['picked_image'];
          return Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                UserAccountsDrawerHeader(
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: NetworkImage(userImage),
                    backgroundColor: Colors.white,
                  ),
                  otherAccountsPictures: [
                    CircleAvatar(
                      backgroundImage: AssetImage('image/bat1.png'),
                      backgroundColor: Colors.white,
                    ),
                    CircleAvatar(
                      backgroundImage: AssetImage('image/bat2.png'),
                      backgroundColor: Colors.white,
                    ),
                  ],
                  accountName: Text('${data['userName']}'),
                  accountEmail: Text('${data['email']}'),
                  onDetailsPressed: () {},
                  decoration: BoxDecoration(
                    color: Colors.orange[200],
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40.0),
                      bottomRight: Radius.circular(40.0),
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.exit_to_app_sharp,
                    color: Colors.grey[500],
                  ),
                  title: Text('logout'),
                  // trailing: Icon(Icons.phone_forwarded),
                  onTap: () {
                    _authentication.signOut();
                  },
                ),
              ],
            ),
          );
        });
  }
}
