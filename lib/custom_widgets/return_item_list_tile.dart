import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rim/constants.dart';

class ReturnItemListTile extends StatefulWidget {
  final String studentId;
  final String componentId;
  final String issueDate;
  final int quanityToBeReturned;
  final String issueId;

  ReturnItemListTile({
    required this.studentId,
    required this.componentId,
    required this.issueDate,
    required this.quanityToBeReturned,
    required this.issueId,
  });

  @override
  State<ReturnItemListTile> createState() => _ReturnItemListTileState();
}

class _ReturnItemListTileState extends State<ReturnItemListTile> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String componentDocumentId = '';
  int componentsQuantityIssued = 0;
  int componentsQuantityAvailable = 0;
  void _gettingInitialValues(QuerySnapshot snapshot) {
    for (var document in snapshot.docs) {
      componentDocumentId = document.id;
      componentsQuantityIssued = document.get('quantity_issued');
      componentsQuantityAvailable = document.get('quantity_available');
    }
  }

  @override
  void initState() {
    _firestore
        .collection('components')
        .where('id', isEqualTo: widget.componentId)
        .snapshots()
        .listen((QuerySnapshot snapshot) => _gettingInitialValues(snapshot));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
              String currentDate = getCurrentDate();
              //Returning the item.
              _firestore.collection('history').doc(widget.issueId).update({
                'return_date': currentDate,
              });
              _firestore
                  .collection('components')
                  .doc(componentDocumentId)
                  .update({
                'quantity_issued':
                    componentsQuantityIssued - widget.quanityToBeReturned,
                'quantity_available':
                    componentsQuantityAvailable + widget.quanityToBeReturned,
              });
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
