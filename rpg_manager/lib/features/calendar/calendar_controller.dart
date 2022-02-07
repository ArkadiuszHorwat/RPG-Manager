import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rpg_manager/features/calendar/calendar_event.dart';

class CalendarController {
  final eventSnapshot =
      FirebaseFirestore.instance.collection('events').snapshots();
  final events = FirebaseFirestore.instance.collection('events');

  Future<void> addEvent({
    required CalendarEvent event,
    String? sessionType,
    DateTime? selectedDay,
    String? userId,
  }) {
    return events.add({
      'title': event.title,
      'userId': userId,
      'userSessionType': sessionType,
      'date': selectedDay,
    }).then((value) {
      print("Event Added");
    })
        // ignore: invalid_return_type_for_catch_error
        .catchError((error) => print("Failed to add event: $error"));
  }
}
