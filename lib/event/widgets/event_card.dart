import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../event_service.dart';


class EventCard extends StatelessWidget {
  final Map event;

  const EventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    String date = "";

    if (event["created_at"] != null) {
      DateTime dt = DateTime.parse(event["created_at"]);
      date = DateFormat("dd MMM yy").format(dt);
    }
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withAlpha(30),
            blurRadius: 10,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // IMAGE
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(16),
            ),
            child: Image.network(
              EventService.imageBase + event['image_url'],
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          // TEXT CONTENT
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event['title'],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F172A),
                  ),
                ),

                const SizedBox(height: 6),

                Row(
                  children: [
                    const Icon(Icons.location_on,
                        size: 16, color: Color(0xFF4C81F4)),
                    const SizedBox(width: 4),
                    Text(
                      event['location'],
                      style: const TextStyle(color: Colors.black54),
                    ),

                    const SizedBox(width: 20),
                    const Icon(Icons.date_range,
                        size: 16, color: Color(0xFF4C81F4)),
                    const SizedBox(width: 4),
                    Text(
                      date,
                      style: const TextStyle(color: Colors.black54),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                Text(
                  event['description'],
                  style: const TextStyle(color: Colors.black87),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}