import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {

  ThemeData getTheme() => ThemeData(
    useMaterial3   : true,
    colorSchemeSeed: Colors.blue,

    // Texts
    textTheme: TextTheme(
      titleLarge  : GoogleFonts.montserratAlternates( fontSize: 24 ),
      titleMedium : GoogleFonts.montserratAlternates(),
    ),

    
  );

}