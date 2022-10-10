// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors_constent.dart';

// Style for title
var mTitleStyle = GoogleFonts.inter(
    fontWeight: FontWeight.w700, color: mTitleColor, fontSize: 13);

// Style for Discount Section
var mMoreDiscountStyle = GoogleFonts.inter(
    fontSize: 12, fontWeight: FontWeight.w700, color: mBlueColor);

// Style for Service Section
var mServiceTitleStyle = GoogleFonts.inter(
    fontWeight: FontWeight.bold, fontSize: 12, color: mTextStyle);
var mServiceSubtitleStyle = GoogleFonts.inter(
    fontWeight: FontWeight.w400, fontSize: 10, color: mSubtitleColor);

// Style for Popular Destination Section
var mPopularDestinationTitleStyle = GoogleFonts.inter(
  fontWeight: FontWeight.w700,
  fontSize: 16,
  color: mCardTitleColor,
);
var mPopularDestinationSubtitleStyle = GoogleFonts.inter(
  fontWeight: FontWeight.w500,
  fontSize: 10,
  color: mCardSubtitleColor,
);

// Style for Travlog Section
var mTravlogTitleStyle = GoogleFonts.inter(
    fontSize: 14, fontWeight: FontWeight.w900, color: mFillColor);
var mTravlogContentStyle = GoogleFonts.inter(
    fontSize: 10, fontWeight: FontWeight.w500, color: mTitleColor);
var mTravlogPlaceStyle = GoogleFonts.inter(
    fontSize: 10, fontWeight: FontWeight.w500, color: mBlueColor);
var mTextStyle1 = TextStyle(
  color: Color.fromARGB(232, 34, 28, 28),
  shadows: <Shadow>[
    Shadow(
      offset: Offset(2.0, 2.0),
      blurRadius: 3.0,
      color: Color.fromARGB(255, 248, 242, 242),
    ),
    Shadow(
      offset: Offset(2.0, 2.0),
      blurRadius: 8.0,
      color: Color.fromARGB(124, 94, 94, 107),
    ),
  ],
);
var mTextStyle2 = TextStyle(
  fontSize: 15,
  fontWeight: FontWeight.bold,
  color: Color.fromARGB(232, 34, 28, 28),
  shadows: <Shadow>[
    Shadow(
      offset: Offset(2.0, 2.0),
      blurRadius: 3.0,
      color: Color.fromARGB(255, 248, 242, 242),
    ),
    Shadow(
      offset: Offset(2.0, 2.0),
      blurRadius: 8.0,
      color: Color.fromARGB(124, 94, 94, 107),
    ),
  ],
);

var mTextStyleHeader = TextStyle(
  // fontSize: 15,
  fontWeight: FontWeight.bold,
  color: Color.fromARGB(232, 255, 255, 255),
  shadows: <Shadow>[
    Shadow(
      offset: Offset(2.0, 2.0),
      blurRadius: 3.0,
      color: Color.fromARGB(255, 0, 0, 0),
    ),
    Shadow(
      offset: Offset(2.0, 2.0),
      blurRadius: 8.0,
      color: Color.fromARGB(124, 94, 94, 107),
    ),
  ],
);
var mTextStyleButton = TextStyle(
  color: Color.fromARGB(232, 255, 255, 255),
  // shadows: <Shadow>[
  //   Shadow(
  //     offset: Offset(2.0, 2.0),
  //     blurRadius: 3.0,
  //     color: Color.fromARGB(255, 0, 0, 0),
  //   ),
  //   Shadow(
  //     offset: Offset(2.0, 2.0),
  //     blurRadius: 8.0,
  //     color: Color.fromARGB(124, 94, 94, 107),
  //   ),
  // ],
);

var mButtonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(Colors.cyan),
    minimumSize: MaterialStateProperty.all(
      Size(130, 40),
    ),
    shape: MaterialStateProperty.all(RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: Colors.white))));

var mTextformfield = TextStyle(
  // fontSize: 15,
  fontWeight: FontWeight.bold,
  color: Color.fromARGB(232, 187, 179, 179),
  shadows: <Shadow>[
    Shadow(
      offset: Offset(2.0, 2.0),
      blurRadius: 3.0,
      color: Color.fromARGB(255, 0, 0, 0),
    ),
    Shadow(
      offset: Offset(2.0, 2.0),
      blurRadius: 8.0,
      color: Color.fromARGB(124, 94, 94, 107),
    ),
  ],
);
