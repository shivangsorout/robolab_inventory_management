import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:rim/screens/add_item_screen.dart';
import 'package:rim/screens/available_stock_screen.dart';
import 'package:rim/screens/history_screen.dart';
import 'package:rim/screens/home_screen.dart';
import 'package:rim/screens/issue_items_screen.dart';
import 'package:rim/screens/manager_signin_screen.dart';
import 'package:rim/screens/return_items_screen.dart';
import 'package:rim/screens/update_stock_screen.dart';
import 'package:rim/screens/welcome_screen.dart';
import 'package:rim/services/available_item_service.dart';
import 'package:rim/size_config.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(RobolabManagement());
}

class RobolabManagement extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AvailableItemsList>(
      create: (context) => AvailableItemsList(),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return OrientationBuilder(
            builder: (context, orientation) {
              SizeConfig().init(constraints, orientation);
              return MaterialApp(
                initialRoute: WelcomeScreen.id,
                routes: {
                  WelcomeScreen.id: (context) => WelcomeScreen(),
                  ManagerSignInScreen.id: (context) => ManagerSignInScreen(),
                  HomeScreen.id: (context) => HomeScreen(),
                  AvailableStockScreen.id: (context) => AvailableStockScreen(),
                  UpdateStockScreen.id: (context) => UpdateStockScreen(),
                  AddItemScreen.id: (context) => AddItemScreen(),
                  IssueItemsScreen.id: (context) => IssueItemsScreen(),
                  ReturnItemsScreen.id: (context) => ReturnItemsScreen(),
                  HistoryScreen.id: (context) => HistoryScreen(),
                },
              );
            },
          );
        },
      ),
    );
  }
}
