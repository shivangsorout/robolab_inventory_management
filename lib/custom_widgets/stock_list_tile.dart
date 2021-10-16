import 'package:flutter/material.dart';
import 'package:rim/screens/update_stock_screen.dart';

class StockListTile extends StatelessWidget {
  final String componentName;
  final String componentId;
  final String totalQuantity;
  final String lockerNumber;

  StockListTile({
    required this.componentName,
    required this.componentId,
    required this.totalQuantity,
    required this.lockerNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: ModalRoute.of(context)?.settings.name == UpdateStockScreen.id
            ? () {}
            : null,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 30.0,
            vertical: 10.0,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      componentName,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontSize: 25,
                      ),
                    ),
                    Text(
                      componentId,
                      style: const TextStyle(
                        fontSize: 20.0,
                        color: Color(0xffbdbdbd),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 5.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Total Quantity
                        Row(
                          children: [
                            const Text(
                              'Total Quantity',
                              style: TextStyle(
                                color: Color(0xff4b9460),
                                fontSize: 16.0,
                              ),
                            ),
                            const SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              totalQuantity,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        //Quantity Available
                        Row(
                          children: const [
                            Text(
                              'Quantity Available',
                              style: TextStyle(
                                color: Color(0xff4b9460),
                                fontSize: 16.0,
                              ),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              '20',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Quantity Issued
                        Row(
                          children: const [
                            Text(
                              'Quantity Issued',
                              style: TextStyle(
                                color: Color(0xff4b9460),
                                fontSize: 16.0,
                              ),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              '0',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        //Locker Number
                        Row(
                          children: [
                            const Text(
                              'Locker Number',
                              style: TextStyle(
                                color: Color(0xff4b9460),
                                fontSize: 16.0,
                              ),
                            ),
                            const SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              lockerNumber,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
