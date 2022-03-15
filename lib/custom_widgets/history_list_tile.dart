import 'package:flutter/material.dart';
import 'package:rim/size_config.dart';

class HistoryListTile extends StatelessWidget {
  final String studentId;
  final String componentId;
  final String issueDate;
  final int quantityIssued;
  final String returnDate;

  const HistoryListTile({
    Key? key,
    required this.studentId,
    required this.componentId,
    required this.issueDate,
    required this.quantityIssued,
    required this.returnDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 4.07 * SizeConfig.widthMultiplier!,
        vertical: 1.469 * SizeConfig.heightMultiplier!,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 2.036 * SizeConfig.widthMultiplier!,
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                bottom: 1 * SizeConfig.heightMultiplier!,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    studentId,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontSize: 2.252 * SizeConfig.textMultiplier!,
                    ),
                  ),
                  Text(
                    componentId,
                    style: TextStyle(
                      fontSize: 1.762 * SizeConfig.textMultiplier!,
                      color: const Color(0xffbdbdbd),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 0.489 * SizeConfig.heightMultiplier!,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        'Issue Date',
                        style: TextStyle(
                          color: const Color(0xff4b9460),
                          fontSize: 1.371 * SizeConfig.textMultiplier!,
                        ),
                      ),
                      SizedBox(
                        width: 1 * SizeConfig.widthMultiplier!,
                      ),
                      Text(
                        issueDate,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 1.273 * SizeConfig.textMultiplier!,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Quantity Issued',
                        style: TextStyle(
                          color: const Color(0xff4b9460),
                          fontSize: 1.371 * SizeConfig.textMultiplier!,
                        ),
                      ),
                      SizedBox(
                        width: 1 * SizeConfig.widthMultiplier!,
                      ),
                      Text(
                        quantityIssued.toString(),
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 1.273 * SizeConfig.textMultiplier!,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Text(
                  'Return Date',
                  style: TextStyle(
                    color: const Color(0xff4b9460),
                    fontSize: 1.371 * SizeConfig.textMultiplier!,
                  ),
                ),
                SizedBox(
                  width: 1 * SizeConfig.widthMultiplier!,
                ),
                Text(
                  returnDate,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 1.273 * SizeConfig.textMultiplier!,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
