//model class for storing the details that we are sending to the firebase in issue item screen
import 'package:flutter/widgets.dart';

class IssueItemDetails {
  String _componentId = '';
  String _quantityToBeIssued = '';
  //Validation Error in fields
  bool quantityTextFieldEnabled = true;
  bool valErrorComponentId = false;
  bool valErrorQuantity = false;
  int? index;
  bool textVisibility = false;
  bool isQuantityExceedMaxQuantityAvailable = false;
  int _quantityAvailable = 0;
  //don't change the value of this boolean
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
  // ignore: non_constant_identifier_names
  String get component_id{
    return _componentId;
  }
  // ignore: non_constant_identifier_names
  String get quantity_to_be_issued{
    return _quantityToBeIssued;
  }
  // ignore: non_constant_identifier_names
  int get quantity_available{
    return _quantityAvailable;
  }
}
