import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rim/constants.dart';
import 'package:rim/custom_widgets/alert_message.dart';
import 'package:rim/custom_widgets/confirm_alert_message.dart';
import 'package:rim/models/available_items.dart';
import 'package:rim/services/available_item_service.dart';

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
      padding: const EdgeInsets.only(
        right: 30.0,
        top: 15.0,
        bottom: 10.0,
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
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.studentId,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontSize: 25,
                          ),
                        ),
                        Text(
                          widget.componentId,
                          style: const TextStyle(
                            fontSize: 20.0,
                            color: Color(0xffbdbdbd),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Text(
                              'Issue Date',
                              style: TextStyle(
                                color: Color(0xff4b9460),
                                fontSize: 16.0,
                              ),
                            ),
                            const SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              widget.issueDate,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text(
                              'Quantity Issued',
                              style: TextStyle(
                                color: Color(0xff4b9460),
                                fontSize: 16.0,
                              ),
                            ),
                            const SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              widget.quanityToBeReturned.toString(),
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 16.0,
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
