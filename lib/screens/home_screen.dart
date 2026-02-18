import 'package:ecommer_app/models/appmodel.dart';
import 'package:ecommer_app/screens/accountscreen.dart';
import 'package:ecommer_app/screens/app_homescreen.dart';
import 'package:ecommer_app/screens/categoriesscreen.dart';
import 'package:ecommer_app/screens/favoritescreen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Widget> screens = [
    AppHomescreen(ecommerceApp: ecommerceApp),
    FavoriteScreen(),
    CategoriesScreen(),
    AccountScreen(),
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.deepOrange,
        unselectedItemColor: Colors.black45,
        backgroundColor: Colors.white.withOpacity(0.7),
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.store), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border_outlined),
            label: "Favorite",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: "Categories",
          ),

          BottomNavigationBarItem(
            icon: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: CircleAvatar(
                radius: 11,
                backgroundImage: AssetImage("assets/images/avatar.png"),
              ),
            ),
            label: "Account",
          ),
        ],
      ),
      body: screens[_currentIndex],
    );
  }
}
