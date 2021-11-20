import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:rim/models/available_items.dart';

class AvailableItemsList extends ChangeNotifier{
  List<AvailableItems> _itemsList = [];
  UnmodifiableListView<AvailableItems> get availableItemsList{
    return UnmodifiableListView(_itemsList);
  }
  void initializingList(List<AvailableItems> list){
    _itemsList = list;
    notifyListeners();
  }
  void add(AvailableItems item){
    _itemsList.add(item);
    notifyListeners();
  }
}