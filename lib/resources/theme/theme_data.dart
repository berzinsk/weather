import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather/resources/colors/colors.dart';

TextTheme theme = TextTheme(
  titleLarge: GoogleFonts.poppins(
    fontSize: 70,
    fontWeight: FontWeight.w500,
    color: AppColors.primary,
  ),
  titleMedium: GoogleFonts.poppins(
    fontSize: 30,
    fontWeight: FontWeight.w600,
    color: AppColors.primary,
  ),
  labelSmall: GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.labelGray,
  ),
  labelMedium: GoogleFonts.poppins(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: AppColors.labelDetailsGray,
  ),
  bodySmall: GoogleFonts.poppins(
    fontSize: 10,
    fontWeight: FontWeight.normal,
    color: AppColors.labelDetailsGray,
  ),
);
