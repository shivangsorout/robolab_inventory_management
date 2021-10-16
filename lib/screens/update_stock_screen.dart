import 'package:flutter/material.dart';
import 'package:rim/constants.dart';
import 'package:rim/screens/add_item_screen.dart';
import 'package:rim/services/components_list.dart';

class UpdateStockScreen extends StatelessWidget {
  static const String id = 'update_stock_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: kPaddingScreens,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ListTile(
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_sharp),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                title: const Text(
                  'Update Stock',
                  textAlign: TextAlign.center,
                  style: kTitleTextStyle,
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.add_circle),
                  onPressed: () {
                    Navigator.pushNamed(context, AddItemScreen.id);
                  },
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: const TextStyle(
                    fontSize: 17.0,
                    color: Color(0xffbdbdbd),
                  ),
                  filled: true,
                  fillColor: const Color(0xfff6f6f6),
                  border: kRoundedBorder,
                  enabledBorder: kRoundedBorder,
                  focusedBorder: kRoundedBorder,
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Divider(
                thickness: 1.5,
              ),
              ComponentsList(),
            ],
          ),
        ),
      ),
    );
  }
}
