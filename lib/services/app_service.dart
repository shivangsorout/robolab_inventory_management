import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:rim/models/available_items.dart';

class AppService extends ChangeNotifier {
  List<AvailableItems> _itemsList = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  UnmodifiableListView<AvailableItems> get availableItemsList {
    return UnmodifiableListView(_itemsList);
  }

  void emptyItemsList() {
    _itemsList.clear();
    notifyListeners();
  }

  void getAvailableItems({bool clearList = true}) async {
    if (clearList) {
      _itemsList.clear();
    }
    var snapshots = _firestore.collection('components').snapshots();
    await for (var snapshot in snapshots) {
      _itemsList.clear();
      for (var component in snapshot.docs) {
        _itemsList.add(AvailableItems(
          quantityIssued: component.get('quantity_issued').toString(),
          componentId: component.get('id'),
          quantityAvailable: component.get('quantity_available').toString(),
          componentName: component.get('name'),
          docId: component.id,
        ));
      }
      notifyListeners();
    }
  }
}
