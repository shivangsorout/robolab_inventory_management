import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rim/custom_widgets/stock_list_tile.dart';

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
              totalQuantity: document.get('quantity'),
              lockerNumber: document.get('locker_number'),
            ),
          );
        }
        return Expanded(
          child: ListView.separated(
            itemBuilder: (context, index) {
              return stocksList[index];
            },
            separatorBuilder: (context, index) => const Divider(
              thickness: 1.5,
              indent: 27.0,
              endIndent: 27.0,
            ),
            itemCount: stocksList.length,
          ),
        );
      },
    );
  }
}
