import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rim/constants.dart';
import 'package:rim/custom_widgets/item_card.dart';
import 'package:rim/custom_widgets/component_details_tile.dart';
import 'package:rim/custom_widgets/custom_button.dart';
import 'package:rim/models/available_items.dart';
import 'package:rim/models/issue_item_details.dart';

class IssueItemsScreen extends StatefulWidget {
  static const String id = 'issue_items_screen';

  @override
  State<IssueItemsScreen> createState() => _IssueItemsScreenState();
}

class _IssueItemsScreenState extends State<IssueItemsScreen> {
  List<ItemCard> itemCardsList = [];
  List<IssueItemDetails> duplicateItemList = [];
  List<IssueItemDetails> itemDetailsList = [];
  List<AvailableItems> availableItemsList = [];
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String studentId = '';
  late TextEditingController studentIdController;
  String currentDate = '';
  Map<int, String> componentsAvailabilityState = {
    0: 'This component is available with max quantity of ',
    1: 'This component is not available at the moment.',
    2: 'You have entered wrong id!',
    3: 'You are requesting more than available quantity!',
  };
  Map<int, Color> notificationTextColor = {
    0: const Color(0xff5db075),
    1: Colors.red,
    2: const Color(0xfffaad14),
  };

  void getAvailableItems() async {
    var snapshots = _firestore.collection('components').snapshots();
    await for (var snapshot in snapshots) {
      for (var component in snapshot.docs) {
        availableItemsList.add(AvailableItems(
          quantityIssued: component.get('quantity_issued').toString(),
          componentId: component.get('id'),
          quantity: component.get('quantity_available').toString(),
          docId: component.id,
        ));
        // for (var i in availableItemsList)
        //   print(i.componentId + ':' + i.quantity);
      }
    }
  }

  Color notifyingColor(int index) {
    int colorIndex = 0;
    if (itemDetailsList[index].itemDoesNotExist) {
      colorIndex = 1;
    } else {
      if (itemDetailsList[index].isAvailable) {
        if (itemDetailsList[index].isQuantityExceedMaxQuantityAvailable) {
          colorIndex = 1;
        } else {
          colorIndex = 0;
        }
      } else {
        colorIndex = 2;
      }
    }
    return notificationTextColor[colorIndex]!;
  }

  String notifyingText(int index) {
    String returningText = '';
    if (itemDetailsList[index].itemDoesNotExist) {
      returningText = componentsAvailabilityState[2]!;
    } else {
      if (itemDetailsList[index].isAvailable) {
        if (itemDetailsList[index].isQuantityExceedMaxQuantityAvailable) {
          returningText = componentsAvailabilityState[3]!;
        } else {
          returningText = componentsAvailabilityState[0]! +
              itemDetailsList[index].quantity_available.toString() +
              '.';
        }
      } else {
        returningText = componentsAvailabilityState[1]!;
      }
    }
    return returningText;
  }

  void initializeLists() {
    itemCardsList = [
      ItemCard(
        notifyingTextColor: notifyingColor,
        notifyingText: notifyingText,
        visibilityText: (index) {
          return itemDetailsList[index].textVisibility;
        },
        componentIdController: TextEditingController(),
        quantityIssuedController: TextEditingController(),
        onChangedComponentId: (val, index) {
          itemDetailsList[index].setComponentId(val);
          itemDetailsList[index].itemDoesNotExist = false;
          if (val == '') {
            itemDetailsList[index].textVisibility = false;
          } else {
            itemDetailsList[index].textVisibility = true;
          }
          if (itemDetailsList[index].component_id != '') {
            int flag = 0;
            for (var item in availableItemsList) {
              if (itemDetailsList[index].component_id == item.componentId) {
                if (int.parse(item.quantity) != 0) {
                  itemDetailsList[index].isAvailable = true;
                }
                setState(() {
                  itemDetailsList[index]
                      .setQuantityAvailable(int.parse(item.quantity));
                });
                flag++;
              }
            }
            if (flag == 0) {
              itemDetailsList[index].itemDoesNotExist = true;
            }
          } else {
            itemDetailsList[index].itemDoesNotExist = false;
            itemDetailsList[index].isAvailable = false;
          }
        },
        onChangedQuantityIssued: (val, index) {
          itemDetailsList[index].setQuantityToBeIssued(val);
          itemDetailsList[index].isQuantityExceedMaxQuantityAvailable = false;
          if (itemDetailsList[index].quantity_available != 0 &&
              itemDetailsList[index].quantity_to_be_issued != '') {
            if (int.parse(itemDetailsList[index].quantity_to_be_issued) >
                itemDetailsList[index].quantity_available) {
              itemDetailsList[index].isQuantityExceedMaxQuantityAvailable =
                  true;
            }
          }
        },
        onDeleted: (index) {
          setState(() {
            itemCardsList.removeAt(index);
            itemDetailsList.removeAt(index);
          });
        },
      )
    ];
    itemDetailsList = [
      IssueItemDetails(
        componentIdController: TextEditingController(),
        quantityToBeIssuedController: TextEditingController(),
      ),
    ];
  }

