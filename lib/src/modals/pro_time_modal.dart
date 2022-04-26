import 'package:flutter/material.dart';

import 'package:pro_date_time_picker/src/constants.dart';
import 'package:pro_date_time_picker/src/helpers.dart';

class ProTimeModal extends StatefulWidget {

  ProTimeModal({ 
    Key? key,
    required this.separateTimeOfDay,
    this.selectedTimeMinutes,
    this.backgroundColor = Colors.white,
    this.primaryColor = Colors.black,
    this.secondaryColor = Colors.grey,
    this.accentColor = Colors.blue,
    this.tertiaryColor = Colors.white,
    required this.onTimeSelected
  }) : super(key: key);

  final bool separateTimeOfDay;
  final int? selectedTimeMinutes;
  final Color backgroundColor;
  final Color primaryColor;
  final Color secondaryColor;
  final Color accentColor;
  final Color tertiaryColor;
  final void Function(int time) onTimeSelected;

  late bool isAM;
  late int? watchingTime;

  @override
  State<ProTimeModal> createState() => _ProTimeModalState();
}

class _ProTimeModalState extends State<ProTimeModal> {

  @override
  void initState() {
    widget.isAM = widget.selectedTimeMinutes != null ? widget.selectedTimeMinutes! <= 48 * 15 : true; // TEST
    widget.watchingTime = widget.selectedTimeMinutes;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: kDefaultPadding * 2 + 70.0 + (widget.separateTimeOfDay ? 12.0 + 48.0 : 0.0),
        height: 300.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kDefaultBorderRadius),
          color: widget.backgroundColor
        ),
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 70.0,
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: widget.separateTimeOfDay ? widget.isAM ? 49 : 47 : 96,
                itemBuilder: (BuildContext context, int index) {

                  bool isSelected = widget.watchingTime != null ? widget.separateTimeOfDay ? widget.isAM ? index == widget.watchingTime! / 15 : (widget.watchingTime! - 49 * 15) / 15 == index /* TEST */ : index == widget.watchingTime! / 15 : false;

                  return Padding(
                    padding: EdgeInsets.only(
                      top: index == 0 ? kDefaultPadding : 6.0,
                      bottom: index == (widget.separateTimeOfDay ? widget.isAM ? 48 : 46 : 95) ? kDefaultPadding : 6.0
                    ),
                    child: SizedBox(
                      width: 70.0,
                      height: 38.0,
                      child: RawMaterialButton(
                        onPressed: () {

                          final int timeMinutes = widget.separateTimeOfDay ? widget.isAM ? index * 15 : (49 + index) * 15 : index * 15;

                          setState(() {
                            widget.watchingTime = timeMinutes;
                          });

                          widget.onTimeSelected(timeMinutes);
                        },
                        fillColor: isSelected ? widget.accentColor : widget.backgroundColor,
                        elevation: 0.0,
                        constraints: const BoxConstraints(),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(kDefaultBorderRadius)),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(kDefaultBorderRadius),
                            border: Border.all(
                              width: isSelected ? 0.0 : 2.0,
                              color: isSelected ? Colors.transparent : widget.secondaryColor
                            )
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            timeFromIndex(widget.separateTimeOfDay && !widget.isAM ? index + (index < 3 ? 49 : 1) : index),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                              color: isSelected ? widget.tertiaryColor : widget.secondaryColor,
                              height: 1.0
                            )
                          )
                        )
                      )
                    )
                  );
                }
              )
            ),
            if (widget.separateTimeOfDay) Column(
              children: List.generate(2, (int index) {

                final bool isSelected = widget.isAM && index == 0 || !widget.isAM && index == 1;

                return Padding(
                  padding: EdgeInsets.only(
                    top: index == 0 ? kDefaultPadding : 6.0,
                    bottom: index == 1 ? kDefaultPadding : 6.0
                  ),
                  child: SizedBox(
                    width: 48.0,
                    height: 38.0,
                    child: RawMaterialButton(
                      onPressed: () {
                        setState(() {
                          widget.isAM = index == 0;
                        });
                      },
                      fillColor: isSelected ? widget.accentColor : widget.backgroundColor,
                      elevation: 0.0,
                      constraints: const BoxConstraints(),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(kDefaultBorderRadius)),
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(kDefaultBorderRadius),
                          border: Border.all(
                            width: isSelected ? 0.0 : 2.0,
                            color: isSelected ? Colors.transparent : widget.secondaryColor
                          )
                        ),
                        child: Text(
                          index == 0
                            ? 'AM'
                            : 'PM',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0,
                            color: isSelected ? widget.tertiaryColor : widget.secondaryColor,
                            height: 1.0
                          )
                        )
                      )
                    )
                  )
                );
              })
            )
          ]
        )
      )
    );
  }
}