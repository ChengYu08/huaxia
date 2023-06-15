import 'package:flutter/material.dart';
import 'package:huaxia/widgets/tabbar_gradient_indicator.dart';

class AppTheme {
  static Color get mainColor => const Color(0xff00BEBD );

  static ThemeData get theme {
    final inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
      borderSide: BorderSide.none,
    );
    return ThemeData(
      primarySwatch: Colors.pink,
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: mainColor,
      ),
      scaffoldBackgroundColor: const Color(0xffF4F5F7),
      popupMenuTheme: PopupMenuThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      tabBarTheme: TabBarTheme(
        labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        unselectedLabelStyle: TextStyle(fontSize: 16),
        labelColor: Color(0xff202329),
        indicatorSize: TabBarIndicatorSize.label,
        indicator: TabBarGradientIndicator(gradientColor: [
          const Color(0xff00E0E0).withOpacity(.1),
          const Color(0xff00BEBD)
        ], indicatorWidth: 4),
        unselectedLabelColor: const Color(0xff585F69),
      ),
      appBarTheme: const AppBarTheme(
          backgroundColor:  Color(0xffF4F5F7),
          centerTitle: true,
          titleTextStyle: TextStyle(
        color: Color(0xff202329),
        fontSize: 18,
      )),

      iconTheme: const IconThemeData(color: Color(0xff83888F)),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          side: MaterialStatePropertyAll(BorderSide(color: Color(0xffE1E2E8 ),width: 1)),
          textStyle: MaterialStatePropertyAll(TextStyle(color: Color(0xff202329),fontSize: 14))
        )
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(Color(0xff00BEBD)),
          textStyle: MaterialStatePropertyAll(TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold)),
          foregroundColor: MaterialStatePropertyAll(Colors.white)
        )
      ),

      textTheme: const TextTheme(
          displaySmall: TextStyle(color: Colors.black, fontSize: 20),
          titleLarge: TextStyle(color: Color(0xff202329), fontSize: 24,fontWeight: FontWeight.bold),
          headlineMedium:TextStyle(color: Color(0xff202329), fontSize: 20) ,
          titleMedium: TextStyle(color: Color(0xff585F69), fontSize: 18),
          titleSmall: TextStyle(color: Color(0xff585F69), fontSize: 16),
          bodyLarge: TextStyle(color: Color(0xff202329), fontSize: 18),
          bodyMedium: TextStyle(color: Color(0xff202329), fontSize: 16),
         bodySmall: TextStyle(color: Color(0xff202329), fontSize: 14),
          labelLarge: TextStyle(color: Color(0xff83888F),fontSize: 12),
          labelMedium: TextStyle(color: Color(0xff585F69),fontSize: 11),
          labelSmall: TextStyle(color: Color(0xff222429),fontSize: 10),

      ),
      dividerColor: const Color(0xffC2C6CE),
      dividerTheme: const DividerThemeData(
        color: Color(0xffC2C6CE),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: Color(0xff83888F),fontSize: 14)
        // fillColor: Colors.white,
        // border: inputBorder,
        // errorBorder: inputBorder,
        // enabledBorder: inputBorder,
        // focusedBorder: inputBorder,
        // disabledBorder: inputBorder,
      ),
    );
  }
}
