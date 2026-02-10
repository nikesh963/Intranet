import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CommonDateTimePicker {
  // Method to show a date picker
  static Future<String?> pickDOB(BuildContext context,
      {String format = 'yyyy-MM-dd'}) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.black,// Header background color
            scaffoldBackgroundColor: Colors.white, // Dialog background color
            buttonTheme: ButtonThemeData(
              textTheme: ButtonTextTheme.primary, // Button text color
            ),
            colorScheme: ColorScheme.light(
              primary:Colors.black, // Selected date color
              onPrimary: Colors.white, // Selected date text color
              onSurface: Colors.black, // Unselected date text color
            ),
            textTheme: TextTheme(
              bodyMedium: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 14,
                color: Colors.black87, // Date text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (selectedDate != null) {
      return DateFormat(format).format(selectedDate);
    }
    return null; // Return null if no date is selected
  }

  // Method to show a date picker
  static Future<String?> pickDate(BuildContext context,
      {String format = 'yyyy-MM-dd',
        bool isNext = false,
        String dateTime = ""}) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: isNext && dateTime != ""
          ? DateFormat(format).parse(dateTime)
          : DateTime.now(),
      firstDate: DateTime(1950),
      // firstDate: isNext
      //     ? dateTime == ""
      //     ? DateTime.now()
      //     : DateFormat(format).parse(dateTime)
      //     : DateTime.now().subtract(Duration(days: 365)),
      lastDate: DateTime.now().add(Duration(days: 365)),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.black, // Header background color
            scaffoldBackgroundColor: Colors.white, // Dialog background color
            buttonTheme: ButtonThemeData(
              textTheme: ButtonTextTheme.primary, // Button text color
            ),
            colorScheme: ColorScheme.light(
              primary: Colors.black,// Selected date color
              onPrimary: Colors.white, // Selected date text color
              onSurface: Colors.black, // Unselected date text color
            ),
            textTheme: TextTheme(
              bodyMedium: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 14,
                color: Colors.black87, // Date text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (selectedDate != null) {
      return DateFormat(format).format(selectedDate);
    }
    return null; // Return null if no date is selected
  }

  // Method to show a time picker
  static Future<String?> pickTime(BuildContext context,
      {String format = 'HH:mm'}) async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.black, // Header background color
            scaffoldBackgroundColor: Colors.white, // Dialog background color
            buttonTheme: ButtonThemeData(
              textTheme: ButtonTextTheme.primary, // Button text color
            ),
            colorScheme: ColorScheme.light(
              primary: Colors.black, // Selected date color
              onPrimary: Colors.white, // Selected date text color
              onSurface: Colors.black, // Unselected date text color
            ),
            textTheme: TextTheme(
              bodyMedium: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 14,
                color: Colors.black87, // Date text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (selectedTime != null) {
      final now = DateTime.now();
      final dateTime = DateTime(
        now.year,
        now.month,
        now.day,
        selectedTime.hour,
        selectedTime.minute,
      );
      return DateFormat(format).format(dateTime);
    }
    return null; // Return null if no time is selected
  }

  static String formatEventDate(DateTime dateTime) {
    return DateFormat('dd-MM-yyyy').format(dateTime);
  }

  static String formatDatee(DateTime dateTime) {
    return DateFormat('MMMM d').format(dateTime);
    // Example: "June 21"
  }

  static String formatEventDatebyS(String dateTime) {
    DateTime data = DateTime.parse(dateTime);
    return DateFormat('dd-MM-yyyy').format(data);
  }

  static String formatEventTime(String dateTime) {
    // RegExp regex = RegExp(r'^(0[0-9]|1[0-2]):[0-5][0-9]$');
    // if(regex.hasMatch(dateTime)==false){
    //   dateTime = "12:00";
    // }
    DateTime time = DateFormat("HH:mm").parse(dateTime);
    // Format the time in 12-hour format with AM/PM
    String formattedTime = DateFormat("hh:mm a").format(time);
    return formattedTime;
  }

  static String formatDateTime(DateTime dateTime) {
    // Parse the string to a DateTime object
    // DateTime data = DateFormat("yyyy-MM-dd").parse(dateTime);
    return DateFormat('yyyy-MM-dd').format(dateTime).toUpperCase();
  }

  static String formatDate(DateTime dateTime) {
    // Parse the string to a DateTime object
    // DateTime data = DateFormat("yyyy-MM-dd").parse(dateTime);
    return DateFormat("yyyy-MM-dd").format(dateTime);
  }
}