import 'package:bodmas_education/event/widgets/event_card.dart';
import 'package:bodmas_education/event/widgets/event_card_skeleton.dart' show EventCardSkeleton;
import 'package:flutter/material.dart';
import 'event_service.dart';


class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  late Future<List<dynamic>> futureEvents;

  @override
  void initState() {
    super.initState();
    futureEvents = EventService.fetchEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Events")),
      backgroundColor: Colors.white,

      body: FutureBuilder<List<dynamic>>(
        future: futureEvents,
        builder: (context, snapshot) {

          // 🔥 LOADING → SHOW SKELETON
          if (snapshot.connectionState == ConnectionState.waiting) {
            return ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: 6, // number of skeleton cards
              itemBuilder: (context, index) {
                return const EventCardSkeleton();
              },
            );
          }

          // ❌ ERROR
          if (snapshot.hasError) {
            return const Center(child: Text("Error loading events"));
          }

          // ✅ DATA
          final events = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: events.length,
            itemBuilder: (context, index) {
              return EventCard(event: events[index]);
            },
          );
        },
      ),
    );
  }
}