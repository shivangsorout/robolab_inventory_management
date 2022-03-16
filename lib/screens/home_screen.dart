import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rim/custom_widgets/home_screen_tile.dart';
import 'package:rim/screens/available_stock_screen.dart';
import 'package:rim/screens/history_screen.dart';
import 'package:rim/screens/issue_items_screen.dart';
import 'package:rim/screens/return_items_screen.dart';
import 'package:rim/screens/update_stock_screen.dart';
import 'package:rim/screens/welcome_screen.dart';
import 'package:rim/services/app_service.dart';
import 'package:rim/services/shared_preferences_repository.dart';
import 'package:rim/size_config.dart';

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
    AppService provider = Provider.of(context, listen: false);
    provider.getAvailableItems();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 4 * SizeConfig.widthMultiplier!,
            vertical: 2 * SizeConfig.heightMultiplier!,
          ),
          child: Column(
            children: [
              ListTile(
                leading: IconButton(
                  onPressed: () {
                    _auth.signOut();
                    SharedPreferencesRepository().clearAll();
                    Navigator.pushReplacementNamed(
                      context,
                      WelcomeScreen.id,
                    );
                  },
                  icon: const Icon(Icons.logout),
                ),
                title: Text(
                  'Hello Autonomi!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: SizeConfig.textMultiplier! * 4,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: const CircleAvatar(
                  backgroundColor: Colors.blue,
                ),
              ),
              SizedBox(
                height: 5.7 * SizeConfig.heightMultiplier!,
              ),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 2.8 * SizeConfig.heightMultiplier!,
                  crossAxisSpacing: 2.8 * SizeConfig.widthMultiplier!,
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
