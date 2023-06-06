import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:monark_uni/provider/user_provider.dart';
import 'package:monark_uni/screens/isitstudent_screen.dart';
import 'package:monark_uni/screens/login_screen.dart';
import 'package:monark_uni/screens/screen_layout.dart';
import 'package:monark_uni/screens/signup_screen.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "monarkuni",
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return ScreenLayout();
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return LoginScreen();
          },
        ),
      ),
    );
  }
}
    // return MaterialApp(
    //   title: 'monarkuni',
    //   debugShowCheckedModeBanner: false,
    //   theme: ThemeData(
    //     primarySwatch: Colors.blue,
    //   ),
    //   home: SignupScreen(),
    // );

// class AuthenticationWrapper extends StatelessWidget {
//   const AuthenticationWrapper({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final authProvider = Provider.of<AuthenticationProvider>(context);
//     return StreamBuilder<User?>(
//       stream: FirebaseAuth.instance.authStateChanges(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.active) {
//           final User? user = snapshot.data;
//           if (user == null) {
//             return LoginScreen();
//           } else {
//             return SignupScreen();
//           }
//         }
//         return Scaffold(
//           body: Center(
//             child: CircularProgressIndicator(),
//           ),
//         );
//       },
//     );
//   }
// }


// class AuthenticationProvider with ChangeNotifier {
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   Future<void> login(String email, String password) async {
//     try {
//       await _auth.signInWithEmailAndPassword(email: email, password: password);
//     } catch (e) {
//       print('Login Error: $e');
//       throw e;
//     }
//   }

//   Future<void> resetPassword(String email) async {
//     try {
//       await _auth.sendPasswordResetEmail(email: email);
//     } catch (e) {
//       print('Reset Password Error: $e');
//       throw e;
//     }
//   }

//   Future<void> logout() async {
//     try {
//       await _auth.signOut();
//     } catch (e) {
//       print('Logout Error: $e');
//       throw e;
//     }
//   }
// }