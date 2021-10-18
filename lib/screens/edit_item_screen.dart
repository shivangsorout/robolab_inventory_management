import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rim/constants.dart';
import 'package:rim/custom_widgets/component_detail_tile.dart';
import 'package:rim/custom_widgets/custom_button.dart';
import 'package:rim/screens/update_stock_screen.dart';

FirebaseFirestore? _firestore = FirebaseFirestore.instance;

class EditItemScreen extends StatefulWidget {
  static const String id = 'edit_item_screen';
  final String componentId;
  EditItemScreen({
    required this.componentId,
  });

  @override
  State<EditItemScreen> createState() => _EditItemScreenState();
}

class _EditItemScreenState extends State<EditItemScreen> {
  bool valName = false;
  bool valId = false;
  bool valTotalQuantity = false;
  bool valLocker = false;
  TextEditingController componentIdController = TextEditingController();
  TextEditingController componentNameController = TextEditingController();
  TextEditingController totalQuantityController = TextEditingController();
  TextEditingController lockerNumberController = TextEditingController();
  String initialcomponentId = '';
  String initialcomponentName = '';
  String initialtotalQuantity = '';
  String initiallockerNumber = '';
  String documentId = '';

  void _onDatabaseUpdate(QuerySnapshot snapshot) {
    for (var document in snapshot.docs) {
      setState(() {
        initialcomponentId = document.get('id');
        initialcomponentName = document.get('name');
        initialtotalQuantity = document.get('quantity');
        initiallockerNumber = document.get('locker_number');
        componentIdController.text = initialcomponentId;
        componentNameController.text = initialcomponentName;
        totalQuantityController.text = initialtotalQuantity;
        lockerNumberController.text = initiallockerNumber;
        documentId = document.id;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _firestore
        ?.collection('components')
        .where('id', isEqualTo: widget.componentId)
        .snapshots()
        .listen((QuerySnapshot snapshot) => _onDatabaseUpdate(snapshot));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: kPaddingScreens,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ListTile(
                  leading: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  title: const Text(
                    'Edit Item',
                    style: kTitleTextStyle,
                    textAlign: TextAlign.center,
                  ),
                  trailing: const Text(''),
                ),
                const SizedBox(
                  height: 60.0,
                ),
                Column(
                  children: [
                    ComponentDetailTile(
                      tileName: 'Component Name',
                      controller: componentNameController,
                      onChanged: (val) {
                        setState(() {
                          valName
                              ? val == '' || val == null
                                  ? valName = true
                                  : valName = false
                              : null;
                        });
                      },
                      errorText:
                          valName ? 'Component name can\'t be empty!' : null,
                    ),
                    ComponentDetailTile(
                        tileName: 'Component Id',
                        controller: componentIdController,
                        onChanged: (val) {
                          setState(() {
                            valId
                                ? val == '' || val == null
                                    ? valId = true
                                    : valId = false
                                : null;
                          });
                        },
                        errorText:
                            valId ? 'Component Id can\'t be empty!' : null),
                    ComponentDetailTile(
                        tileName: 'Total Quantity',
                        controller: totalQuantityController,
                        onChanged: (val) {
                          setState(() {
                            valTotalQuantity
                                ? val == '' || val == null
                                    ? valTotalQuantity = true
                                    : valTotalQuantity = false
                                : null;
                          });
                        },
                        errorText: valTotalQuantity
                            ? 'Quantity can\'t be empty!'
                            : null),
                    ComponentDetailTile(
                        tileName: 'Locker Number',
                        controller: lockerNumberController,
                        onChanged: (val) {
                          setState(() {
                            valLocker
                                ? val == '' || val == null
                                    ? valLocker = true
                                    : valLocker = false
                                : null;
                          });
                        },
                        errorText: valLocker
                            ? 'Locker number can\'t be empty!'
                            : null),
                  ],
                ),
                const SizedBox(
                  height: 80.0,
                ),
                CustomButton(
                  backgroundColor: const Color(0xff5db075),
                  text: 'Update Item',
                  onPressed: () {
                    setState(() {
                      componentNameController.text == '' ||
                              componentNameController.text == null
                          ? valName = true
                          : valName = false;
                      componentIdController.text == '' ||
                              componentIdController.text == null
                          ? valId = true
                          : valId = false;
                      lockerNumberController.text == '' ||
                              lockerNumberController.text == null
                          ? valLocker = true
                          : valLocker = false;
                      totalQuantityController.text == '' ||
                              totalQuantityController.text == null
                          ? valTotalQuantity = true
                          : valTotalQuantity = false;
                    });
                    try {
                      if (componentIdController.text != '' &&
                          lockerNumberController.text != '' &&
                          componentNameController.text != '' &&
                          totalQuantityController.text != '' &&
                          (componentIdController.text != initialcomponentId ||
                              lockerNumberController.text !=
                                  initiallockerNumber ||
                              componentNameController.text !=
                                  initialcomponentName ||
                              totalQuantityController.text !=
                                  initialtotalQuantity)) {
                        _firestore
                            ?.collection('components')
                            .doc(documentId)
                            .update({
                          'id': componentIdController.text,
                          'locker_number': lockerNumberController.text,
                          'name': componentNameController.text,
                          'quantity': totalQuantityController.text,
                        });
                        Navigator.popUntil(
                          context,
                          ModalRoute.withName(UpdateStockScreen.id),
                        );
                      }
                    } catch (e) {
                      print(e);
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
