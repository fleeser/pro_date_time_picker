import 'package:flutter/material.dart';

import 'package:pro_date_time_picker/src/constants.dart';
import 'package:pro_date_time_picker/src/helpers.dart';

class ProDateModal extends StatefulWidget {

  final DateTime? selectedDate;
  final void Function(DateTime date) onDateSelected;
  final Color backgroundColor;
  final Color primaryColor;
  final Color secondaryColor;
  final Color accentColor;
  final Color tertiaryColor;

  late PageController controller;
  late int watchingYear;
  late int watchingMonth;
  late DateTime? watchingDate;

  ProDateModal({ 
    Key? key,
    this.selectedDate,
    required this.onDateSelected,
    this.backgroundColor = Colors.white,
    this.primaryColor = Colors.black,
    this.secondaryColor = Colors.grey,
    this.accentColor = Colors.blue,
    this.tertiaryColor = Colors.white
  }) : super(key: key);

  @override
  State<ProDateModal> createState() => _ProDateModalState();
}

class _ProDateModalState extends State<ProDateModal> {

  @override
  void initState() {
    widget.controller = PageController(initialPage: (widget.selectedDate != null ? widget.selectedDate!.month : DateTime.now().month) - 1);
    widget.watchingYear = widget.selectedDate != null ? widget.selectedDate!.year : DateTime.now().year;
    widget.watchingMonth = widget.selectedDate != null ? widget.selectedDate!.month : DateTime.now().month;
    widget.watchingDate = widget.selectedDate;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: 2 * kDefaultPadding + 7 * 38.0 + 6 * 6.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kDefaultBorderRadius),
          color: widget.backgroundColor
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(kDefaultPadding),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      getMonthFromValue(widget.watchingMonth),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: widget.primaryColor,
                        height: 1.0
                      )
                    )
                  ),
                  const SizedBox(width: kDefaultPadding),
                  RawMaterialButton(
                    onPressed: () {},
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(kDefaultBorderRadius)),
                    padding: const EdgeInsets.all(12.0),
                    constraints: const BoxConstraints(),
                    elevation: 0.0,
                    child: Text(
                      widget.watchingYear.toString(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        height: 1.0,
                        color: widget.primaryColor
                      )
                    )
                  ),
                  const SizedBox(width: kDefaultPadding),
                  ...List.generate(2, (int index) => RawMaterialButton(
                    onPressed: () {
                      widget.controller.animateToPage(
                        index == 0 
                          ? widget.controller.page!.toInt() - 1
                          : widget.controller.page!.toInt() + 1,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.bounceIn
                      );
                    },
                    elevation: 0.0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.0)),
                    padding: const EdgeInsets.all(12.0),
                    constraints: const BoxConstraints(),
                    child: Icon(
                      index == 0
                        ? Icons.arrow_back_ios_rounded
                        : Icons.arrow_forward_ios_rounded,
                      color: widget.secondaryColor,
                      size: 20.0
                    )
                  ))
                ]
              )
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(7, (int index) => SizedBox(
                  width: 38.0,
                  child: Text(
                    getWeekDayFromIndex(index),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: widget.primaryColor,
                      height: 1.0,
                      fontSize: 14.0
                    )
                  )
                ))
              )
            ),
            SizedBox(
              height: kDefaultPadding + 20.0 + kDefaultPadding + 14.0 + 6 * (38.0 + 6.0) + kDefaultPadding,
              child: PageView.builder(
                controller: widget.controller,
                itemCount: 12,
                onPageChanged: (int index) {
                  setState(() {
                    widget.watchingMonth = index + 1;
                  });
                },
                itemBuilder: (BuildContext context, int index) => Padding(
                  padding: const EdgeInsets.all(kDefaultPadding),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // TODO
                    children: List.generate(6, (int column) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(7, (row) => SizedBox(
                        width: 38.0,
                        height: 38.0,
                        child: (column > 0 || row >= DateTime(widget.watchingYear, widget.watchingMonth, 1).weekday - 1) && calculateValueForCell(DateTime(widget.watchingYear, widget.watchingMonth, 1).weekday - 1, column, row) <= DateTime(widget.watchingYear, widget.watchingMonth + 1, 0).day
                          ? RawMaterialButton(
                            onPressed: () {

                              final DateTime dateTime = DateTime(widget.watchingYear, widget.watchingMonth, calculateValueForCell(DateTime(widget.watchingYear, widget.watchingMonth, 1).weekday - 1, column, row));

                              setState(() {
                                widget.watchingDate = dateTime;
                              });

                              widget.onDateSelected(dateTime);
                            },
                            fillColor: widget.watchingDate != null && widget.watchingDate! == DateTime(widget.watchingYear, widget.watchingMonth, calculateValueForCell(DateTime(widget.watchingYear, widget.watchingMonth, 1).weekday - 1, column, row)) 
                              ? widget.accentColor
                              : widget.backgroundColor,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(19.0)),
                            elevation: 0.0,
                            child: Text(
                              '${calculateValueForCell(DateTime(widget.watchingYear, widget.watchingMonth, 1).weekday - 1, column, row)}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14.0,
                                color: widget.watchingDate != null && widget.watchingDate! == DateTime(widget.watchingYear, widget.watchingMonth, calculateValueForCell(DateTime(widget.watchingYear, widget.watchingMonth, 1).weekday - 1, column, row)) 
                                  ? widget.tertiaryColor
                                  : DateTime(widget.watchingYear, widget.watchingMonth, calculateValueForCell(DateTime(widget.watchingYear, widget.watchingMonth, 1).weekday - 1, column, row)).isBefore(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)) 
                                    ? widget.secondaryColor
                                    : DateTime(widget.watchingYear, widget.watchingMonth, calculateValueForCell(DateTime(widget.watchingYear, widget.watchingMonth, 1).weekday - 1, column, row)).isAfter(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)) 
                                      ? widget.primaryColor 
                                      : widget.accentColor,
                                height: 1.0
                              )
                            )
                          )
                        : null
                      ))
                    ))
                  )
                )
              )
            )
          ]
        )
      )
    );
  }
}