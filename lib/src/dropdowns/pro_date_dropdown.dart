import 'package:flutter/material.dart';
import 'package:pro_date_time_picker/src/constants.dart';

class ProDateDropdown extends StatelessWidget {

  const ProDateDropdown({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: MediaQuery.of(context).size.width - 2 * kDefaultPadding,
        padding: const EdgeInsets.all(kDefaultPadding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kDefaultBorderRadius),
          color: Colors.white,
          border: Border.all(
            width: 1.0,
            color: Colors.blue
          )
        ),
        child: Row(
          children: [
            const Icon(
              Icons.calendar_month_rounded,
              size: 22.0,
              color: Colors.grey
            ),
            const SizedBox(width: kDefaultPadding),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text(
                    'Select a day',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.blue,
                      height: 1.0,
                      
                    )
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    '29.08.2022',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      height: 1.0
                    )
                  )
                ]
              )
            ),
            const Icon(
              Icons.expand_more_rounded,
              size: 22.0,
              color: Colors.grey
            )
          ]
        )
      )
    );
  }
}