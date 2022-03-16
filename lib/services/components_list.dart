import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rim/custom_widgets/stock_list_tile.dart';
import 'package:rim/size_config.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;

class ComponentsList extends StatelessWidget {
  final String searchText;

  ComponentsList({required this.searchText});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('components').snapshots(),
      builder: (context, snapshot) {
        List<StockListTile> stocksList = [];
        final components = snapshot.data?.docs ?? [];
        if (searchText == '') {
          for (var document in components) {
            stocksList.add(
              StockListTile(
                componentName: document.get('name'),
                componentId: document.get('id'),
                totalQuantity: document.get('total_quantity'),
                lockerNumber: document.get('locker_number'),
                quantityIssued: document.get('quantity_issued'),
                quantityAvailable: document.get('quantity_available'),
              ),
            );
          }
        } else {
          stocksList.clear();
          for (var document in components) {
            if (document.get('name').toLowerCase().contains(searchText) ||
                document.get('id').contains(searchText)) {
              stocksList.add(
                StockListTile(
                  componentName: document.get('name'),
                  componentId: document.get('id'),
                  totalQuantity: document.get('total_quantity'),
                  lockerNumber: document.get('locker_number'),
                  quantityIssued: document.get('quantity_issued'),
                  quantityAvailable: document.get('quantity_available'),
                ),
              );
            }
          }
        }
        return Expanded(
          child: stocksList.length == 0
              ? searchText.isEmpty
                  ? Padding(
                      padding: EdgeInsets.only(
                          top: SizeConfig.heightMultiplier! * 2),
                      child: Text(
                        'No items in the stock at the moment!',
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
                        'Stock does not exist!',
                        style: TextStyle(
                          fontSize: SizeConfig.textMultiplier! * 3,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
              : ListView.separated(
                  itemBuilder: (context, index) {
                    return stocksList[index];
                  },
                  separatorBuilder: (context, index) => Divider(
                    thickness: 1.5,
                    indent: 5.498 * SizeConfig.widthMultiplier!,
                    endIndent: 5.498 * SizeConfig.widthMultiplier!,
                  ),
                  itemCount: stocksList.length,
                ),
        );
      },
    );
  }
}
