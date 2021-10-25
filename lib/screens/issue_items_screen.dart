import 'package:flutter/material.dart';
import 'package:rim/constants.dart';
import 'package:rim/custom_widgets/item_card.dart';
import 'package:rim/custom_widgets/component_details_tile.dart';
import 'package:rim/custom_widgets/custom_button.dart';

class IssueItemsScreen extends StatefulWidget {
  static const String id = 'issue_items_screen';

  @override
  State<IssueItemsScreen> createState() => _IssueItemsScreenState();
}

class _IssueItemsScreenState extends State<IssueItemsScreen> {
  List<ItemCard> items = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    items = [
      ItemCard(
        onDeleted: (index) {
          setState(() {
            items.removeAt(index);
          });
        },
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: kPaddingScreens,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              ListTile(
                leading: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                title: const Text(
                  'Issue Items',
                  style: kTitleTextStyle,
                  textAlign: TextAlign.center,
                ),
                trailing: const Text(''),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ComponentDetailsTile(
                  errorText: null,
                  onChanged: (val) {},
                  tileName: 'Student Id',
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    items[index].index = index;
                    return items[index];
                  },
                  itemCount: items.length,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                    child: CustomButton(
                      backgroundColor: const Color(0xff5db075),
                      text: '  Add another item  ',
                      onPressed: () {
                        setState(() {
                          items.add(
                            ItemCard(
                              // index: (items.length),
                              onDeleted: (index) {
                                setState(() {
                                  items.removeAt(index);
                                });
                              },
                            ),
                          );
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    width: double.maxFinite,
                    child: CustomButton(
                      backgroundColor: const Color(0xff5db075),
                      text: 'Issue Items',
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
