import 'package:flutter/material.dart';
import 'package:school_management_app/app/common/style.dart';
import 'package:table_calendar/table_calendar.dart';


class CustomCalendar extends StatefulWidget {
  final bool formatvisible;
  final bool isEvent;
  final String ?dateValue;
  final bool ?isSchedule;
  const CustomCalendar({super.key, required this.formatvisible, required this.isEvent, this.dateValue, this.isSchedule});

  @override
  State<CustomCalendar> createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
    CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime? _selectedDay;
  dynamic datesevent;
  dynamic mapData;
  dynamic newdate;
  dynamic date;
  dynamic formattedDate;
  dynamic userId;
  dynamic selectionDate;


    
   void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
         date = DateTime.parse(_selectedDay.toString());
        if(widget.isSchedule==true){
        Navigator.pop(context);

        }
        
      });
      
    }
  }
    
  
  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      calendarFormat:  _calendarFormat,
      firstDay: DateTime.utc(2010, 10, 16),
      lastDay: DateTime.utc(2030, 3, 14),
       onDaySelected: _onDaySelected,
       selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
      focusedDay: DateTime.now(),
      calendarBuilders: CalendarBuilders(
        markerBuilder: (context, day, focusedDay) {
          var splitsFromdate = day.toString().split(' ');
          var todayDate=DateTime.now();
          var date = DateTime.parse(todayDate.toString());
          var formattedDate = "${date.year}-${0}${date.month}-${date.day}";
          var currentDay = splitsFromdate[0];
          return widget.isEvent==true&&currentDay==formattedDate? Container(
            height: 5,
            width: 5,
            alignment: Alignment.center,
            decoration:  const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.all(Radius.circular(100.0))
            )
          ):const SizedBox();
        } 
      ),
      headerStyle:  HeaderStyle(
        leftChevronIcon: const Icon(Icons.arrow_back_ios_new_outlined,color: primaryColor),
        rightChevronIcon: const Icon(Icons.arrow_forward_ios_outlined,color: primaryColor),
        formatButtonVisible: widget.formatvisible,
        titleCentered: true,
      ),
       onFormatChanged: (format) {
          if (_calendarFormat != format) {
            setState(() {
              _calendarFormat = format;
            });
          }
        },
      calendarStyle:  const CalendarStyle(
        todayDecoration:BoxDecoration(
          color: primaryColor,
          shape: BoxShape.circle
        ),
        selectedDecoration: BoxDecoration(
          shape: BoxShape.circle ,
          color: primaryColor
        ),
      ),
    );
  }
}