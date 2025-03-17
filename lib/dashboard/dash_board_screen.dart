import 'package:drs_booking/categories/view/categories_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:drs_booking/common/AppColors.dart';
import 'package:drs_booking/main.dart';
import 'package:flutter/material.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  DashBoardScreenState createState() => DashBoardScreenState();
}

class DashBoardScreenState extends State<DashBoardScreen> {
  int _selectedIndex = 0;
  final List<int> visitedPages = [];

  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  final List<String> _iconList = [
    'assets/icons/bottom_home_menu.png',
    'assets/icons/bottom_search_menu.png',
    'assets/icons/bottom_appointments_menu.png',
    'assets/icons/bottom_profile_menu.png'
  ];

  final pages = [
    const CategoriesScreen(),
    const MyHomePage(),
    const MyHomePage(),
    const MyHomePage()
  ];

  @override
  void initState() {
    super.initState();
    if (visitedPages.isEmpty) {
      visitedPages.add(_selectedIndex);
    }
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return List.generate(_iconList.length, (index) {
      return PersistentBottomNavBarItem(
        icon: Image.asset(
          _iconList[index],
          width: 30,
          height: 30,
        ),
      );
    });
  }

  Future<bool> _onPopScope() async {
    if (visitedPages.length > 1) {
      setState(() {
        visitedPages.removeLast();
        _selectedIndex = visitedPages.isNotEmpty ? visitedPages.last : 0;
      });
      return Future.value(false);
    } else {
      bool? logout = await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text(
            "Are you sure you want to log out?",
            style: TextStyle(
                color: AppColors.customDarkBlue,
                fontFamily: 'MetrischRegular',
                fontWeight: FontWeight.bold,
                fontSize: 18),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text("No",
                  style: TextStyle(
                      color: AppColors.customDarkBlue,
                      fontFamily: 'MetrischRegular',
                      fontWeight: FontWeight.bold,
                      fontSize: 16)),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(true);
              },
              child: const Text("Yes",
                  style: TextStyle(
                      color: AppColors.customDarkBlue,
                      fontFamily: 'MetrischRegular',
                      fontWeight: FontWeight.bold,
                      fontSize: 16)),
            ),
          ],
        ),
      );
      if (logout == true) {}
      return Future.value(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onPopScope,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: pages[_selectedIndex],
          bottomNavigationBar: PersistentTabView(
            context,
            controller: _controller,
            screens: pages,
            items: _navBarsItems(),
            backgroundColor: Colors.white,
            handleAndroidBackButtonPress: true,
            resizeToAvoidBottomInset: true,
            stateManagement: true,
            navBarStyle: NavBarStyle.style6,
            decoration: const NavBarDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                colorBehindNavBar: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
