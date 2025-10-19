import 'package:flutter/material.dart';
import 'package:scaled_size/scaled_size.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return ScaledSize(
      size: Size(ScaledSizeUtil.screenWidth, ScaledSizeUtil.screenHeight),
      builder: () {
        return Container(
          constraints: BoxConstraints.expand(),
          // decoration: BoxDecoration(
          //   image: DecorationImage(
          //     opacity: 0.2,
          //     image: AssetImage('assets/images/homepage_bg.png'),
          //     fit: BoxFit.contain
          //   )
          // ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: ScaledSizeUtil.screenHeight * 0.20,
                left: 0,
                right: 0,
                child: Opacity(
                  opacity: 0.2,
                  child: Center(
                    child: Image.asset(
                      'assets/images/homepage_bg.png',
                      width: ScaledSizeUtil.screenWidth * 0.8,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              Center(
                child: SizedBox(
                  width: ScaledSizeUtil.screenWidth * 0.8,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.center,
                    child: Text(
                      "No habitats yet, Scan or Edit to get started!",
                      maxLines: 1,
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 1.25.rem,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
