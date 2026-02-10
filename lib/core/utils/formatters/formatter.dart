import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DBFormatter {
  static String formatCurrency(String amount, String currencyCode) {
    return NumberFormat.simpleCurrency(locale: 'en_US', name: currencyCode)
        .format(double.parse(amount));
  }


  static MaterialColor colorFormater(String color) {
    switch (color.toUpperCase()) {
      case "BLUE":
        return Colors.blue;
      case "GREEN":
        return Colors.green;
      default:
        return Colors.grey; // Provide a default color.
    }
  }


}

/*
*
*
* */
