import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rim/constants.dart';
import 'package:rim/custom_widgets/alert_message.dart';
import 'package:rim/custom_widgets/item_card.dart';
import 'package:rim/custom_widgets/component_details_tile.dart';
import 'package:rim/custom_widgets/custom_button.dart';
import 'package:rim/models/available_items.dart';
import 'package:rim/models/issue_item_details.dart';
import 'package:rim/services/available_item_service.dart';
import 'package:rim/size_config.dart';

class IssueItemsScreen extends StatefulWidget {
  static const String id = 'issue_items_screen';

  @override
  State<IssueItemsScreen> createState() => _IssueItemsScreenState();
}

class _IssueItemsScreenState extends State<IssueItemsScreen> {
  List<ItemCard> itemCardsList = [];
  List<IssueItemDetails> quantityExceedItemList = [];
  List<IssueItemDetails> notEnabledItemList = [];
  List<IssueItemDetails> notValidatedItemList = [];
  List<IssueItemDetails> duplicateItemList = [];
  List<IssueItemDetails> itemDetailsList = [];
  List<AvailableItems> availableItemsList = [];
  bool valErrorStudentId = false;
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
    var temp = ItemCard(
      quantityFieldEnabled: (index) {
        itemDetailsList[index].quantityTextFieldEnabled =
            (!itemDetailsList[index].isAvailable ||
                    itemDetailsList[index].itemDoesNotExist)
                ? false
                : true;
        return itemDetailsList[index].quantityTextFieldEnabled;
      },
      errorTextComponentId: (index) {
        String? text = itemDetailsList[index].valErrorComponentId
            ? 'Component Id can\'t be empty!'
            : null;
        return text;
      },
      errorTextQuantity: (index) {
        String? text = itemDetailsList[index].valErrorQuantity
            ? 'Quantity can\'t be empty!'
            : null;
        return text;
      },
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
              if (int.parse(item.quantityAvailable) != 0) {
                itemDetailsList[index].isAvailable = true;
              }
              setState(() {
                itemDetailsList[index]
                    .setQuantityAvailable(int.parse(item.quantityAvailable));
                itemDetailsList[index].valErrorComponentId
                    ? val == ''
                        ? itemDetailsList[index].valErrorComponentId = true
                        : itemDetailsList[index].valErrorComponentId = false
                    : null;
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
            itemDetailsList[index].isQuantityExceedMaxQuantityAvailable = true;
          }
        }
        setState(() {
          itemDetailsList[index].valErrorQuantity
              ? val == ''
                  ? itemDetailsList[index].valErrorQuantity = true
                  : itemDetailsList[index].valErrorQuantity = false
              : null;
        });
      },
      onDeleted: (index) {
        setState(() {
          itemCardsList.removeAt(index);
          itemDetailsList.removeAt(index);
        });
      },
    );
    itemCardsList = [
      ItemCard(
        quantityFieldEnabled: temp.quantityFieldEnabled,
        errorTextComponentId: temp.errorTextComponentId,
        errorTextQuantity: temp.errorTextComponentId,
        notifyingTextColor: temp.notifyingTextColor,
        notifyingText: temp.notifyingText,
        visibilityText: temp.visibilityText,
        componentIdController: temp.componentIdController,
        quantityIssuedController: temp.quantityIssuedController,
        onChangedComponentId: temp.onChangedComponentId,
        onChangedQuantityIssued: temp.onChangedQuantityIssued,
        onDeleted: temp.onDeleted,
      )
    ];
    itemDetailsList = [
      IssueItemDetails(
        componentIdController: temp.componentIdController,
        quantityToBeIssuedController: temp.quantityIssuedController,
      ),
    ];
  }

  @override
  void initState() {
    // TODO: implement initState
    studentIdController = TextEditingController();
    getAvailableItems(availableItemsList);
    initializeLists();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AvailableItemsList>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 4 * SizeConfig.widthMultiplier!,
            vertical: 2 * SizeConfig.heightMultiplier!,
          ),
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
                title: Text(
                  'Issue Items',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: SizeConfig.textMultiplier! * 4,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                trailing: const Text(''),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 1 * SizeConfig.heightMultiplier!,
                  horizontal: 2.03 * SizeConfig.widthMultiplier!,
                ),
                child: ComponentDetailsTile(
                  keyboardType: TextInputType.text,
                  controller: studentIdController,
                  errorText:
                      valErrorStudentId ? 'Student Id can\'t be empty!' : null,
                  onChanged: (val) {
                    studentId = val;
                    setState(() {
                      valErrorStudentId
                          ? val == ''
                              ? valErrorStudentId = true
                              : valErrorStudentId = false
                          : null;
                    });
                  },
                  tileName: 'Student Id',
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    var temp = itemCardsList[index];
                    itemCardsList[index] = ItemCard(
                      quantityFieldEnabled: (index) {
                        itemDetailsList[index].quantityTextFieldEnabled =
                            (!itemDetailsList[index].isAvailable ||
                                    itemDetailsList[index].itemDoesNotExist)
                                ? false
                                : true;
                        return itemDetailsList[index].quantityTextFieldEnabled;
                      },
                      errorTextComponentId: (index) {
                        String? text =
                            itemDetailsList[index].valErrorComponentId
                                ? 'Component Id can\'t be empty!'
                                : null;
                        return text;
                      },
                      errorTextQuantity: (index) {
                        String? text = itemDetailsList[index].valErrorQuantity
                            ? 'Quantity can\'t be empty!'
                            : null;
                        return text;
                      },
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
                    itemDetailsList[index].componentIdController =
                        temp.componentIdController;
                    itemDetailsList[index].quantityToBeIssuedController =
                        temp.quantityIssuedController;
                    return itemCardsList[index];
                  },
                  itemCount: itemCardsList.length,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 1.958 * SizeConfig.heightMultiplier!,
                    ),
                    child: CustomButton(
                      backgroundColor: const Color(0xff5db075),
                      text: '  Add another item  ',
                      onPressed: () {
                        setState(() {
                          itemCardsList.add(
                            ItemCard(
                              quantityFieldEnabled: (index) {
                                itemDetailsList[index]
                                        .quantityTextFieldEnabled =
                                    (!itemDetailsList[index].isAvailable ||
                                            itemDetailsList[index]
                                                .itemDoesNotExist)
                                        ? false
                                        : true;
                                return itemDetailsList[index]
                                    .quantityTextFieldEnabled;
                              },
                              errorTextComponentId: (index) {
                                String? text =
                                    itemDetailsList[index].valErrorComponentId
                                        ? 'Component Id can\'t be empty!'
                                        : null;
                                return text;
                              },
                              errorTextQuantity: (index) {
                                String? text =
                                    itemDetailsList[index].valErrorQuantity
                                        ? 'Quantity can\'t be empty!'
                                        : null;
                                return text;
                              },
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
                                      if (int.parse(item.quantityAvailable) !=
                                          0) {
                                        itemDetailsList[index].isAvailable =
                                            true;
                                      }
                                      itemDetailsList[index]
                                          .setQuantityAvailable(int.parse(
                                              item.quantityAvailable));
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
                                setState(() {
                                  itemDetailsList[index].valErrorComponentId
                                      ? val == ''
                                          ? itemDetailsList[index]
                                              .valErrorComponentId = true
                                          : itemDetailsList[index]
                                              .valErrorComponentId = false
                                      : null;
                                });
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
                                setState(() {
                                  itemDetailsList[index].valErrorQuantity
                                      ? val == ''
                                          ? itemDetailsList[index]
                                              .valErrorQuantity = true
                                          : itemDetailsList[index]
                                              .valErrorQuantity = false
                                      : null;
                                });
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
                        provider.initializingList(availableItemsList);
                        currentDate = getCurrentDate();
                        setState(() {
                          studentId == '' || studentId == null
                              ? valErrorStudentId = true
                              : valErrorStudentId = false;
                        });
                        //For checking if any item is not exceeding the quantity available
                        for (var item in itemDetailsList) {
                          if (item.isQuantityExceedMaxQuantityAvailable) {
                            quantityExceedItemList.add(item);
                          }
                        }
                        //For checking that fields are enabled in the cards or not
                        for (var item in itemDetailsList) {
                          if (!item.quantityTextFieldEnabled) {
                            notEnabledItemList.add(item);
                          }
                        }

                        //For checking the validations of the fields in card
                        for (var item in itemDetailsList) {
                          setState(() {
                            item.component_id == '' || item.component_id == null
                                ? item.valErrorComponentId = true
                                : item.valErrorComponentId = false;
                            item.quantity_to_be_issued == '' ||
                                    item.quantity_to_be_issued == null
                                ? item.valErrorQuantity = true
                                : item.valErrorQuantity = false;
                          });
                          if (item.valErrorComponentId ||
                              item.valErrorQuantity) {
                            notValidatedItemList.add(item);
                          }
                        }
                        //For checking duplication of the items
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
                          if (duplicateItemList.isEmpty &&
                              notValidatedItemList.isEmpty &&
                              notEnabledItemList.isEmpty &&
                              quantityExceedItemList.isEmpty &&
                              itemDetailsList.isNotEmpty &&
                              !valErrorStudentId) {
                            for (var item in itemDetailsList) {
                              for (var component in availableItemsList) {
                                if (component.componentId ==
                                    item.component_id) {
                                  _firestore.collection('history').add({
                                    'student_id': studentId,
                                    'component_id': item.component_id,
                                    'issue_date': currentDate,
                                    'quantity_issued':
                                        int.parse(item.quantity_to_be_issued),
                                    'return_date': 'NA',
                                    'component_uid': component.docId,
                                  }).then((docRef) {
                                    _firestore
                                        .collection('history')
                                        .doc(docRef.id)
                                        .update({
                                      'history_id': docRef.id,
                                    });
                                  });
                                  _firestore
                                      .collection('components')
                                      .doc(component.docId)
                                      .update({
                                    'quantity_issued':
                                        int.parse(item.quantity_to_be_issued) +
                                            int.parse(component.quantityIssued),
                                    'quantity_available': int.parse(
                                            component.quantityAvailable) -
                                        int.parse(item.quantity_to_be_issued),
                                  });
                                }
                              }
                            }
                            showDialog(
                              context: context,
                              builder: (_) {
                                return const AlertMessage(
                                  message: 'Components Issued Successfully',
                                );
                              },
                            ).then(
                              (value) {
                                Navigator.pop(context);
                              },
                            );
                          } else if (itemDetailsList.isEmpty) {
                            showDialog(
                              context: context,
                              builder: (_) {
                                return const AlertMessage(
                                  message:
                                      'No items issued! Please Issue at least one item.',
                                );
                              },
                            );
                          } else if (!duplicateItemList.isEmpty) {
                            String duplicateItems = '';
                            for (var i in duplicateItemList) {
                              if (i ==
                                  duplicateItemList[
                                      (duplicateItemList.length - 1)]) {
                                duplicateItems =
                                    duplicateItems + (i.index! + 1).toString();
                              } else {
                                duplicateItems = duplicateItems +
                                    (i.index! + 1).toString() +
                                    ', ';
                              }
                            }
                            showDialog(
                              context: context,
                              builder: (_) {
                                return AlertMessage(
                                  message:
                                      'Duplicate Items found in item cards: ' +
                                          duplicateItems +
                                          '. Please resolve this issue.',
                                );
                              },
                            ).then(
                              (value) {
                                duplicateItemList.clear();
                              },
                            );
                          } else {
                            for (var i in notEnabledItemList) {
                              print('Not Enabled Item Card: ' +
                                  (i.index! + 1).toString());
                            }
                            for (var i in notValidatedItemList) {
                              print('Not Validated Item Card: ' +
                                  (i.index! + 1).toString());
                            }
                            for (var i in quantityExceedItemList) {
                              print('Quantity exceed of Item: ' +
                                  (i.index! + 1).toString());
                            }
                            notValidatedItemList.clear();
                            notEnabledItemList.clear();
                            quantityExceedItemList.clear();
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
