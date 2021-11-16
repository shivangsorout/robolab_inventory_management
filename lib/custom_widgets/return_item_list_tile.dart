import 'package:flutter/material.dart';

class ReturnItemListTile extends StatelessWidget {
  final String studentId;
  final String componentId;
  final String issueDate;
  final int quanityIssued;
  final String issueId;

  ReturnItemListTile({
    required this.studentId,
    required this.componentId,
    required this.issueDate,
    required this.quanityIssued,
    required this.issueId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        right: 30.0,
        top: 15.0,
        bottom: 10.0,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              
            },
            icon: const Icon(Icons.keyboard_return),
            color: const Color(0xff5db075),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
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
                              quanityIssued.toString(),
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
