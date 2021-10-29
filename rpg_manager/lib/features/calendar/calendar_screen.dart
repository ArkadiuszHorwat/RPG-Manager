import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rpg_manager/app_assets/colors/colors.dart';
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
              color: AppColors.appLight,
            ),
            leftChevronIcon: Icon(
              Icons.arrow_back_ios_outlined,
              color: AppColors.appLight,
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
              color: AppColors.appDark,
              shape: BoxShape.circle,
            ),
            todayDecoration: BoxDecoration(
              color: AppColors.appLight,
            ),
            rowDecoration: BoxDecoration(
              color: AppColors.appLight,
              borderRadius: BorderRadiusDirectional.all(Radius.circular(5.0)),
              boxShadow: [
                BoxShadow(
                  color: AppColors.appDark,
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
      color: AppColors.appLight,
    ),
  );

  final _calendarLightTextStyle = GoogleFonts.rubik(
    textStyle: TextStyle(
      fontSize: 16,
      color: AppColors.appLight,
    ),
  );

  final _calendarDarkTextStyle = GoogleFonts.rubik(
    textStyle: TextStyle(
      fontSize: 16,
      color: AppColors.appDark,
    ),
  );

  final _calendarTodayTextStyle = GoogleFonts.rubik(
    textStyle: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: AppColors.appDark,
    ),
  );
}
