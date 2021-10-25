import 'package:flutter/material.dart';
import 'package:rim/constants.dart';
import 'package:rim/custom_widgets/history_list_tile.dart';
import 'package:rim/custom_widgets/return_item_list_tile.dart';

class HistoryScreen extends StatefulWidget {
  static const String id = 'history_screen';

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List history = [
    HistoryListTile(),
    HistoryListTile(),
    HistoryListTile(),
    HistoryListTile(),
    HistoryListTile(),
    HistoryListTile(),
    HistoryListTile(),
    HistoryListTile(),
    HistoryListTile(),
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
                  'History',
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
                    return history[index];
                  },
                  separatorBuilder: (context, index) => const Divider(
                    thickness: 1.5,
                    indent: 27.0,
                    endIndent: 27.0,
                  ),
                  itemCount: history.length,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}