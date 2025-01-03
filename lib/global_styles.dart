import 'package:flutter/material.dart';

const globalStyles = (
  colors: (
    green: Color.fromARGB(213, 119, 255, 1),
    green2: Color.fromARGB(255, 39, 222, 22),
    green3: Color.fromARGB(255, 22, 222, 89),
    red: Color(0xFFd50000),
    red2: Color.fromARGB(255, 255, 49, 111),
    red3: Color.fromARGB(255, 255, 110, 134),
    white: Color(0xFFf0fcff),
    black: Color(0xFF111718),
    primary: Color(0xFF90e0ef),
    secondary: Color(0xFF00b4d8),
    third: Color(0xFF023e8a),
    quart: Color(0xFF03045e),
    accent: Color(0xFFff8443),
    accent2: Color.fromARGB(255, 243, 207, 88),
    accent3: Color.fromARGB(255, 243, 184, 88),
  ),
  font: (
    size: 16.0,
    title: TextStyle(
      fontSize: 40, // Set the font size
      fontFamily:
          'LuckiestGuy', // Change the font (use any font available in your app)
      //fontWeight: FontWeight.bold, // Optional: Adjust font weight
      color: Color(0xFF111718),
    ),
    header: TextStyle(
      fontSize: 22.0, // Set the font size
      fontFamily:
          'Acme', // Change the font (use any font available in your app)
      fontWeight: FontWeight.bold, // Optional: Adjust font weight
      color: Color(0xFF111718),
    ),
    button: TextStyle(
      fontSize: 25, // Set the font size
      fontFamily:
          'LuckiestGuy', // Change the font (use any font available in your app)
      //fontWeight: FontWeight.bold, // Optional: Adjust font weight
      color: Color.fromARGB(255, 244, 253, 255),
      letterSpacing: 1,
      shadows: [
        Shadow(color: Colors.black, offset: Offset(2, 2), blurRadius: 4.5),
        // Shadow(color: Colors.black, offset: Offset(-1.5, 1.5), blurRadius: 1.5),
        // Shadow(
        //     color: Colors.black, offset: Offset(-1.5, -1.5), blurRadius: 1.5),
        // Shadow(color: Colors.black, offset: Offset(1.5, -1.5), blurRadius: 1.5)
      ],
    ),
    // buttonBorder: TextStyle(
    //   fontSize: 25, // Set the font size
    //   fontFamily:
    //       'LuckiestGuy', // Change the font (use any font available in your app)
    //   //fontWeight: FontWeight.bold, // Optional: Adjust font weight
    //   foreground: Paint()
    //     ..style = PaintingStyle.stroke
    //     ..strokeWidth = 1
    //     ..color = const Color.fromARGB(255, 0, 0, 0),
    //   // color: Color.fromARGB(255, 244, 253, 255),
    //   // shadows: [
    //   //   Shadow(color: Colors.black, offset: Offset(1.5, 1.5)),
    //   //   Shadow(color: Colors.black, offset: Offset(-1.5, 1.5)),
    //   //   Shadow(color: Colors.black, offset: Offset(-1.5, -1.5)),
    //   //   Shadow(color: Colors.black, offset: Offset(1.5, -1.5))
    //   // ],
    // ),
    normal: TextStyle(
      fontSize: 14.0, // Set the font size
      fontFamily:
          'Acme', // Change the font (use any font available in your app)
      fontWeight: FontWeight.w600, // Optional: Adjust font weight
      color: Color(0xFF111718),
    ),
    equations: TextStyle(
      fontSize: 30.0, // Set the font size
      letterSpacing: 5,
      fontFamily:
          'Acme', // Change the font (use any font available in your app)
      fontWeight: FontWeight.w600, // Optional: Adjust font weight
      color: Color(0xFF111718),
    ),
  ),
  // copied these base styles from tailwind.css
  border: (
    radius: (
      sm: 2.0,
      base: 4.0,
      md: 6.0,
      lg: 8.0,
      xl: 12.0,
      xl2: 16.0,
      xl3: 24.0,
    )
  ),
  boxShadow: (
    sm: [
      BoxShadow(
          color: Color.fromARGB(13, 0, 0, 0),
          offset: Offset(0.0, 1.0),
          blurRadius: 2.0,
          spreadRadius: 0.0,
          blurStyle: BlurStyle.normal)
    ],
    base: [
      BoxShadow(
          color: Color.fromARGB(26, 0, 0, 0),
          offset: Offset(0.0, 1.0),
          blurRadius: 3.0,
          spreadRadius: 0.0,
          blurStyle: BlurStyle.normal),
      BoxShadow(
          color: Color.fromARGB(26, 0, 0, 0),
          offset: Offset(0.0, 1.0),
          blurRadius: 2.0,
          spreadRadius: -1.0,
          blurStyle: BlurStyle.normal),
    ],
    md: [
      BoxShadow(
          color: Color.fromARGB(26, 0, 0, 0),
          offset: Offset(0.0, 4.0),
          blurRadius: 6.0,
          spreadRadius: -1.0,
          blurStyle: BlurStyle.normal),
      BoxShadow(
          color: Color.fromARGB(26, 0, 0, 0),
          offset: Offset(0.0, 1.0),
          blurRadius: 4.0,
          spreadRadius: -2.0,
          blurStyle: BlurStyle.normal)
    ],
    lg: [
      BoxShadow(
          color: Color.fromARGB(26, 0, 0, 0),
          offset: Offset(0.0, 10.0),
          blurRadius: 15.0,
          spreadRadius: -3.0,
          blurStyle: BlurStyle.normal),
      BoxShadow(
          color: Color.fromARGB(26, 0, 0, 0),
          offset: Offset(0.0, 4.0),
          blurRadius: 6.0,
          spreadRadius: -4.0,
          blurStyle: BlurStyle.normal)
    ],
    xl: [
      BoxShadow(
          color: Color.fromARGB(26, 0, 0, 0),
          offset: Offset(0.0, 20.0),
          blurRadius: 25.0,
          spreadRadius: -5.0,
          blurStyle: BlurStyle.normal),
      BoxShadow(
          color: Color.fromARGB(26, 0, 0, 0),
          offset: Offset(0.0, 8.0),
          blurRadius: 10.0,
          spreadRadius: -6.0,
          blurStyle: BlurStyle.normal)
    ],
    xl2: [
      BoxShadow(
          color: Color.fromARGB(64, 0, 0, 0),
          offset: Offset(0.0, 25.0),
          blurRadius: 50.0,
          spreadRadius: -12.0,
          blurStyle: BlurStyle.normal)
    ],
    inner: [
      BoxShadow(
          color: Color.fromARGB(13, 0, 0, 0),
          offset: Offset(0.0, 2.0),
          blurRadius: 4.0,
          spreadRadius: 0.0,
          blurStyle: BlurStyle.inner)
    ]
  )
);
