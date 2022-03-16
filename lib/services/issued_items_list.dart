import 'package:rim/custom_widgets/return_item_list_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rim/size_config.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;

class IssuedItemsList extends StatelessWidget {
  final String searchText;

  IssuedItemsList({
    required this.searchText,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('history').snapshots(),
      builder: (context, snapshot) {
        List<ReturnItemListTile> itemsList = [];
        final issuedItems = snapshot.data?.docs ?? [];
        if (searchText == '') {
          for (var document in issuedItems) {
            var returnDate = document.get('return_date');
            if (returnDate == 'NA') {
              itemsList.add(
                ReturnItemListTile(
                  componentUID: document.get('component_uid'),
                  componentId: document.get('component_id'),
                  issueDate: document.get('issue_date'),
                  quanityToBeReturned: document.get('quantity_issued'),
                  studentId: document.get('student_id'),
                  issueId: document.id,
                ),
              );
            }
          }
        } else {
          itemsList.clear();
          for (var document in issuedItems) {
            var returnDate = document.get('return_date');
            if (returnDate == 'NA' &&
                (document
                        .get('student_id')
                        .toLowerCase()
                        .contains(searchText) ||
                    document
                        .get('component_id')
                        .toLowerCase()
                        .contains(searchText))) {
              itemsList.add(
                ReturnItemListTile(
                  componentUID: document.get('component_uid'),
                  componentId: document.get('component_id'),
                  issueDate: document.get('issue_date'),
                  quanityToBeReturned: document.get('quantity_issued'),
                  studentId: document.get('student_id'),
                  issueId: document.id,
                ),
              );
            }
          }
        }
        return Expanded(
          child: itemsList.length == 0
              ? searchText.isEmpty
                  ? Padding(
                      padding: EdgeInsets.only(
                          top: SizeConfig.heightMultiplier! * 2),
                      child: Text(
                        'No item issued at the moment!',
                        style: TextStyle(
                          fontSize: SizeConfig.textMultiplier! * 2.6,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.only(
                          top: SizeConfig.heightMultiplier! * 2),
                      child: Text(
                        'Return record does not exist!',
                        style: TextStyle(
                          fontSize: SizeConfig.textMultiplier! * 3,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
              : ListView.separated(
            itemBuilder: (context, index) {
              return itemsList[index];
            },
            separatorBuilder: (context, index) => Divider(
              thickness: 1.5,
              indent: 10.18 * SizeConfig.widthMultiplier!,
              endIndent: 5.498 * SizeConfig.widthMultiplier!,
            ),
            itemCount: itemsList.length,
          ),
        );
      },
    );
  }
}
