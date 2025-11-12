import 'package:flutter/material.dart';

ThemeData lightMode()  {
  return ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      surface: Colors.white,
      outline: Color(0xFFD9D9D9),
      shadow: Colors.black,
      primary: Color(0xFF00461A),
      secondary: Color(0xFF83BF4F),
      tertiary: Color(0xFF022000),
    ),
    scaffoldBackgroundColor: Color(0xFF00461A)
  );
}

ThemeData darkMode() {
  return ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      surface: const Color.fromARGB(255, 53, 53, 53),
      outline: Color(0xFFD9D9D9),
      shadow: Colors.white,
      primary: Color(0xFF384A37),
      secondary: Color(0xFF4C6D2F),
      tertiary: Color(0xFF036603),
    )
  );
}

Map<ThemeMode, ThemeData> modeThemes = {
  ThemeMode.light: lightMode(),
  ThemeMode.system: lightMode(),
  ThemeMode.dark: darkMode(),
};

ThemeMode flipThemeMode(ThemeMode mode) {
  if (mode == ThemeMode.light){
    return ThemeMode.dark;
  }
  
  else if (mode == ThemeMode.dark){
    return ThemeMode.light;
  }

  else {
    return ThemeMode.system;
  }
}

class ThemeSelector extends ChangeNotifier {
  ThemeMode _selectedMode = ThemeMode.system;

  ThemeData theme = lightMode();
  ThemeData get themeData => modeThemes[_selectedMode] ?? () {
    print("error: selectedMode [$_selectedMode] not found, returning light");
    return lightMode();
  }();

  set themeData(ThemeData themeData) {
    theme = themeData;
  }


  ThemeMode get selectedMode => _selectedMode;

  void toggle({ThemeMode? force}) {
    _selectedMode = force ?? flipThemeMode(_selectedMode);
    notifyListeners();
  }
}

