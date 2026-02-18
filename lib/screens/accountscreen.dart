import 'package:ecommer_app/widgets/accounttile.dart';
import 'package:ecommer_app/provider/auth_provider.dart';
import 'package:ecommer_app/screens/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_screen.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  AccountScreenState createState() => AccountScreenState();
}

class AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(15),
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade200,
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (_) => HomeScreen()),
                              );

                            },
                            child: Icon(Icons.arrow_back),
                          ),
                          Text(
                            "Profile",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Icon(Icons.edit),
                        ],
                      ),
                      SizedBox(height: 10),
                      Center(
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.green),
                              ),
                              child: CircleAvatar(
                                radius: 35,
                                backgroundImage: AssetImage(
                                  "assets/images/avatar.png",
                                ),
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "Arjun UI",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "ID : 1979736885",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [BoxShadow(color: Colors.white, blurRadius: 3)],
                  ),
                  child: Column(
                    children: [
                      settingTile(Icons.person, "Edit Profile", false, () {}),
                      settingTile(
                        Icons.mail,
                        "nagarjuna@gmail.com",
                        false,
                        () {},
                      ),
                      settingTile(
                        Icons.location_on,
                        "Shopping Address",
                        false,
                        () {},
                      ),
                      settingTile(Icons.favorite, "Favorites", false, () {}),
                      settingTile(Icons.history_edu, "My Orders", false, () {}),
                      settingTile(
                        Icons.notifications,
                        "Notification",
                        false,
                        () {},
                      ),
                      settingTile(Icons.credit_card, "Cards", false, () {}),
                      settingTile(
                        Icons.help_center,
                        "Help Center",
                        false,
                        () {},
                      ),
                      settingTile(
                        Icons.policy,
                        "Terms & Conditions",
                        false,
                        () {},
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Column(
                  children: [
                    settingTile(Icons.logout, "Log Out", true, () {
                      context.read<AuthProvider>().logOut();
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (_) => LoginScreen()),
                        (route) => false,
                      );
                    }),
                    settingTile(Icons.delete, "Delete Account", false, () {}),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
