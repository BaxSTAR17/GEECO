import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geeco/bax_end/theme_bax_end.dart';
import 'package:provider/provider.dart';
import 'package:scaled_size/scaled_size.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:collection/collection.dart';
// import '../pages/about.dart';

class ShortSettings extends StatefulWidget {
  const ShortSettings({super.key});

  @override
  State<ShortSettings> createState() => _ShortSettingsState();
}

const List<String> displayModeChoices = ["Bright", "Dark", "System", ];
typedef MenuEntry = DropdownMenuEntry<String>;
class _ShortSettingsState extends State<ShortSettings> {
  bool darkModeOn = true;
  
  List<DropdownMenuEntry<String>> displayModeMenuEntries = 
    displayModeChoices.map<MenuEntry>(
      (choice) => MenuEntry(value:choice, label:choice.toLowerCase())
    ).toList();
  bool notificationsEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FractionallySizedBox(
          widthFactor: 0.80,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(5.0),
              border: BoxBorder.all(color: Theme.of(context).colorScheme.shadow, width: 1.0),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 10.0,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BrightnessModeSlider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.resolveWith(
                              clearButton,
                            ),
                          ),
                          icon: Icon(Icons.delete, color: Colors.white),
                          label: Text(
                            "Clear History",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            showDialog(
                              context: context, 
                              builder: (BuildContext context) {
                                return SimpleDialog(
                                  title: Text("Are you sure you want to clear your history?"),
                                  children: [
                                    SimpleDialogOption(
                                      onPressed: () {
                                        clearHistory();
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        "Delete",
                                        style: TextStyle(
                                          color:Colors.red
                                        ),
                                      )
                                    ),
                                    SimpleDialogOption(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("Cancel")
                                    )
                                  ],
                                );
                              }
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class BrightnessModeIcon extends StatefulWidget {
  final int id;
  final IconData icon;

  const BrightnessModeIcon({super.key, required this.id, required this.icon});

  @override
  State<BrightnessModeIcon> createState() => _BrightnessModeIconState();
}

class _BrightnessModeIconState extends State<BrightnessModeIcon> {
  late Icon icon;
  Color activeColor = Color(0xFF3ACF72);
  Color inactiveColor = Colors.grey;
  late Color currentColor;

  setActiveState(int newId) {
    currentColor = newId == widget.id ? activeColor: inactiveColor;
  }

  @override
  Widget build(BuildContext context) {
    return Icon(
      widget.icon,
      color: currentColor,
    );
  }
}

class BrightnessModeSlider extends StatefulWidget {
  const BrightnessModeSlider({super.key});

  @override
  State<BrightnessModeSlider> createState() => _BrightnessModeSliderState();
}

class _BrightnessModeSliderState extends State<BrightnessModeSlider> {
  int currentMode = 1;
  void setValue(double newValue) {
    setState(() {
      currentMode =  newValue.toInt();
      if (currentMode == 0) {
        Provider.of<ThemeSelector>(context, listen: false).toggle(force: ThemeMode.light);
      }

      if (currentMode == 1) {
        Provider.of<ThemeSelector>(context, listen: false).toggle(force: MediaQuery.of(context).platformBrightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light);
      }

      if (currentMode == 2) {
        Provider.of<ThemeSelector>(context, listen: false).toggle(force: ThemeMode.dark);
      }
      
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> modes = ["Light", "System", "Dark"];
    const int stops = 3-1;
    Slider slider = Slider(
      value: currentMode.toDouble(),
      onChanged: setValue,
      divisions: stops,
      min: 0.0,
      max: 2.0,
      padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
      thumbColor: Color(0xFF83BF4F),
      activeColor: Color(0xFF83BF4F),
    );
    

    return Column(
      mainAxisSize: MainAxisSize.min,
      
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Theme Mode", style: TextStyle(fontWeight: FontWeight.bold),),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: modes.map((label) => Text(label)).toList(),
        ),
        slider,
      ],
    );
  }
}

Future<void> clearHistory() async {
  String message = "";
  SharedPreferences prefs = await SharedPreferences.getInstance();
  dynamic data = prefs.get("History");
  if(data != null) {
    List<String> history = [];
    history = data as List<String>;
    int length = history.length;
    if(history.isNotEmpty) {
      prefs.setStringList("History", []);
      for(var i = 0; i < length; i++) {
        if (prefs.get("Images$i") != null) {
          prefs.setStringList("Images$i", []);
        }
      }
      message = "History Cleared";
    }
    else {
      message = "Your history was already empty.";
    }
  }
  
  else {
    message = "Your history is now empty.";
  }
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    fontSize: 0.8.rem,
  );
}

Color clearButton(Set<WidgetState> states) {
  if (states.contains(WidgetState.pressed)) {
    return Colors.red.shade500;
  } else {
    return Colors.red.shade600;
  }
}

