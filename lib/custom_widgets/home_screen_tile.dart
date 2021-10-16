import 'package:flutter/material.dart';

class HomeScreenTile extends StatelessWidget {
  final String imageAddress;
  final String tileName;
  final Function()? onPress;
  HomeScreenTile({
    required this.imageAddress,
    required this.tileName,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: const Color(0xfff6f6f6),
          borderRadius: BorderRadius.circular(10.0),
          child: InkWell(
            borderRadius: BorderRadius.circular(10.0),
            onTap: onPress,
            child: SizedBox.square(
              dimension: 150.0,
              child: Image.asset(
                imageAddress,
                scale: 0.8,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Text(
          tileName,
          style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
        )
      ],
    );
  }
}
