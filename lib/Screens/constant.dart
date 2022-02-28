import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const defaultPadding = 20.0;
const cartBarHeight = 100.0;
const headerHeight = 85.0;

const bgColor = Color(0xFFF6F5F2);
const primaryColor = Color(0xFF40A944);

const panelTransition = Duration(milliseconds: 500);

const imageLoading = 'assets/claZwr.gif';

var dateTimeFormat = DateFormat("dd-MM-yyyy HH:mm a");

LinearGradient kGradient = LinearGradient(
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  colors: <Color>[
    Color(0xFF793AEC),
    Color(0xFF6217BC),
  ],
);

LinearGradient kGradientGrey = LinearGradient(
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  colors: <Color>[
    Colors.grey,
    Colors.grey,
  ],
);
