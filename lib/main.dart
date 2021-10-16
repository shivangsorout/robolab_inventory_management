import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rim/screens/add_item_screen.dart';
import 'package:rim/screens/available_stock_screen.dart';
import 'package:rim/screens/home_screen.dart';
import 'package:rim/screens/manager_signin_screen.dart';
import 'package:rim/screens/update_stock_screen.dart';
import 'package:rim/screens/welcome_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(RobolabManagement());
}

class RobolabManagement extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        ManagerSignInScreen.id: (context) => ManagerSignInScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        AvailableStockScreen.id: (context) => AvailableStockScreen(),
        UpdateStockScreen.id: (context) => UpdateStockScreen(),
        AddItemScreen.id: (context) => AddItemScreen(),
      },
    );
  }
}
