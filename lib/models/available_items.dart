//Model class for the issue screen and we are using this class for fetching the components before the page is running in initState()
class AvailableItems {
  String componentId = '';
  String quantityAvailable = '';
  String docId = '';
  String quantityIssued = '';
  String componentName = '';

  AvailableItems({
    required this.componentId,
    required this.quantityAvailable,
    required this.docId,
    required this.quantityIssued,
    required this.componentName,
  });
}
