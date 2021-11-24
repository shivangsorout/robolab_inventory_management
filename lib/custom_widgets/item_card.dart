import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rim/custom_widgets/component_details_tile.dart';
import 'package:rim/size_config.dart';

class ItemCard extends StatefulWidget {
  final Function(int) onDeleted;
  final int? index;
  final String? Function(int) errorTextComponentId;
  final String? Function(int) errorTextQuantity;
  final Function(String, int) onChangedComponentId;
  final Function(String, int) onChangedQuantityIssued;
  final TextEditingController? componentIdController;
  final TextEditingController? quantityIssuedController;
  final bool Function(int) visibilityText;
  final bool Function(int) quantityFieldEnabled;
  final String? Function(int) notifyingText;
  final Color? Function(int) notifyingTextColor;
  // ignore: prefer_const_constructors_in_immutables
  ItemCard({
    Key? key,
    required this.onDeleted,
    this.index,
    required this.onChangedComponentId,
    required this.onChangedQuantityIssued,
    this.componentIdController,
    this.quantityIssuedController,
    required this.visibilityText,
    required this.errorTextComponentId,
    required this.errorTextQuantity,
    required this.notifyingText,
    required this.notifyingTextColor,
    required this.quantityFieldEnabled,
  }) : super(key: key);

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
      padding: EdgeInsets.symmetric(
        vertical: 1 * SizeConfig.heightMultiplier!,
        horizontal: 2.036 * SizeConfig.widthMultiplier!,
      ),
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
        padding: EdgeInsets.symmetric(
          vertical: 1.958 * SizeConfig.heightMultiplier!,
          horizontal: 4.07 * SizeConfig.widthMultiplier!,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  ((widget.index!) + 1).toString() + '.',
                  style: TextStyle(
                    fontSize: 1.371 * SizeConfig.textMultiplier!,
                  )
                ),
                GestureDetector(
                  onTap: () {
                    widget.onDeleted(widget.index!);
                  },
                  child: Icon(
                    Icons.delete,
                    color: const Color(0xff5db075),
                    size: 2.938 * SizeConfig.heightMultiplier!,
                  ),
                ),
              ],
            ),
            ComponentDetailsTile(
              keyboardType: TextInputType.text,
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
              errorText: widget.errorTextComponentId(widget.index!),
              controller: widget.componentIdController,
            ),
            ComponentDetailsTile(
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(
                  RegExp("[0-9]"),
                ),
              ],
              keyboardType: TextInputType.number,
              textFieldEnabled: widget.quantityFieldEnabled(widget.index!),
              tileName: 'Quantity to be Issued',
              onChanged: (val) {
                widget.onChangedQuantityIssued(val, widget.index!);
                setState(() {
                  text = widget.notifyingText(widget.index!)!;
                  notifyingTextColor =
                      widget.notifyingTextColor(widget.index!)!;
                });
              },
              errorText: widget.errorTextQuantity(widget.index!),
              controller: widget.quantityIssuedController,
            ),
            if (visibility)
              Padding(
                padding: EdgeInsets.only(
                  top: 1 * SizeConfig.heightMultiplier!,
                  left: 2.036 * SizeConfig.widthMultiplier!,
                  right: 2.036 * SizeConfig.widthMultiplier!,
                ),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    text,
                    style: TextStyle(
                      fontSize: 1.273 * SizeConfig.textMultiplier!,
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
