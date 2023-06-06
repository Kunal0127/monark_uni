import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:monark_uni/screens/signup_screen.dart';

class IsItStudent extends StatefulWidget {
  IsItStudent({super.key});

  @override
  State<IsItStudent> createState() => _IsItStudentState();
}

class _IsItStudentState extends State<IsItStudent> {
  final TextEditingController enrollmentController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool isuserfetched = false;

  Future<void> fetchNameFromDatabase(String enrollmentno) async {
    final doc =
        await _firestore.collection("dummy_user").doc(enrollmentno).get();

    if (doc.exists) {
      final name = doc.data()!['name'];
      nameController.text = name;
      setState(() {
        isuserfetched = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(
                controller: enrollmentController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "enrollmentno"),
                onEditingComplete: () {
                  if (enrollmentController.text.isNotEmpty) {
                    fetchNameFromDatabase(
                        enrollmentController.text); // Fetch name from database
                    FocusScope.of(context).nextFocus();
                  } else {
                    nameController.text = '';
                    isuserfetched = false;
                  }
                },
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: "name"),
                enabled: false,
              ),
              SizedBox(height: 32.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    minimumSize: const Size.fromHeight(50),
                    elevation: 0),
                onPressed: isuserfetched == true
                    ? () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => SignupScreen(
                              // enrollmentController: enrollmentController,
                              // nameController: nameController,
                            ),
                          ),
                        )
                    : null,
                child: Text("Next"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
