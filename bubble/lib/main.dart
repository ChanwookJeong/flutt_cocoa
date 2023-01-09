import 'package:bubble/screens/chat_screen.dart';
import 'package:bubble/screens/firstPage.dart';
import 'package:bubble/screens/login_screen.dart';
import 'package:bubble/screens/makeStore.dart';
import 'package:bubble/screens/saleroomChat.dart';
import 'package:bubble/screens/second_testPage.dart';
import 'package:bubble/screens/sttings_sharedPreferences.dart';
import 'package:bubble/screens/testNodeJs.dart';
import 'package:bubble/screens/third_testPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        // "/" Route로 이동하면, FirstScreen 위젯을 생성합니다.
        '/home': (context) => First_screen(),
        // "/second" route로 이동하면, SecondScreen 위젯을 생성합니다.
        '/chat': (context) => ChatScreen(),
        //test Page
        '/test1': (context) => Second_testPage(),
        //test Page2
        '/test2': (context) => Third_testPage(),
        //test Page3
        '/makeStore': (context) => MakeStore(),
        //test Page3
        '/settings': (context) => SttingsSharedpreference(),
        //test Page3
        '/testnodejs': (context) => TestNodeJs(),
        //test Page3
        '/saleroomChat': (context) => SaleroomChat(),
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            //return ChatScreen();
            return First_screen();
          }
          return LoginSignupScreen();
        },
      ),
    );
  }
}
