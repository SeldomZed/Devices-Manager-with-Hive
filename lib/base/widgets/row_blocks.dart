import 'package:flutter/cupertino.dart';

import '../res/styles/app_styles.dart';

class rows_block extends StatelessWidget {
  const rows_block({super.key});

  static BorderSide headlines1 = BorderSide(color: AppStyles.thirdColor, width: 2);
  static BorderSide headlines2 = BorderSide(color: AppStyles.thirdColor, width: 2);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 35),
          width: 170,
          height: 140,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border(
                top: headlines2,
                bottom: headlines2,
                right: headlines2,
                left: headlines2,
              )),
        ),
        Container(
          margin: const EdgeInsets.only(top: 35),
          width: 170,
          height: 140,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border(
                top: headlines2,
                bottom: headlines2,
                right: headlines2,
                left: headlines2,
              )),
        ),
      ],
    );
  }
}
