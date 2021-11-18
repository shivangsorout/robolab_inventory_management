import 'package:rim/custom_widgets/return_item_list_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;

class IssuedItemsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('history').snapshots(),
      builder: (context, snapshot) {
        List<ReturnItemListTile> itemsList = [];
        final issuedItems = snapshot.data?.docs ?? [];
        for (var document in issuedItems) {
          if (document.get('return_date') == 'NA') {
            itemsList.add(
              ReturnItemListTile(
                componentUID: document.get('component_uid'),
                componentId: document.get('component_id'),
                issueDate: document.get('issue_date'),
                quanityToBeReturned: document.get('quantity_issued'),
                studentId: document.get('student_id'),
                issueId: document.get('history_id'),
              ),
            );
          }
        }
        return Expanded(
          child: ListView.separated(
            itemBuilder: (context, index) {
              return itemsList[index];
            },
            separatorBuilder: (context, index) => const Divider(
              thickness: 1.5,
              indent: 50.0,
              endIndent: 27.0,
            ),
            itemCount: itemsList.length,
          ),
        );
      },
    );
  }
}
