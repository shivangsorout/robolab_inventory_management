//Model class for the issue screen and we are using this class for fetching the components before the page is running in initState()
class AvailableItems {
  String componentId = '';
  String quantity = '';
  String docId = '';
  String quantityIssued = '';
  AvailableItems({
    required this.componentId,
    required this.quantity,
    required this.docId,
    required this.quantityIssued,
  });
}
