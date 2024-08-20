import 'package:flutter/material.dart';

TextStyle logoTS = const TextStyle(
  fontFamily: 'BubblegumSans',
  fontWeight: FontWeight.w400,
);
TextStyle regularTS = const TextStyle(
  fontFamily: 'PlusJakartaSans',
  fontWeight: FontWeight.w400,
);
TextStyle mediumTS = const TextStyle(
  fontFamily: 'PlusJakartaSans',
  fontWeight: FontWeight.w500,
);
TextStyle semiboldTS = const TextStyle(
  fontFamily: 'PlusJakartaSans',
  fontWeight: FontWeight.w600,
);
TextStyle boldTS = const TextStyle(
  fontFamily: 'PlusJakartaSans',
  fontWeight: FontWeight.w700,
);
TextStyle extraboldTS = const TextStyle(
  fontFamily: 'PlusJakartaSans',
  fontWeight: FontWeight.w800,
);

BoxShadow shade = const BoxShadow(
  color: Color.fromRGBO(0, 0, 0, 0.1),
  offset: Offset(0, 4),
  blurRadius: 20,
);

InputBorder defaultInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(8),
  borderSide: BorderSide(color: Colors.grey.shade400),
);
