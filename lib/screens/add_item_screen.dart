import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rim/constants.dart';
import 'package:rim/custom_widgets/component_details_tile.dart';
import 'package:rim/custom_widgets/custom_button.dart';
import 'package:rim/models/component.dart';
import 'package:rim/screens/update_stock_screen.dart';

FirebaseFirestore? _firestore = FirebaseFirestore.instance;

class AddItemScreen extends StatefulWidget {
  static const String id = 'add_item_screen';

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  Component component = Component();
  bool valName = false;
  bool valId = false;
  bool valTotalQuantity = false;
  bool valLocker = false;

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
                    'Add Item',
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
                    ComponentDetailsTile(
                      tileName: 'Component Name',
                      onChanged: (val) {
                        component.componentName = val;
                        setState(() {
                          valName
                              ? val == ''
                                  ? valName = true
                                  : valName = false
                              : null;
                        });
                      },
                      errorText:
                          valName ? 'Component name can\'t be empty!' : null,
                    ),
                    ComponentDetailsTile(
                        tileName: 'Component Id',
                        onChanged: (val) {
                          component.componentId = val;
                          setState(() {
                            valId
                                ? val == ''
                                    ? valId = true
                                    : valId = false
                                : null;
                          });
                        },
                        errorText:
                            valId ? 'Component Id can\'t be empty!' : null),
                    ComponentDetailsTile(
                        tileName: 'Total Quantity',
                        onChanged: (val) {
                          component.totalQuantity = val;
                          setState(() {
                            valTotalQuantity
                                ? val == ''
                                    ? valTotalQuantity = true
                                    : valTotalQuantity = false
                                : null;
                          });
                        },
                        errorText: valTotalQuantity
                            ? 'Quantity can\'t be empty!'
                            : null),
                    ComponentDetailsTile(
                        tileName: 'Locker Number',
                        onChanged: (val) {
                          component.locker = val;
                          setState(() {
                            valLocker
                                ? val == ''
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
                  text: 'Add Item',
                  onPressed: () {
                    setState(() {
                      component.componentName == '' ||
                              component.componentName == null
                          ? valName = true
                          : valName = false;
                      component.componentId == '' ||
                              component.componentId == null
                          ? valId = true
                          : valId = false;
                      component.locker == '' || component.locker == null
                          ? valLocker = true
                          : valLocker = false;
                      component.totalQuantity == '' || component.totalQuantity == null
                          ? valTotalQuantity = true
                          : valTotalQuantity = false;
                    });
                    try {
                      if (component.componentId != null &&
                          component.locker != null &&
                          component.componentName != null &&
                          component.totalQuantity != null &&
                          component.componentId != '' &&
                          component.locker != '' &&
                          component.componentName != '' &&
                          component.totalQuantity != '') {
                        _firestore?.collection('components').add({
                          'id': component.componentId,
                          'locker_number': component.locker,
                          'name': component.componentName,
                          'total_quantity': int.parse(component.totalQuantity),
                          'quantity_issued': int.parse(component.quantityIssued),
                          'quantity_available': int.parse(component.totalQuantity) - int.parse(component.quantityIssued),
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
