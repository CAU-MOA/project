/*
flutterfire configure
flutter pub add cloud_firestore
 */

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'LoginPage.dart';
import 'gesipan_screen.dart';

void main() async {
  // firebase 초기 처리
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,   // 빨간 배너
      title: 'Group15',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return  HomePage();
            } else {
              return const LoginPage();
            }
          }
      ),
    );
  }
}








///////////////////////


/*
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_firebase/LoginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
import 'LoginPage.dart';
import 'SuccessRegister.dart';
import 'ChatPage.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,   // 빨간 배너
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: StreamBuilder(
        // login이 됐는지 logout이 됐는지, 변화를 알려주는
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) { //login이 되었다면 chat page표시
            if(snapshot.hasData) {
              return const ChatPage();
            } else { // login이 안되면 login창으로
              return const LoginPage();

            }
          } //무엇을 할것이냐

      ),
      //const LoginPage(),
    );
  }
}



 */
