import 'package:flutter/material.dart';
import 'package:remindme/model/date.dart';

class HorizontalDate extends StatefulWidget {
  final DateTime currentDate;
  final Function(DateTime) onDateSelected;

  const HorizontalDate({
    super.key,
    required this.currentDate,
    required this.onDateSelected,
  });

  @override
  _HorizontalDateState createState() => _HorizontalDateState();
}

class _HorizontalDateState extends State<HorizontalDate> {
  final ScrollController _scrollController = ScrollController();
  double boxWidth = 60.0;
  double boxMargin = 4.0;
  late double position;
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.currentDate;
    position = widget.currentDate.day - 1;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      double targetPosition = position * (boxWidth + boxMargin + 4);
      _scrollController.jumpTo(targetPosition);
    });
  }

  @override
  Widget build(BuildContext context) {
    final position = widget.currentDate.day - 1;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      controller: _scrollController,
      child: Row(
          children: List.generate(
        DateModel.getDaysInMonth(widget.currentDate),
        (index) => GestureDetector(
          onTap: () {
            final newDate = DateTime(
                widget.currentDate.year, widget.currentDate.month, index + 1);
            widget.onDateSelected(newDate);
          },
          child: Container(
              decoration: BoxDecoration(
                color:
                    index == position ? Colors.purple[300] : Colors.grey[200],
              ),
              clipBehavior: Clip.hardEdge,
              width: boxWidth,
              height: 80,
              margin: EdgeInsets.all(boxMargin),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      DateModel.getDayName(widget.currentDate, index),
                      style: index == position
                          ? TextStyle(color: Colors.white)
                          : TextStyle(color: Colors.black),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: index == position
                              ? Colors.purple[700]
                              : Colors.grey[300],
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10))),
                      child: Center(
                          child: Text(
                        "${index + 1}",
                        style: TextStyle(
                            fontWeight: index == position
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color:
                                index == position ? Colors.white : Colors.black,
                            fontSize: 20),
                      )),
                    ),
                  )
                ],
              )),
        ),
      )),
    );
  }
}
