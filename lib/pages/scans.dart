import 'package:flutter/material.dart';
import 'package:scaled_size/scaled_size.dart';

class ScansPage extends StatefulWidget {
  const ScansPage({super.key});

  @override
  State<ScansPage> createState() => _ScansPageState();
}

class _ScansPageState extends State<ScansPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      SizedBox.expand(
        child: Column(
          children: [
          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Placeholder(fallbackWidth: 100, fallbackHeight: 200),
                Placeholder(fallbackWidth: 100, fallbackHeight: 200),
                Placeholder(fallbackWidth: 100, fallbackHeight: 200),
                
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding:EdgeInsetsGeometry.symmetric(horizontal: 2.0.rem, vertical: 1.0.rem),
              child:ElevatedButton.icon(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.resolveWith(captureButton),
                ),
                icon: Icon(Icons.camera, color:Colors.white),
                label: Text("Take a Photo", style: TextStyle(color: Colors.white, fontSize: 1.25.rem, fontFamily: "Gabarito")),
                onPressed: () {},
              ),
            ),
          ),],
        ),
      ),
    );
  }
}

Color captureButton(Set<WidgetState> states) {
  if (states.contains(WidgetState.pressed)){
    return Color(0xFF3ACF72);
  }
  else {
    return Color(0xFF3ACF72);
  }
}

Widget tempCapturedContainer() {
  return Stack(
    children: [
      FractionallySizedBox(
        heightFactor: 0.35,
        widthFactor: 0.25,
        child: Placeholder()
      ),
    ],
  );
}

Widget capturedContainer() {
  return Stack(
    children: [
      Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("")
          )
        ),
          
      )
    ],
  );
}