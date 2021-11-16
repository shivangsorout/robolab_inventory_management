//model class for storing the details that we are sending to the firebase in issue item screen
import 'package:flutter/widgets.dart';

class IssueItemDetails {
  String _componentId = '';
  String _quantityToBeIssued = '';
  int? index;
  bool textVisibility = false;
  bool isQuantityExceedMaxQuantityAvailable = false;
  int _quantityAvailable = 0;
  bool isAvailable = false;
  bool itemDoesNotExist = false;
  TextEditingController? componentIdController;
  TextEditingController? quantityToBeIssuedController;
  IssueItemDetails({
    this.componentIdController,
    this.quantityToBeIssuedController
  });
  void setComponentId(String cId){
    _componentId = cId;
  }
  void setQuantityToBeIssued(String quantity){
    _quantityToBeIssued = quantity;
  }
  void setQuantityAvailable(int quantity){
    _quantityAvailable = quantity;
  }
  void setIndex(int index){
    this.index = index;
  }
  String get component_id{
    return _componentId;
  }
  String get quantity_to_be_issued{
    return _quantityToBeIssued;
  }
  int get quantity_available{
    return _quantityAvailable;
  }
}
