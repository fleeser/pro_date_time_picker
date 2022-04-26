import 'package:flutter/material.dart';

import 'package:pro_date_time_picker/src/constants.dart';

class ProDateTimePicker extends StatelessWidget {

  const ProDateTimePicker({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: MediaQuery.of(context).size.width - 2 * kDefaultPadding,
        height: 300.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kDefaultBorderRadius),
          color: Colors.white
        )
      )
    );
  }
}