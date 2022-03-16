import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rim/custom_widgets/alert_message.dart';
import 'package:rim/custom_widgets/confirm_alert_message.dart';
import 'package:rim/screens/edit_item_screen.dart';
import 'package:rim/screens/update_stock_screen.dart';
import 'package:rim/size_config.dart';

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
      if (mounted) {
        setState(() {
          documentReference = document.reference;
        });
      }
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
          padding: EdgeInsets.symmetric(
            horizontal: 6.11 * SizeConfig.widthMultiplier!,
            vertical: 1 * SizeConfig.heightMultiplier!,
          ),
          child: Column(
            children: [
              Padding(
                padding:
                    EdgeInsets.only(bottom: 1 * SizeConfig.heightMultiplier!),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: SizeConfig.widthMultiplier! * 50,
                      child: Text(
                        widget.componentName,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: 2.154 * SizeConfig.textMultiplier!,
                        ),
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
                  horizontal: 2.03 * SizeConfig.widthMultiplier!,
                  vertical: 0.49 * SizeConfig.heightMultiplier!,
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
                            Text(
                              'Total Quantity',
                              style: TextStyle(
                                color: const Color(0xff4b9460),
                                fontSize: 1.37 * SizeConfig.textMultiplier!,
                              ),
                            ),
                            SizedBox(
                              width: 1 * SizeConfig.widthMultiplier!,
                            ),
                            Text(
                              widget.totalQuantity.toString(),
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 1.37 * SizeConfig.textMultiplier!,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 1 * SizeConfig.heightMultiplier!,
                        ),
                        //Quantity Available
                        Row(
                          children: [
                            Text(
                              'Quantity Available',
                              style: TextStyle(
                                color: const Color(0xff4b9460),
                                fontSize: 1.37 * SizeConfig.textMultiplier!,
                              ),
                            ),
                            SizedBox(
                              width: 1 * SizeConfig.widthMultiplier!,
                            ),
                            Text(
                              widget.quantityAvailable.toString(),
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 1.37 * SizeConfig.textMultiplier!,
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
                            Text(
                              'Quantity Issued',
                              style: TextStyle(
                                color: const Color(0xff4b9460),
                                fontSize: 1.37 * SizeConfig.textMultiplier!,
                              ),
                            ),
                            SizedBox(
                              width: 1 * SizeConfig.widthMultiplier!,
                            ),
                            Text(
                              widget.quantityIssued.toString(),
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 1.37 * SizeConfig.textMultiplier!,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 1 * SizeConfig.heightMultiplier!,
                        ),
                        //Locker Number
                        Row(
                          children: [
                            Text(
                              'Locker Number',
                              style: TextStyle(
                                color: const Color(0xff4b9460),
                                fontSize: 1.37 * SizeConfig.textMultiplier!,
                              ),
                            ),
                            SizedBox(
                              width: 1 * SizeConfig.widthMultiplier!,
                            ),
                            Text(
                              widget.lockerNumber,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 1.37 * SizeConfig.textMultiplier!,
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
