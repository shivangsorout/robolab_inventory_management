import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rim/constants.dart';
import 'package:rim/custom_widgets/home_screen_tile.dart';
import 'package:rim/screens/available_stock_screen.dart';
import 'package:rim/screens/history_screen.dart';
import 'package:rim/screens/issue_items_screen.dart';
import 'package:rim/screens/manager_signin_screen.dart';
import 'package:rim/screens/return_items_screen.dart';
import 'package:rim/screens/update_stock_screen.dart';
import 'package:rim/screens/welcome_screen.dart';

User? loggedinUser;

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedinUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: kPaddingScreens,
          child: Column(
            children: [
              ListTile(
                leading: IconButton(
                  onPressed: () {
                    _auth.signOut();
                    Navigator.popUntil(
                      context,
                      ModalRoute.withName(WelcomeScreen.id),
                    );
                  },
                  icon: const Icon(Icons.logout),
                ),
                title: const Text(
                  'Hello Vinay!',
                  textAlign: TextAlign.center,
                  style: kTitleTextStyle,
                ),
                trailing: const CircleAvatar(
                  backgroundColor: Colors.blue,
                ),
              ),
              const SizedBox(
                height: 60.0,
              ),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 30.0,
                  crossAxisSpacing: 15.0,
                  children: [
                    HomeScreenTile(
                      imageAddress: 'assets/images/stock.png',
                      tileName: 'Available Stock',
                      onPress: () {
                        Navigator.pushNamed(context, AvailableStockScreen.id);
                      },
                    ),
                    HomeScreenTile(
                      imageAddress: 'assets/images/update.png',
                      tileName: 'Update Stock',
                      onPress: () {
                        Navigator.pushNamed(context, UpdateStockScreen.id);
                      },
                    ),
                    HomeScreenTile(
                      imageAddress: 'assets/images/issue.png',
                      tileName: 'Issue Items',
                      onPress: () {
                        Navigator.pushNamed(context, IssueItemsScreen.id);
                      },
                    ),
                    HomeScreenTile(
                      imageAddress: 'assets/images/return.png',
                      tileName: 'Return Items',
                      onPress: () {
                        Navigator.pushNamed(context, ReturnItemsScreen.id);
                      },
                    ),
                    HomeScreenTile(
                      imageAddress: 'assets/images/history.png',
                      tileName: 'History',
                      onPress: () {
                        Navigator.pushNamed(context, HistoryScreen.id);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
