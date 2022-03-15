import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rim/custom_widgets/alert_message.dart';
import 'package:rim/custom_widgets/component_details_tile.dart';
import 'package:rim/custom_widgets/custom_button.dart';
import 'package:rim/models/component.dart';
import 'package:rim/screens/update_stock_screen.dart';
import 'package:rim/size_config.dart';

FirebaseFirestore? _firestore = FirebaseFirestore.instance;

class AddItemScreen extends StatefulWidget {
  static const String id = 'add_item_screen';

  const AddItemScreen({Key? key}) : super(key: key);

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  Component component = Component();
  //validation errors in fields
  bool valErrorName = false;
  bool valErrorId = false;
  bool valErrorTotalQuantity = false;
  bool valErrorLocker = false;

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
                    'Add Item',
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
                      onChanged: (val) {
                        component.componentName = val;
                        setState(() {
                          valErrorName
                              ? val == ''
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
                      onChanged: (val) {
                        component.componentId = val;
                        setState(() {
                          valErrorId
                              ? val == ''
                                  ? valErrorId = true
                                  : valErrorId = false
                              : null;
                        });
                      },
                      errorText:
                          valErrorId ? 'Component Id can\'t be empty!' : null,
                    ),
                    ComponentDetailsTile(
                        keyboardType: TextInputType.number,
                        tileName: 'Total Quantity',
                        onChanged: (val) {
                          component.totalQuantity = val;
                          setState(() {
                            valErrorTotalQuantity
                                ? val == ''
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
                        onChanged: (val) {
                          component.locker = val;
                          setState(() {
                            valErrorLocker
                                ? val == ''
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
                  text: 'Add Item',
                  onPressed: () {
                    setState(() {
                      component.componentName == '' ||
                              component.componentName == null
                          ? valErrorName = true
                          : valErrorName = false;
                      component.componentId == '' ||
                              component.componentId == null
                          ? valErrorId = true
                          : valErrorId = false;
                      component.locker == '' || component.locker == null
                          ? valErrorLocker = true
                          : valErrorLocker = false;
                      component.totalQuantity == '' ||
                              component.totalQuantity == null
                          ? valErrorTotalQuantity = true
                          : valErrorTotalQuantity = false;
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
                          'quantity_issued':
                              int.parse(component.quantityIssued),
                          'quantity_available':
                              int.parse(component.totalQuantity) -
                                  int.parse(component.quantityIssued),
                        });
                        showDialog(
                            context: context,
                            builder: (_) {
                              return const AlertMessage(
                                message: 'Component Added Successfully',
                              );
                            }).then((value) {
                          Navigator.popUntil(
                            context,
                            ModalRoute.withName(UpdateStockScreen.id),
                          );
                        });
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
