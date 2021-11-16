import 'package:flutter/material.dart';
import 'package:rim/custom_widgets/component_details_tile.dart';

class ItemCard extends StatefulWidget {
  final Function(int) onDeleted;
  final int? index;
  final Function(String, int) onChangedComponentId;
  final Function(String, int) onChangedQuantityIssued;
  final TextEditingController? componentIdController;
  final TextEditingController? quantityIssuedController;
  final bool Function(int) visibilityText;
  final String? Function(int) notifyingText;
  final Color? Function(int) notifyingTextColor;
  // ignore: prefer_const_constructors_in_immutables
  ItemCard(
      {Key? key,
      required this.onDeleted,
      this.index,
      required this.onChangedComponentId,
      required this.onChangedQuantityIssued,
      this.componentIdController,
      this.quantityIssuedController,
      required this.visibilityText,
      required this.notifyingText,
      required this.notifyingTextColor})
      : super(key: key);

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  bool visibility = false;
  String text = '';
  Color notifyingTextColor = Colors.white;
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
                Text(((widget.index!) + 1).toString() + '.'),
                GestureDetector(
                  onTap: () {
                    widget.onDeleted(widget.index!);
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
              onChanged: (val) {
                widget.onChangedComponentId(val, widget.index!);
                setState(() {
                  notifyingTextColor =
                      widget.notifyingTextColor(widget.index!)!;
                  visibility = widget.visibilityText(widget.index!);
                  text = widget.notifyingText(widget.index!)!;
                });
              },
              errorText: null,
              controller: widget.componentIdController,
            ),
            ComponentDetailsTile(
              tileName: 'Quantity to be Issued',
              onChanged: (val) {
                widget.onChangedQuantityIssued(val, widget.index!);
                setState(() {
                  text = widget.notifyingText(widget.index!)!;
                  notifyingTextColor =
                      widget.notifyingTextColor(widget.index!)!;
                });
              },
              errorText: null,
              controller: widget.quantityIssuedController,
            ),
            if (visibility)
              Padding(
                padding:
                    const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    text,
                    style: TextStyle(
                      color: notifyingTextColor,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
