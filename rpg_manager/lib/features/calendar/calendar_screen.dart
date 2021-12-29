import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rpg_manager/app_assets/colors/colors.dart';
import 'package:rpg_manager/features/calendar/calendar_event.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late Map<DateTime, List<CalendarEvent>> selectedEvents;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  @override
  void initState() {
    selectedEvents = {};
    super.initState();
  }

  List<CalendarEvent> _getEventsFromDay(DateTime date) {
    return selectedEvents[date] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            _calendar(),
            SizedBox(
              height: 15,
            ),
            _addEvent(context),
            ..._getEventsFromDay(_selectedDay)
                .map((CalendarEvent event) => ListTile(
                      title: Text(
                        event.title,
                        style: GoogleFonts.rubik(
                          textStyle: TextStyle(
                            color: AppColors.appLight,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    )),
          ],
        ),
      ),
    );
  }

  Widget _calendar() {
    return TableCalendar(
      eventLoader: _getEventsFromDay,
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
    );
  }

  Widget _addEvent(
    BuildContext context,
  ) {
    return Container(
      width: 250,
      decoration: BoxDecoration(
        color: AppColors.appDark,
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 3,
            spreadRadius: 0.5,
          ),
        ],
        borderRadius: BorderRadiusDirectional.all(Radius.circular(20)),
      ),
      child: TextButton(
        onPressed: () => eventEditHandle(context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                "Dodaj wydarzenie",
                style: GoogleFonts.rubik(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: AppColors.appLight,
                  ),
                ),
              ),
            ),
            Icon(
              CupertinoIcons.plus_app_fill,
              color: AppColors.appLight,
            ),
          ],
        ),
      ),
    );
  }

  void eventEditHandle(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          final textController = TextEditingController();

          return AlertDialog(
            backgroundColor: AppColors.appLight,
            title: Column(
              children: [
                Divider(
                  color: AppColors.appDark,
                ),
                Text(
                  "Dodaj wydarzenie",
                  style: GoogleFonts.rubik(
                    textStyle: TextStyle(
                      color: AppColors.appDark,
                      fontSize: 14.0,
                    ),
                  ),
                ),
                Divider(
                  color: AppColors.appDark,
                ),
                Container(
                  height: 50,
                  child: TextFormField(
                    controller: textController,
                    keyboardType: TextInputType.multiline,
                    maxLines: 15,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Nazwa wydarzenia",
                      hintStyle: GoogleFonts.rubik(
                        textStyle: TextStyle(
                          color: Colors.black45,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    autofocus: false,
                  ),
                ),
                Divider(
                  color: AppColors.appDark,
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  if (textController.text.isEmpty) {
                    print("Zła wartość");
                  } else {
                    if (selectedEvents[_selectedDay] != null) {
                      selectedEvents[_selectedDay]!.add(
                        CalendarEvent(title: textController.text),
                      );
                    } else {
                      selectedEvents[_selectedDay] = [
                        CalendarEvent(title: textController.text),
                      ];
                    }
                  }
                  Navigator.pop(context);
                  textController.clear();
                  setState(() {});
                  return;
                },
                child: Text(
                  'Zapisz',
                  style: GoogleFonts.rubik(
                    textStyle: TextStyle(
                      color: AppColors.appDark,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Wróć',
                  style: GoogleFonts.rubik(
                    textStyle: TextStyle(
                      color: AppColors.appDark,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
            ],
          );
        });
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
