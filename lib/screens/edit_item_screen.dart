import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rim/custom_widgets/alert_message.dart';
import 'package:rim/custom_widgets/component_details_tile.dart';
import 'package:rim/custom_widgets/custom_button.dart';
import 'package:rim/screens/update_stock_screen.dart';
import 'package:rim/size_config.dart';

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
  //validations error in fields
  bool valErrorName = false;
  bool valErrorId = false;
  bool valErrorTotalQuantity = false;
  bool valErrorLocker = false;
  TextEditingController componentIdController = TextEditingController();
  TextEditingController componentNameController = TextEditingController();
  TextEditingController totalQuantityController = TextEditingController();
  TextEditingController lockerNumberController = TextEditingController();
  String initialcomponentId = '';
  String initialcomponentName = '';
  String initialtotalQuantity = '';
  String initiallockerNumber = '';
  String initialQuantityIssued = '';
  String documentId = '';

  void _onDatabaseUpdate(QuerySnapshot snapshot) {
    for (var document in snapshot.docs) {
      setState(() {
        initialcomponentId = document.get('id');
        initialcomponentName = document.get('name');
        initialtotalQuantity = document.get('total_quantity').toString();
        initiallockerNumber = document.get('locker_number');
        initialQuantityIssued = document.get('quantity_issued').toString();
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
          padding: EdgeInsets.symmetric(
            horizontal: 4 * SizeConfig.widthMultiplier!,
            vertical: 2 * SizeConfig.heightMultiplier!,
          ),
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
                  title: Text(
                    'Edit Item',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: SizeConfig.textMultiplier! * 4,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  trailing: const Text(''),
                ),
                SizedBox(
                  height: 5.876 * SizeConfig.heightMultiplier!,
                ),
                Column(
                  children: [
                    ComponentDetailsTile(
                      tileName: 'Component Name',
                      controller: componentNameController,
                      onChanged: (val) {
                        setState(() {
                          valErrorName
                              ? val == '' || val == null
                                  ? valErrorName = true
                                  : valErrorName = false
                              : null;
                        });
                      },
                      errorText: valErrorName
                          ? 'Component name can\'t be empty!'
                          : null,
                    ),
                    ComponentDetailsTile(
                        tileName: 'Component Id',
                        controller: componentIdController,
                        onChanged: (val) {
                          setState(() {
                            valErrorId
                                ? val == '' || val == null
                                    ? valErrorId = true
                                    : valErrorId = false
                                : null;
                          });
                        },
                        errorText: valErrorId
                            ? 'Component Id can\'t be empty!'
                            : null),
                    ComponentDetailsTile(
                        keyboardType: TextInputType.number,
                        tileName: 'Total Quantity',
                        controller: totalQuantityController,
                        onChanged: (val) {
                          setState(() {
                            valErrorTotalQuantity
                                ? val == '' || val == null
                                    ? valErrorTotalQuantity = true
                                    : valErrorTotalQuantity = false
                                : null;
                          });
                        },
                        errorText: valErrorTotalQuantity
                            ? 'Quantity can\'t be empty!'
                            : null),
                    ComponentDetailsTile(
                        tileName: 'Locker Number',
                        controller: lockerNumberController,
                        onChanged: (val) {
                          setState(() {
                            valErrorLocker
                                ? val == '' || val == null
                                    ? valErrorLocker = true
                                    : valErrorLocker = false
                                : null;
                          });
                        },
                        errorText: valErrorLocker
                            ? 'Locker number can\'t be empty!'
                            : null),
                  ],
                ),
                SizedBox(
                  height: 7.835 * SizeConfig.heightMultiplier!,
                ),
                CustomButton(
                  backgroundColor: const Color(0xff5db075),
                  text: 'Update Item',
                  onPressed: () {
                    setState(() {
                      componentNameController.text == '' ||
                              componentNameController.text == null
                          ? valErrorName = true
                          : valErrorName = false;
                      componentIdController.text == '' ||
                              componentIdController.text == null
                          ? valErrorId = true
                          : valErrorId = false;
                      lockerNumberController.text == '' ||
                              lockerNumberController.text == null
                          ? valErrorLocker = true
                          : valErrorLocker = false;
                      totalQuantityController.text == '' ||
                              totalQuantityController.text == null
                          ? valErrorTotalQuantity = true
                          : valErrorTotalQuantity = false;
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
                          'total_quantity':
                              int.parse(totalQuantityController.text),
                          'quantity_issued': int.parse(initialQuantityIssued),
                          'quantity_available':
                              int.parse(totalQuantityController.text) -
                                  int.parse(initialQuantityIssued)
                        });
                        showDialog(
                            context: context,
                            builder: (_) {
                              return const AlertMessage(
                                message: 'Component Info Edited Successfully',
                              );
                            }).then(
                          (value) {
                            Navigator.popUntil(
                              context,
                              ModalRoute.withName(UpdateStockScreen.id),
                            );
                          },
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
