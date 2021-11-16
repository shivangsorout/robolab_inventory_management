import 'package:flutter/material.dart';
import 'package:rim/constants.dart';
import 'package:rim/custom_widgets/return_item_list_tile.dart';

class ReturnItemsScreen extends StatefulWidget {
  static const String id = 'return_items_screen';

  @override
  State<ReturnItemsScreen> createState() => _ReturnItemsScreenState();
}

class _ReturnItemsScreenState extends State<ReturnItemsScreen> {
  List items = [
    ReturnItemListTile(
      componentId: '1',
      issueDate: '16/11/2021',
      quanityIssued: 40,
      studentId: '11835',
      issueId: '343',
    ),
    ReturnItemListTile(
      componentId: '1',
      issueDate: '16/11/2021',
      quanityIssued: 40,
      studentId: '11835',
      issueId: '',
    ),
  ];
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
                  'Return Items',
                  textAlign: TextAlign.center,
                  style: kTitleTextStyle,
                ),
                trailing: const Text(' '),
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
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    return items[index];
                  },
                  separatorBuilder: (context, index) => const Divider(
                    thickness: 1.5,
                    indent: 50.0,
                    endIndent: 27.0,
                  ),
                  itemCount: items.length,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
