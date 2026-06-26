import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class FloatingSocialMenu extends StatefulWidget {
  const FloatingSocialMenu({super.key});

  @override
  State<FloatingSocialMenu> createState() => _FloatingSocialMenuState();
}

class _FloatingSocialMenuState extends State<FloatingSocialMenu>
    with SingleTickerProviderStateMixin {
  bool isOpen = false;

  Future<void> openUrl(String url) async {
    final uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  Widget socialIcon({
    required FaIconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Material(
        elevation: 6,
        borderRadius: BorderRadius.circular(50),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(50),
          child: Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: FaIcon(
                icon,
                color: Colors.white,
                size: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          // Hidden Icons
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: isOpen
                ? Column(
              key: const ValueKey("open"),
              children: [
                socialIcon(
                  icon: FontAwesomeIcons.instagram,
                  color: const Color(0xffE4405F),
                  onTap: () => openUrl(
                      "https://www.instagram.com/bodmasservices/"),
                ),

                socialIcon(
                  icon: FontAwesomeIcons.facebookF,
                  color: const Color(0xff1877F2),
                  onTap: () => openUrl(
                      "https://www.facebook.com/bodmasservices"),
                ),

                socialIcon(
                  icon: FontAwesomeIcons.linkedinIn,
                  color: const Color(0xff0a66c2),
                  onTap: () => openUrl(
                      "https://in.linkedin.com/company/bodmas-education-services"),
                ),
                socialIcon(
                  icon: FontAwesomeIcons.youtube,
                  color: Colors.red,
                  onTap: () => openUrl(
                      "https://www.youtube.com/@BodmasMedical"),
                ),
              ],
            )
                : const SizedBox.shrink(),
          ),

          // Expand Button
          Container(
            margin: const EdgeInsets.only(bottom: 5),
            child: FloatingActionButton.small(
              heroTag: "toggle",
              backgroundColor: Colors.white,
              elevation: 6,
              onPressed: () {
                setState(() {
                  isOpen = !isOpen;
                });
              },
              child: AnimatedRotation(
                turns: isOpen ? 0.5 : 0,
                duration: const Duration(milliseconds: 300),
                child: const Icon(
                  Icons.keyboard_arrow_up_rounded,
                  color: Color(0xFF2563EB),
                  size: 26,
                ),
              ),
            ),
          ),

          // WhatsApp Always Visible
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.green.withValues(alpha: 0.4),
                  blurRadius: 12,
                  spreadRadius: 2,
                )
              ],
            ),
            child: FloatingActionButton(
              heroTag: "whatsapp",
              backgroundColor: const Color(0xff25D366),
              elevation: 10,
              mini: true, // Small size
              onPressed: () {
                openUrl("https://wa.me/919205328794");
              },
              child: const FaIcon(
                FontAwesomeIcons.whatsapp,
                color: Colors.white,
                size: 22,
              ),
            ),
          ),
        ],
      ),
    );
  }
}