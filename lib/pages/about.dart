import 'package:flutter/material.dart';
import 'package:geeco/state/app_state.dart'; // <-- added import

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final photoSize = width * 0.30; // was 0.28 — increase to make photo bigger
    final cardWidth = width * 0.70; // was 0.62
    const cardRadius = 12.0;

    Widget memberCard({
      required String name,
      required String desc,
      required bool photoRight,
      String? imagePath, // ← new param
      bool alignTextRight = false,
    }) {
      final infoCardHeight =
          photoSize * 1; // was 0.78 — increase to make green box TALLER

      final double photoDownOffset = photoSize * 0.40; // move the photo down

      final EdgeInsets infoPadding = alignTextRight
          ? const EdgeInsets.fromLTRB(24, 16, 16, 16)
          : const EdgeInsets.all(16);

      final infoCard = SizedBox(
        width: cardWidth,
        height: infoCardHeight,
        child: Container(
          padding: infoPadding,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 144, 218, 79),
            borderRadius: BorderRadius.circular(cardRadius),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 6,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: alignTextRight
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              Text(
                name,
                textAlign: alignTextRight ? TextAlign.right : TextAlign.left,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                desc,
                textAlign: alignTextRight ? TextAlign.right : TextAlign.left,
                style: const TextStyle(
                  fontSize: 10,
                  color: Color.fromARGB(255, 40, 40, 40),
                ),
              ),
            ],
          ),
        ),
      );

      final photo = ClipRRect(
        borderRadius: BorderRadius.circular(6.0), // small radius
        child: Container(
          width: photoSize,
          height: photoSize,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 6,
                offset: const Offset(0, 4),
              ),
            ],
            image: imagePath != null
                ? DecorationImage(
                    image: AssetImage(imagePath),
                    fit: BoxFit.cover,
                  )
                : null,
          ),
        ),
      );

      // Ensure the Stack has enough width so the photo can overlap the info card.
      final overlapFactor = 0.6;
      final stackWidth = cardWidth + photoSize * overlapFactor;
      final stackHeight = photoSize + photoDownOffset;
      final verticalOffset = (stackHeight - infoCardHeight) / 2;

      final List<Widget> stackChildren = [];

      if (photoRight) {
        stackChildren.add(
          Positioned(left: 0, top: verticalOffset, child: infoCard),
        );
        stackChildren.add(
          Positioned(right: 0, top: photoDownOffset, child: photo),
        );
      } else {
        stackChildren.add(
          Positioned(right: 0, top: verticalOffset, child: infoCard),
        );
        stackChildren.add(
          Positioned(left: 0, top: photoDownOffset, child: photo),
        );
      }

      return SizedBox(
        height: stackHeight,
        child: SizedBox(
          width: stackWidth,
          child: Stack(clipBehavior: Clip.none, children: stackChildren),
        ),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Theme.of(context).colorScheme.surface,
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 180,
                    child: Image.asset(
                      'assets/images/aboutus_bg.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    color: Theme.of(context).colorScheme.surface,
                    padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
                    child: const Text(
                      'About Us',
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 4,
                    ),
                    child: Column(
                      children: [
                        memberCard(
                          name: 'Ghen Benedict M. Namol',
                          desc: 'Frontend Developer & \nTechnical Lead',
                          photoRight: true,
                          imagePath: 'assets/images/ghen.jpg',
                        ),
                        const SizedBox(height: 16),
                        memberCard(
                          name: 'Baxter Gifford B. Bao-As',
                          desc: 'Backend Developer & \nTechnical Lead',
                          photoRight: false,
                          alignTextRight: true,
                          imagePath: 'assets/images/bax.jpg',
                        ),
                        const SizedBox(height: 16),
                        memberCard(
                          name: 'Fabio S. Hascoet',
                          desc:
                              'Lead Designer & \nAssistant Software Developer',
                          photoRight: true,
                          imagePath: 'assets/images/fabio.jpg',
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),

          //floating button at bottom center
          Positioned(
            left: 24,
            right: 24,
            bottom: 24,
            child: SafeArea(
              top: false,
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (Navigator.of(context).canPop()) {
                      Navigator.of(context).pop();
                    } else {
                      // switch to Settings tab (index 3). Adjust index if different.
                      selectedIndexNotifier.value = 3;
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF83BF4F),
                    foregroundColor: Colors.white,
                    elevation: 8,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 28,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    minimumSize: const Size(220, 52),
                  ),
                  child: const Text(
                    'BACK',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.1,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
