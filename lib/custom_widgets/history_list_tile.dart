import 'package:flutter/material.dart';

class HistoryListTile extends StatelessWidget {
  final String studentId;
  final String componentId;
  final String issueDate;
  final int quantityIssued;
  final String returnDate;

  HistoryListTile({
    required this.studentId,
    required this.componentId,
    required this.issueDate,
    required this.quantityIssued,
    required this.returnDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 15.0,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    studentId,
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
                vertical: 5.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Text(
                        'Issue Date',
                        style: TextStyle(
                          color: Color(0xff4b9460),
                          fontSize: 16.0,
                        ),
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        issueDate,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        'Quantity Issued',
                        style: TextStyle(
                          color: Color(0xff4b9460),
                          fontSize: 16.0,
                        ),
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        quantityIssued.toString(),
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              children: [
                const Text(
                  'Return Date',
                  style: TextStyle(
                    color: Color(0xff4b9460),
                    fontSize: 16.0,
                  ),
                ),
                const SizedBox(
                  width: 5.0,
                ),
                Text(
                  returnDate,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 16.0,
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
