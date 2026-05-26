import 'package:bodmas_education/notification/widgets/notification_card.dart';
import 'package:bodmas_education/notification/widgets/notification_skeleton.dart';
import 'package:flutter/material.dart';
import 'notification_service.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late Future<List<dynamic>> futureData;

  int? selectedStateId;

  // ✅ STATES LIST
  final List<Map<String, dynamic>> states = [
    {"id": null, "name": "Select All"},
    {"id": 1, "name": "Andhra Pradesh"},
    {"id": 2, "name": "Arunachal Pradesh"},
    {"id": 3, "name": "Assam"},
    {"id": 4, "name": "Bihar"},
    {"id": 5, "name": "Chhattisgarh"},
    {"id": 6, "name": "Goa"},
    {"id": 7, "name": "Gujarat"},
    {"id": 8, "name": "Haryana"},
    {"id": 9, "name": "Himachal Pradesh"},
    {"id": 10, "name": "Jharkhand"},
    {"id": 11, "name": "Karnataka"},
    {"id": 12, "name": "Kerala"},
    {"id": 13, "name": "Madhya Pradesh"},
    {"id": 14, "name": "Maharashtra"},
    {"id": 15, "name": "Manipur"},
    {"id": 16, "name": "Meghalaya"},
    {"id": 17, "name": "Mizoram"},
    {"id": 18, "name": "Nagaland"},
    {"id": 19, "name": "Odisha"},
    {"id": 20, "name": "Punjab"},
    {"id": 21, "name": "Rajasthan"},
    {"id": 22, "name": "Sikkim"},
    {"id": 23, "name": "Tamil Nadu"},
    {"id": 24, "name": "Telangana"},
    {"id": 25, "name": "Tripura"},
    {"id": 26, "name": "Uttar Pradesh"},
    {"id": 27, "name": "Uttarakhand"},
    {"id": 28, "name": "West Bengal"},
    {"id": 29, "name": "A & N Islands"},
    {"id": 30, "name": "Chandigarh"},
    {"id": 31, "name": "D & N Haveli & D & D"},
    {"id": 32, "name": "Lakshadweep"},
    {"id": 33, "name": "Delhi (GGSIPU)"},
    {"id": 34, "name": "Puducherry"},
    {"id": 35, "name": "AIQ (MCC)"},
    {"id": 36, "name": "DEEMED"},
    {"id": 37, "name": "Jammu & Kashmir"},
    {"id": 38, "name": "Other"},
    {"id": 39, "name": "Josaa"},
    {"id": 40, "name": "Jac Delhi"},
    {"id": 41, "name": "Jac Chandigarh"},
    {"id": 42, "name": "Dasa-CSAB"},
    {"id": 43, "name": "Comed-K"},
    {"id": 44, "name": "BIT-Sat"},
    {"id": 45, "name": "JP"},
  ];

  @override
  void initState() {
    super.initState();
    futureData = NotificationService.fetchNotifications();
  }

  Future<void> refreshNotifications() async {
    setState(() {
      futureData = NotificationService.fetchNotifications();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFDFF),
      appBar: AppBar(
        title: const Text("Notifications"),
        automaticallyImplyLeading: ModalRoute.of(context)?.canPop ?? false,
      ),

      body: FutureBuilder<List<dynamic>>(
        future: futureData,
        builder: (context, snapshot) {
          // 🔥 LOADING
          if (snapshot.connectionState == ConnectionState.waiting) {
            return ListView.builder(
              itemCount: 6,
              // ignore: unnecessary_underscores
              itemBuilder: (_, __) => const NotificationSkeleton(),
            );
          }

          // ❌ ERROR
          if (snapshot.hasError) {
            return const Center(child: Text("Error"));
          }

          // ✅ DATA
          final data = snapshot.data!;

          // 🔥 SORT (latest first)
          data.sort(
            (a, b) => DateTime.parse(
              b['created_at'],
            ).compareTo(DateTime.parse(a['created_at'])),
          );

          // 🔥 FILTER
          final filteredData = selectedStateId == null
              ? data
              : data.where((e) => e['state_id'] == selectedStateId).toList();

          return Column(
            children: [
              // 🔽 DROPDOWN
              Padding(
                padding: const EdgeInsets.all(12),
                child: DropdownButtonFormField<int>(
                  initialValue: selectedStateId,
                  hint: const Text("Select State"),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                  ),
                  items: states.map((state) {
                    return DropdownMenuItem<int>(
                      value: state['id'],
                      child: Text(state['name']),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedStateId = value;
                    });
                  },
                ),
              ),

              // 🔽 LIST
              Expanded(
                child: RefreshIndicator(
                  onRefresh: refreshNotifications,
                  child: ListView.builder(
                    itemCount: filteredData.length,
                    itemBuilder: (context, index) {
                      return NotificationCard(data: filteredData[index]);
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
