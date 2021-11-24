import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rim/custom_widgets/stock_list_tile.dart';
import 'package:rim/size_config.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;

class ComponentsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('components').snapshots(),
      builder: (context, snapshot) {
        List<StockListTile> stocksList = [];
        final components = snapshot.data?.docs ?? [];
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
        return Expanded(
          child: ListView.separated(
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