  @override
  void initState() {
    // TODO: implement initState
    studentIdController = TextEditingController();
    getAvailableItems();
    initializeLists();
    super.initState();
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
                  controller: studentIdController,
                  errorText: null,
                  onChanged: (val) {
                    studentId = val;
                  },
                  tileName: 'Student Id',
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    var temp = itemCardsList[index];
                    itemCardsList[index] = ItemCard(
                      index: index,
                      onDeleted: temp.onDeleted,
                      onChangedComponentId: temp.onChangedComponentId,
                      onChangedQuantityIssued: temp.onChangedQuantityIssued,
                      visibilityText: temp.visibilityText,
                      notifyingText: temp.notifyingText,
                      notifyingTextColor: temp.notifyingTextColor,
                      componentIdController: temp.componentIdController,
                      quantityIssuedController: temp.quantityIssuedController,
                    );
                    itemDetailsList[index].setIndex(index);
                    return itemCardsList[index];
                  },
                  itemCount: itemCardsList.length,
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
                          itemCardsList.add(
                            ItemCard(
                              // index: (items.length),
                              notifyingTextColor: notifyingColor,
                              notifyingText: notifyingText,
                              visibilityText: (index) {
                                return itemDetailsList[index].textVisibility;
                              },
                              componentIdController: TextEditingController(),
                              quantityIssuedController: TextEditingController(),
                              onChangedComponentId: (val, index) {
                                itemDetailsList[index].setComponentId(val);
                                itemDetailsList[index].itemDoesNotExist = false;
                                if (val == '') {
                                  itemDetailsList[index].textVisibility = false;
                                } else {
                                  itemDetailsList[index].textVisibility = true;
                                }
                                if (itemDetailsList[index].component_id != '') {
                                  int flag = 0;
                                  for (var item in availableItemsList) {
                                    if (itemDetailsList[index].component_id ==
                                        item.componentId) {
                                      if (int.parse(item.quantity) != 0) {
                                        itemDetailsList[index].isAvailable =
                                            true;
                                      }
                                      itemDetailsList[index]
                                          .setQuantityAvailable(
                                              int.parse(item.quantity));
                                      flag++;
                                    }
                                  }
                                  if (flag == 0) {
                                    itemDetailsList[index].itemDoesNotExist =
                                        true;
                                  }
                                } else {
                                  itemDetailsList[index].itemDoesNotExist =
                                      false;
                                  itemDetailsList[index].isAvailable = false;
                                }
                              },
                              onChangedQuantityIssued: (val, index) {
                                itemDetailsList[index]
                                    .setQuantityToBeIssued(val);
                                itemDetailsList[index]
                                        .isQuantityExceedMaxQuantityAvailable =
                                    false;
                                if (itemDetailsList[index].quantity_available !=
                                        0 &&
                                    itemDetailsList[index]
                                            .quantity_to_be_issued !=
                                        '') {
                                  if (int.parse(itemDetailsList[index]
                                          .quantity_to_be_issued) >
                                      itemDetailsList[index]
                                          .quantity_available) {
                                    itemDetailsList[index]
                                            .isQuantityExceedMaxQuantityAvailable =
                                        true;
                                  }
                                }
                              },
                              onDeleted: (index) {
                                setState(() {
                                  itemCardsList.removeAt(index);
                                  itemDetailsList.removeAt(index);
                                });
                              },
                            ),
                          );
                          itemDetailsList.add(
                            IssueItemDetails(
                              componentIdController: TextEditingController(),
                              quantityToBeIssuedController:
                                  TextEditingController(),
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
                      onPressed: () {
                        currentDate = getCurrentDate();
                        for (var itemI in itemDetailsList) {
                          int matches = -1;
                          for (var itemJ in itemDetailsList) {
                            if (itemI.component_id == itemJ.component_id &&
                                (itemI.component_id != "" &&
                                    itemI.component_id != null) &&
                                (itemJ.component_id != "" &&
                                    itemJ.component_id != null)) {
                              matches += 1;
                            }
                          }
                          if (matches >= 1) {
                            duplicateItemList.add(itemI);
                          }
                        }
                        try {
                          if (duplicateItemList.isEmpty) {
                            for (var item in itemDetailsList) {
                              _firestore.collection('issue_items').add({
                                'student_id': studentId,
                                'component_id': item.component_id,
                                'quantity_issued':
                                    int.parse(item.quantity_to_be_issued),
                                'issue_date': currentDate,
                              }).then((docRef) {
                                _firestore
                                    .collection('issue_items')
                                    .doc(docRef.id)
                                    .update({
                                  'issue_id': docRef.id,
                                });
                              });
                              for (var component in availableItemsList) {
                                if (component.componentId ==
                                    item.component_id) {
                                  _firestore
                                      .collection('components')
                                      .doc(component.docId)
                                      .update({
                                    'quantity_issued':
                                        int.parse(item.quantity_to_be_issued) +
                                            int.parse(component.quantityIssued),
                                    'quantity_available': int.parse(
                                            component.quantity) -
                                        int.parse(item.quantity_to_be_issued),
                                  });
                                }
                              }
                              _firestore.collection('history').add({
                                'student_id': studentId,
                                'component_id': item.component_id,
                                'issue_date': currentDate,
                                'quantity_issued':
                                    int.parse(item.quantity_to_be_issued),
                                'return_date': 'NA',
                              }).then((docRef) {
                                _firestore
                                    .collection('history')
                                    .doc(docRef.id)
                                    .update({
                                  'history_id': docRef.id,
                                });
                              });
                            }
                          } else {
                            for (var i in duplicateItemList)
                              print(i.component_id);
                            duplicateItemList.clear();
                          }
                        } catch (e) {
                          print(e);
                        }
                      },
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
