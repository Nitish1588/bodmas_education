import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'carousel_model.dart';

class PremiumCarouselWidget extends StatefulWidget {
  final List<CarouselModel> data;

  const PremiumCarouselWidget({super.key, required this.data});

  @override
  State<PremiumCarouselWidget> createState() => _PremiumCarouselWidgetState();
}

class _PremiumCarouselWidgetState extends State<PremiumCarouselWidget> {
  int currentIndex = 0;

  Future<void> _openUrl(String? url) async {
    if (url == null || url.isEmpty) return;

    final uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 0.15;
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: widget.data.length,
          options: CarouselOptions(
            //height: 120,
            height: height,
            autoPlay: true,
            enlargeCenterPage: true,
            viewportFraction: 0.98,
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            onPageChanged: (index, reason) {
              setState(() {
                currentIndex = index;
              });
            },
          ),
          itemBuilder: (context, index, realIndex) {
            final item = widget.data[index];

            return GestureDetector(
              onTap: () => _openUrl(item.buttonUrl),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: .15),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Blurred Background
                      CachedNetworkImage(imageUrl: item.image, fit: BoxFit.cover),

                      // Dark overlay
                      Container(color: Colors.black.withValues(alpha: 0.30)),

                      // Main Full Image
                      CachedNetworkImage(
                        imageUrl: item.image,
                        fit: BoxFit.contain, // full image visible
                        placeholder: (context, url) => Container(
                          color: Colors.grey.shade300,
                          child: const Center(child: CircularProgressIndicator()),
                        ),
                        errorWidget: (context, url, error) =>
                        const Icon(Icons.broken_image),
                      ),
                    ],
                  ),
                ),

                // child: ClipRRect(
                //   borderRadius: BorderRadius.circular(15),
                //   child: CachedNetworkImage(
                //     imageUrl: item.image,
                //     fit: BoxFit.fitHeight,
                //     placeholder: (context, url) =>
                //         const Center(child: CircularProgressIndicator()),
                //     errorWidget: (context, url, error) =>
                //         const Icon(Icons.broken_image),
                //   ),
                // ),
              ),
            );
          },
        ),

        const SizedBox(height: 8),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.data.asMap().entries.map((entry) {
            final isActive = currentIndex == entry.key;

            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: isActive ? 10 : 6,
              height: 6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: isActive ? Colors.black : Colors.grey.shade400,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
