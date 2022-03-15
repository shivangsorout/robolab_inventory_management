import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rim/custom_widgets/history_list_tile.dart';
import 'package:rim/size_config.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;

class TransactionsList extends StatelessWidget {
  final String searchText;

  TransactionsList({
    required this.searchText,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('history').snapshots(),
      builder: (context, snapshot) {
        List<HistoryListTile> transactionsList = [];
        final transactions = snapshot.data?.docs ?? [];
        if (searchText == '') {
          for (var transaction in transactions) {
            transactionsList.add(
              HistoryListTile(
                componentId: transaction.get('component_id'),
                issueDate: transaction.get('issue_date'),
                quantityIssued: transaction.get('quantity_issued'),
                studentId: transaction.get('student_id'),
                returnDate: transaction.get('return_date'),
              ),
            );
          }
        } else {
          transactionsList.clear();
          for (var transaction in transactions) {
            if (transaction
                    .get('component_id')
                    .toLowerCase()
                    .contains(searchText) ||
                transaction
                    .get('student_id')
                    .toLowerCase()
                    .contains(searchText)) {
              transactionsList.add(
                HistoryListTile(
                  componentId: transaction.get('component_id'),
                  issueDate: transaction.get('issue_date'),
                  quantityIssued: transaction.get('quantity_issued'),
                  studentId: transaction.get('student_id'),
                  returnDate: transaction.get('return_date'),
                ),
              );
            }
          }
        }
        return Expanded(
          child: transactionsList.length == 0
              ? searchText.isEmpty
                  ? Padding(
                      padding: EdgeInsets.only(
                          top: SizeConfig.heightMultiplier! * 2),
                      child: Text(
                        'No records at the moment!',
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
                        'Record does not exist!',
                        style: TextStyle(
                          fontSize: SizeConfig.textMultiplier! * 3,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
              : ListView.separated(
                  itemBuilder: (context, index) {
                    return transactionsList[index];
                  },
                  separatorBuilder: (context, index) => Divider(
                    thickness: 1.5,
                    indent: 5.498 * SizeConfig.widthMultiplier!,
                    endIndent: 5.498 * SizeConfig.widthMultiplier!,
                  ),
                  itemCount: transactionsList.length,
                ),
        );
      },
    );
  }
}
