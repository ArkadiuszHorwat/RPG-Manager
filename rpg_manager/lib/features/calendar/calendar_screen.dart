import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: TableCalendar(
          firstDay: DateTime.utc(2010, 10, 16),
          lastDay: DateTime.utc(2030, 3, 14),
          focusedDay: _focusedDay,
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDay, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
          },
          rowHeight: 70,
          daysOfWeekHeight: 50,
          startingDayOfWeek: StartingDayOfWeek.monday,
          locale: 'pl_PL',
          headerStyle: HeaderStyle(
            titleCentered: true,
            titleTextStyle: _calendarTitleTextStyle,
            rightChevronIcon: Icon(
              Icons.arrow_forward_ios_outlined,
              color: Color.fromARGB(255, 247, 241, 227),
            ),
            leftChevronIcon: Icon(
              Icons.arrow_back_ios_outlined,
              color: Color.fromARGB(255, 247, 241, 227),
            ),
            formatButtonVisible: false,
          ),
          daysOfWeekStyle: DaysOfWeekStyle(
            weekdayStyle: _calendarLightTextStyle,
            weekendStyle: _calendarLightTextStyle,
          ),
          calendarStyle: CalendarStyle(
            defaultTextStyle: _calendarDarkTextStyle,
            weekendTextStyle: _calendarDarkTextStyle,
            selectedTextStyle: _calendarLightTextStyle,
            todayTextStyle: _calendarTodayTextStyle,
            selectedDecoration: BoxDecoration(
              color: Color.fromARGB(255, 168, 128, 92),
              shape: BoxShape.circle,
            ),
            todayDecoration: BoxDecoration(
              color: Color.fromARGB(255, 247, 241, 227),
            ),
            rowDecoration: BoxDecoration(
              color: Color.fromARGB(255, 247, 241, 227),
              borderRadius: BorderRadiusDirectional.all(Radius.circular(5.0)),
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 168, 128, 92),
                  blurRadius: 1.0,
                  spreadRadius: 1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  final _calendarTitleTextStyle = GoogleFonts.rubik(
    textStyle: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: Color.fromARGB(255, 247, 241, 227),
    ),
  );

  final _calendarLightTextStyle = GoogleFonts.rubik(
    textStyle: TextStyle(
      fontSize: 16,
      color: Color.fromARGB(255, 247, 241, 227),
    ),
  );

  final _calendarDarkTextStyle = GoogleFonts.rubik(
    textStyle: TextStyle(
      fontSize: 16,
      color: Color.fromARGB(255, 168, 128, 92),
    ),
  );

  final _calendarTodayTextStyle = GoogleFonts.rubik(
    textStyle: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Color.fromARGB(255, 168, 128, 92),
    ),
  );
}
