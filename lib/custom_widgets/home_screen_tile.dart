import 'package:flutter/material.dart';
import 'package:rim/size_config.dart';

class HomeScreenTile extends StatelessWidget {
  final String imageAddress;
  final String tileName;
  final Function()? onPress;
  const HomeScreenTile({
    Key? key,
    required this.imageAddress,
    required this.tileName,
    required this.onPress,
  }) : super(key: key);

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
            child: SizedBox(
              height: 14.7 * SizeConfig.heightMultiplier!,
              width: 30.54 * SizeConfig.widthMultiplier!,
              child: Image.asset(
                imageAddress,
                scale: 0.9,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 1 * SizeConfig.heightMultiplier!,
        ),
        Text(
          tileName,
          style: TextStyle(
              fontSize: 1.76 * SizeConfig.textMultiplier!,
              fontWeight: FontWeight.w500),
        )
      ],
    );
  }
}
