import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rim/custom_widgets/alert_message.dart';
import 'package:rim/custom_widgets/confirm_alert_message.dart';
import 'package:rim/screens/edit_item_screen.dart';
import 'package:rim/screens/update_stock_screen.dart';

class StockListTile extends StatefulWidget {
  final String componentName;
  final String componentId;
  final int totalQuantity;
  final String lockerNumber;
  final int quantityIssued;
  final int quantityAvailable;

  StockListTile({
    required this.componentName,
    required this.componentId,
    required this.totalQuantity,
    required this.lockerNumber,
    required this.quantityIssued,
    required this.quantityAvailable,
  });

  @override
  State<StockListTile> createState() => _StockListTileState();
}

class _StockListTileState extends State<StockListTile> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late DocumentReference<Object?> documentReference;

  void getDocumentReference(QuerySnapshot snapshot) {
    for (var document in snapshot.docs) {
      setState(() {
        documentReference = document.reference;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: ModalRoute.of(context)?.settings.name == UpdateStockScreen.id
            ? () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        EditItemScreen(componentId: widget.componentId),
                  ),
                );
              }
            : null,
        onLongPress: ModalRoute.of(context)?.settings.name ==
                UpdateStockScreen.id
            ? () async {
                showDialog(
                  context: context,
                  builder: (_) {
                    return ConfirmAlertMessage(
                      confirmingMessage:
                          'Do you want to confirm this component\'s deletion?',
                      confirmOnPressed: () async {
                        Navigator.pop(context);
                        _firestore
                            .collection('components')
                            .where('id', isEqualTo: widget.componentId)
                            .snapshots()
                            .listen((QuerySnapshot snapshot) =>
                                getDocumentReference(snapshot));
                        await _firestore
                            .runTransaction((Transaction myTransaction) async {
                          myTransaction.delete(documentReference);
                        });
                        showDialog(
                            context: context,
                            builder: (_) {
                              return const AlertMessage(
                                message: 'Component Deleted Successfully',
                              );
                            });
                      },
                      cancelOnPressed: () {
                        Navigator.pop(context);
                      },
                    );
                  },
                );
              }
            : null,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 30.0,
            vertical: 10.0,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.componentName,
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
                  horizontal: 10.0,
                  vertical: 5.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Total Quantity
                        Row(
                          children: [
                            const Text(
                              'Total Quantity',
                              style: TextStyle(
                                color: Color(0xff4b9460),
                                fontSize: 16.0,
                              ),
                            ),
                            const SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              widget.totalQuantity.toString(),
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        //Quantity Available
                        Row(
                          children: [
                            const Text(
                              'Quantity Available',
                              style: TextStyle(
                                color: Color(0xff4b9460),
                                fontSize: 16.0,
                              ),
                            ),
                            const SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              widget.quantityAvailable.toString(),
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Quantity Issued
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
                              widget.quantityIssued.toString(),
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        //Locker Number
                        Row(
                          children: [
                            const Text(
                              'Locker Number',
                              style: TextStyle(
                                color: Color(0xff4b9460),
                                fontSize: 16.0,
                              ),
                            ),
                            const SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              widget.lockerNumber,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 16.0,
                              ),
                            ),
                          ],
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
    );
  }
}
