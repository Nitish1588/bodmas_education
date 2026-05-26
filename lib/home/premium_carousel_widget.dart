import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PremiumCarouselWidget extends StatefulWidget {
  final List<Map<String, dynamic>> data;
  final String imageKey;

  const PremiumCarouselWidget({
    super.key,
    required this.data,
    this.imageKey = "image",
  });

  @override
  State<PremiumCarouselWidget> createState() => _PremiumCarouselWidgetState();
}

class _PremiumCarouselWidgetState extends State<PremiumCarouselWidget> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 0.15;

    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: widget.data.length,
          options: CarouselOptions(
            //height: 150,
            height: height,
            autoPlay: true,
            enlargeCenterPage: true,
            viewportFraction: 0.98,
            autoPlayCurve: Curves.easeInOut,
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            onPageChanged: (index, reason) {
              setState(() => currentIndex = index);
            },
          ),
          itemBuilder: (context, index, realIndex) {
            final imageUrl = widget.data[index][widget.imageKey];

            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
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
                    CachedNetworkImage(imageUrl: imageUrl, fit: BoxFit.cover),

                    // Dark overlay
                    Container(color: Colors.black.withValues(alpha: 0.25)),

                    // Main Full Image
                    CachedNetworkImage(
                      imageUrl: imageUrl,
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
            );
          },
        ),

        const SizedBox(height: 8),

        // DOT INDICATOR
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
