import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rim/constants.dart';
import 'package:rim/custom_widgets/alert_message.dart';
import 'package:rim/custom_widgets/confirm_alert_message.dart';
import 'package:rim/models/available_items.dart';
import 'package:rim/services/available_item_service.dart';
import 'package:rim/size_config.dart';

class ReturnItemListTile extends StatefulWidget {
  final String studentId;
  final String componentId;
  final String componentUID;
  final String issueDate;
  final int quanityToBeReturned;
  final String issueId;

  ReturnItemListTile({
    required this.studentId,
    required this.componentId,
    required this.componentUID,
    required this.issueDate,
    required this.quanityToBeReturned,
    required this.issueId,
  });

  @override
  State<ReturnItemListTile> createState() => _ReturnItemListTileState();
}

class _ReturnItemListTileState extends State<ReturnItemListTile> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  int componentsQuantityIssued = 0;
  int componentsQuantityAvailable = 0;

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      var provider = Provider.of<AvailableItemsList>(context, listen: false);
      List<AvailableItems> availableItemsList = [];
      getAvailableItems(availableItemsList);
      provider.initializingList(availableItemsList);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AvailableItemsList>(context);
    return Container(
      padding: EdgeInsets.only(
        right: 6.109 * SizeConfig.widthMultiplier!,
        top: 1.469 * SizeConfig.heightMultiplier!,
        bottom: 1 * SizeConfig.heightMultiplier!,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              for (var item in provider.availableItemsList) {
                if (item.componentId == widget.componentId) {
                  componentsQuantityAvailable =
                      int.parse(item.quantityAvailable);
                  componentsQuantityIssued = int.parse(item.quantityIssued);
                }
              }
              String currentDate = getCurrentDate();
              //Returning the item.
              showDialog(
                context: context,
                builder: (_) {
                  return ConfirmAlertMessage(
                    confirmingMessage:
                        'Do you want to confirm this component\'s return?',
                    confirmOnPressed: () {
                      Navigator.pop(context);
                      _firestore
                          .collection('history')
                          .doc(widget.issueId)
                          .update({
                        'return_date': currentDate,
                      });
                      _firestore
                          .collection('components')
                          .doc(widget.componentUID)
                          .update({
                        'quantity_issued': componentsQuantityIssued -
                            widget.quanityToBeReturned,
                        'quantity_available': componentsQuantityAvailable +
                            widget.quanityToBeReturned,
                      });
                      showDialog(
                        context: context,
                        builder: (_) {
                          return const AlertMessage(
                            message: 'Components Returned Successfully',
                          );
                        },
                      );
                    },
                    cancelOnPressed: () {
                      Navigator.pop(context);
                    },
                  );
                },
              );
            },
            icon: const Icon(Icons.keyboard_return),
            color: const Color(0xff5db075),
            iconSize: 4.887 * SizeConfig.widthMultiplier!,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                left: 2.036 * SizeConfig.widthMultiplier!,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: 1 * SizeConfig.heightMultiplier!,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.studentId,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontSize: 2.252 * SizeConfig.textMultiplier!,
                          ),
                        ),
                        Text(
                          widget.componentId,
                          style: TextStyle(
                            fontSize: 1.762 * SizeConfig.textMultiplier!,
                            color: const Color(0xffbdbdbd),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 0.489 * SizeConfig.heightMultiplier!,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Issue Date',
                              style: TextStyle(
                                color: const Color(0xff4b9460),
                                fontSize: 1.371 * SizeConfig.textMultiplier!,
                              ),
                            ),
                            SizedBox(
                              width: 1.01 * SizeConfig.widthMultiplier!,
                            ),
                            Text(
                              widget.issueDate,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 1.273 * SizeConfig.textMultiplier!,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Quantity Issued',
                              style: TextStyle(
                                color: const Color(0xff4b9460),
                                fontSize: 1.371 * SizeConfig.textMultiplier!,
                              ),
                            ),
                            SizedBox(
                              width: 1.01 * SizeConfig.widthMultiplier!,
                            ),
                            Text(
                              widget.quanityToBeReturned.toString(),
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 1.273 * SizeConfig.textMultiplier!,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
