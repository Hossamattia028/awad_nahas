

// const primaryFontReg = "Poppins-Regular";
// const primaryFontBold = "Poppins-Bold";
// const primaryFontSemiBold = "Poppins-SemiBold";

import 'package:awad_nahas/core/utils/small_fun.dart';
import 'package:google_fonts/google_fonts.dart';

var primaryFontReg =  Util.getLang()!="ar"?GoogleFonts.poppins().fontFamily:GoogleFonts.tajawal().fontFamily;
var primaryFontBold = Util.getLang()!="ar"?GoogleFonts.poppins().fontFamily:GoogleFonts.tajawal().fontFamily;
var primaryFontSemiBold = Util.getLang()!="ar"?GoogleFonts.poppins().fontFamily:GoogleFonts.tajawal().fontFamily;
