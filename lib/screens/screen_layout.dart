import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:monark_uni/screens/login_screen.dart';
import 'package:monark_uni/services/authmethod.dart';
import 'package:monark_uni/utils/global_variable.dart';

class ScreenLayout extends StatefulWidget {
  const ScreenLayout({super.key});

  @override
  State<ScreenLayout> createState() => _ScreenLayoutState();
}

class _ScreenLayoutState extends State<ScreenLayout> {
  int _page = 0;
  PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    @override
    void initState() {
      super.initState();
      pageController = PageController();
    }

    @override
    void dispose() {
      super.dispose();
      pageController.dispose();
    }

    void onPageChanged(int page) {
      setState(() {
        _page = page;
      });
    }

    void navigationTapped(int page) {
      //Animating Page
      pageController.jumpToPage(page);
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        elevation: 0,
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: PageView(
        controller: pageController,
        onPageChanged: onPageChanged,
        children: homeScreenItems,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        // backgroundColor: Colors.amber,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_filled,
              color: (_page == 0) ? Colors.amber : Colors.grey,
            ),
            label: '',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.notifications_none,
              color: (_page == 1) ? Colors.amber : Colors.grey,
            ),
            label: '',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_circle,
              color: Colors.white,
            ),
            label: '',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.chat_bubble_outline_rounded,
              color: (_page == 3) ? Colors.amber : Colors.grey,
            ),
            label: '',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.menu,
              color: (_page == 4) ? Colors.amber : Colors.grey,
            ),
            label: '',
            backgroundColor: Colors.white,
          ),
        ],

        type: BottomNavigationBarType.fixed,
        elevation: 0,
        onTap: navigationTapped,
        currentIndex: _page,
      ),
    );
  }
}

// Center(
//         child: ElevatedButton(
//             onPressed: () async {
//               await AuthMethods().signOut();
//               Navigator.of(context).pushReplacement(
//                 MaterialPageRoute(builder: (context) => LoginScreen()),
//               );
//             },
//             child: Text("Logout")),
//       ),