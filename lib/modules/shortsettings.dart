import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geeco/bax_end/theme_bax_end.dart';
import 'package:provider/provider.dart';
import 'package:scaled_size/scaled_size.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import '../pages/about.dart';

class ShortSettings extends StatefulWidget {
  const ShortSettings({super.key});

  @override
  State<ShortSettings> createState() => _ShortSettingsState();
}

class _ShortSettingsState extends State<ShortSettings> {
  bool darkModeOn = true;
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.dark_mode),
                SizedBox(width: 8), 
                          Text(
                            "Dark Mode",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Switch(
                        // This bool value toggles the switch.
                        value: Provider.of<ThemeSelector>(context).isDark,
                        activeColor: Theme.of(context).colorScheme.secondary,
                        onChanged: (bool value) {
                          Provider.of<ThemeSelector>(context, listen: false).toggle();
                        },
                      ),
                    ],
                  ),
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

Future<void> clearHistory() async {
  String message = "";
  SharedPreferences prefs = await SharedPreferences.getInstance();
  dynamic data = prefs.get("History");
  if(data != null) {
    List<String> history = [];
    history = data as List<String>;
    int length = history.length;
    if(history.length > 0) {
      prefs.setStringList("History", []);
      for(var i = 0; i < length; i++) if(prefs.get("Images$i") != null)prefs.setStringList("Images$i", []);
      message = "History Cleared";
    } else message = "Your history is empty.";
  } else message = "Your history is empty.";
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

