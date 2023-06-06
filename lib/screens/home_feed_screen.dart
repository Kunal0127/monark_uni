import 'package:flutter/material.dart';
import 'package:monark_uni/screens/login_screen.dart';
import 'package:monark_uni/services/authmethod.dart';

class HomeFeedScreen extends StatefulWidget {
  const HomeFeedScreen({super.key});

  @override
  State<HomeFeedScreen> createState() => _HomeFeedScreenState();
}

class _HomeFeedScreenState extends State<HomeFeedScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            centerTitle: false,
            leadingWidth: 150,
            backgroundColor: Colors.white,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: CircleAvatar(
                    child: Image.asset("assets/images/logo02.png"),
                    backgroundColor: Colors.transparent,
                  ),
                ),
                Expanded(
                  child: Text(
                    "Kunal P Vaghela",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.black),
                  ),
                )
              ],
            ),
            // leading: Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Text(
            //     "USerNameesgsefaaefefaf",
            //     style: TextStyle(color: Colors.black),
            //   ),
            // ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.search_sharp,
                ),
                color: Colors.black,
              ),
              IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.person_outline),
                  color: Colors.black),
            ],
            bottom: TabBar(
              tabs: [
                Tab(
                  child: Text(
                    "For You",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                Tab(
                    child: Text(
                  "Following",
                  style: TextStyle(color: Colors.black),
                )),
              ],
            ),
          ),
          body: TabBarView(children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () async {
                      await AuthMethods().signOut();

                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                          (route) => false);
                    },
                    child: Text("Logout")),
                Center(
                  child: Text("For You Feed"),
                ),
              ],
            ),
            Center(
              child: Text("Following Feed"),
            ),
          ]),
        ),
      ),
    );
  }
}
