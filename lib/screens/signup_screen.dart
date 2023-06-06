import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:monark_uni/screens/login_screen.dart';
import 'package:monark_uni/screens/screen_layout.dart';
import 'package:monark_uni/screens/update_profile.dart';
import 'package:monark_uni/services/authmethod.dart';
import 'package:monark_uni/utils/utils.dart';

class SignupScreen extends StatefulWidget {
  // final TextEditingController enrollmentController;
  // final TextEditingController nameController;

  SignupScreen({
    super.key,
    // required this.enrollmentController,
    // required this.nameController,
  });

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _enrollmentController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  // TextEditingController reenterpasswordController = TextEditingController();
  bool _isLoading = false;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool isuserfetched = false;

  void signUpUser() async {
    // set loading to true
    setState(() {
      _isLoading = true;
    });

    // signup user using our authmethodds
    String res = await AuthMethods().signupUser(
        email: _emailController.text,
        password: _passwordController.text,
        enrollmentno: _enrollmentController.text,
        name: _nameController.text);

    if (res == "success") {
      setState(() {
        _isLoading = false;
      });

      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => UpdateProfileScreen()));
    } else {
      setState(() {
        _isLoading = false;
      });
      // show the error
      showSnackBar(context, res);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  Future<void> fetchNameFromDatabase(String enrollmentno) async {
    final doc =
        await _firestore.collection("dummy_user").doc(enrollmentno).get();

    if (doc.exists) {
      final name = doc.data()!['name'];
      _nameController.text = name;
      setState(() {
        isuserfetched = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            double squareSize = constraints.maxWidth * 0.20;
            return Padding(
              padding: EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Create Account",
                        style: TextStyle(fontSize: 20),
                      ),
                      TextField(
                        controller: _enrollmentController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(labelText: "enrollmentno"),
                        enabled: true,
                        onEditingComplete: () {
                          if (_enrollmentController.text.isNotEmpty) {
                            fetchNameFromDatabase(_enrollmentController
                                .text); // Fetch name from database
                            FocusScope.of(context).nextFocus();
                          } else {
                            _nameController.text = '';
                            isuserfetched = false;
                          }
                        },
                      ),
                      SizedBox(height: 16.0),
                      TextField(
                        controller: _nameController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(labelText: "name"),
                        enabled: false,
                      ),
                      SizedBox(height: 16.0),
                      TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(labelText: "email"),
                        enabled: true,
                      ),
                      SizedBox(height: 16.0),
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        // keyboardType: TextInputType.visiblePassword,
                        decoration:
                            InputDecoration(labelText: "create password"),
                        enabled: true,
                      ),
                      SizedBox(height: 32.0),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            minimumSize: const Size.fromHeight(50),
                            elevation: 0),
                        onPressed: signUpUser,
                        child: !_isLoading
                            ? Text("signup")
                            : CircularProgressIndicator(
                                color: Colors.white,
                              ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: const Text(
                              'Already have an account?',
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 8),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ),
                            ),
                            child: Container(
                              child: const Text(
                                ' Login.',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 8),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
