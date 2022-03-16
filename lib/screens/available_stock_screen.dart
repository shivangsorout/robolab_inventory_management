import 'package:flutter/material.dart';
import 'package:rim/constants.dart';
import 'package:rim/services/components_list.dart';
import 'package:rim/size_config.dart';

class AvailableStockScreen extends StatefulWidget {
  static const String id = 'available_stock_screen';

  @override
  State<AvailableStockScreen> createState() => _AvailableStockScreenState();
}

class _AvailableStockScreenState extends State<AvailableStockScreen> {
  String searchText = '';

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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ListTile(
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_sharp),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                title: Text(
                  'Available Stock',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: SizeConfig.textMultiplier! * 4,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: const Text(' '),
              ),
              SizedBox(
                height: 2.94 * SizeConfig.heightMultiplier!,
              ),
              TextField(
                onChanged: (value) {
                  setState(() {
                    searchText = value.toLowerCase();
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(
                    fontSize: 1.5 * SizeConfig.textMultiplier!,
                    color: const Color(0xffbdbdbd),
                  ),
                  filled: true,
                  fillColor: const Color(0xfff6f6f6),
                  border: kRoundedBorder,
                  enabledBorder: kRoundedBorder,
                  focusedBorder: kRoundedBorder,
                ),
              ),
              SizedBox(
                height: 1 * SizeConfig.heightMultiplier!,
              ),
              const Divider(
                thickness: 1.5,
              ),
              ComponentsList(searchText: searchText),
            ],
          ),
        ),
      ),
    );
  }
}
