import 'package:flutter/material.dart';
import 'package:rim/custom_widgets/component_details_tile.dart';

class ItemCard extends StatelessWidget {
  final Function(int) onDeleted;
  int? index;
  ItemCard({
    required this.onDeleted,
    this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400,
              blurRadius: 10.0,
              offset: const Offset(0.0, 1.0),
            ),
          ],
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(((index ?? 0) + 1).toString() + '.'),
                GestureDetector(
                  onTap: () {
                    onDeleted(index ?? 0);
                  },
                  child: const Icon(
                    Icons.delete,
                    color: Color(0xff5db075),
                    size: 30.0,
                  ),
                ),
              ],
            ),
            ComponentDetailsTile(
              tileName: 'Component ID',
              onChanged: (val) {},
              errorText: null,
            ),
            ComponentDetailsTile(
              tileName: 'Quantity Issued',
              onChanged: (val) {},
              errorText: null,
            ),
          ],
        ),
      ),
    );
  }
}
