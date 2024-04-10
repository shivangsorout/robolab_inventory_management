import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rim/firebase_options.dart';
import 'package:rim/screens/add_item_screen.dart';
import 'package:rim/screens/available_stock_screen.dart';
import 'package:rim/screens/history_screen.dart';
import 'package:rim/screens/home_screen.dart';
import 'package:rim/screens/issue_items_screen.dart';
import 'package:rim/screens/manager_signin_screen.dart';
import 'package:rim/screens/return_items_screen.dart';
import 'package:rim/screens/update_stock_screen.dart';
import 'package:rim/screens/welcome_screen.dart';
import 'package:rim/services/app_service.dart';
import 'package:rim/size_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const RobolabManagement());
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white,
      statusBarColor: Colors.transparent, // status bar color
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarDividerColor: Colors.white,
    ),
  );
}

class RobolabManagement extends StatelessWidget {
  const RobolabManagement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppService>(
      create: (context) => AppService(),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return OrientationBuilder(
            builder: (context, orientation) {
              SizeConfig().init(constraints, orientation);
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                initialRoute: WelcomeScreen.id,
                routes: {
                  WelcomeScreen.id: (context) => WelcomeScreen(),
                  ManagerSignInScreen.id: (context) => ManagerSignInScreen(),
                  HomeScreen.id: (context) => HomeScreen(),
                  AvailableStockScreen.id: (context) => AvailableStockScreen(),
                  UpdateStockScreen.id: (context) => UpdateStockScreen(),
                  AddItemScreen.id: (context) => const AddItemScreen(),
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
