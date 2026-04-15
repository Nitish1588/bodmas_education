import 'package:flutter/material.dart';
import 'field_widget.dart';

class MeetingFormScreen extends StatefulWidget {
  const MeetingFormScreen({super.key});

  @override
  State<MeetingFormScreen> createState() => _MeetingFormScreenState();
}

class _MeetingFormScreenState extends State<MeetingFormScreen> {
  String? selectedMode;
  String? selectedCourse;

  final Map<String, List<Map<String, dynamic>>> courseData = {
    "Online": [
      {"title": "BDS | BAMS | BUMS | BHMS | Veterinary", "price": 1000},
      {"title": "MBBS", "price": 1000},
      {"title": "MD | MS | DNB", "price": 1000},
      {"title": "B.Tech | M.Tech | Polytechnic", "price": 1000},
      {"title": "MBBS ABROAD", "price": 1000},
      {"title": "BBA | BMS | BBA+MBA | BA LLB | BBA LLB", "price": 1000},
      {"title": "MDS & AIAPGET", "price": 1000},
    ],
    "Offline": [
      {"title": "MBBS", "price": 1500},
      {"title": "Ayush | Dental | Engineering | Law & Management", "price": 1000},
      {"title": "MD/MS", "price": 1500},
    ],
  };
  DateTime? selectedDate;
  String? selectedTimeSlot;

  final List<String> timeSlots = [
    "08:00 AM",
    "09:00 AM",
    "10:00 AM",
    "11:00 AM",
    "12:00 PM",
    "01:00 PM",
    "02:00 PM",
    "02:00 PM",
    "04:00 PM",
    "05:00 PM",
    "06:00 PM",
  ];

  Future<void> pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2035),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
        selectedTimeSlot = null; // reset time
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      appBar: AppBar(
        title: const Text("Book Meeting"),
        //backgroundColor: const Color(0xFF2563EB),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Title
            Text(
              "Book Your Meeting with Ashok Sir",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3B82F6),
              ),
            ),
            SizedBox(height: 3),
            // Subtitle
            Text(
              "If you face any issues during the booking, Contact On: 8448847836",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, color: Colors.black54),
            ),
            SizedBox(height: 10),
            /// 🔹 Card Container (Main UI)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(color: Colors.black12, blurRadius: 10)
                ],
              ),
              child: Column(
                children: [

                  /// 👤 Name + Email
                  inputField("Name", Icons.person),

                  const SizedBox(height: 5),

                  inputField("Email", Icons.email,keyboardType: TextInputType.emailAddress),

                  const SizedBox(height: 5),

                  /// 📞 Phone + Mode
                  inputField("Number", Icons.phone,keyboardType: TextInputType.number),
                  const SizedBox(height: 5),
                  dropdownField(
                    label: "Mode",
                    value: selectedMode,
                    items: ["Online", "Offline"],
                    onChanged: (val) {
                      setState(() {
                        selectedMode = val;
                        selectedCourse = null;
                      });
                    },
                  ),

                  const SizedBox(height: 5),

                  /// 📚 Course + Rank
                  SizedBox(
                    width: double.infinity,
                    child: dropdownField(
                      label: "Course",
                      value: selectedCourse,
                      items: selectedMode == null
                          ? []
                          : courseData[selectedMode!]!
                          .map((e) =>
                      "${e['title']} - ₹${e['price']}")
                          .toList(),
                      onChanged: (val) {
                        setState(() => selectedCourse = val);
                      },
                    ),
                  ),
                  const SizedBox(height: 5),
                  inputField("Rank/Score", Icons.star,keyboardType: TextInputType.datetime),

                  const SizedBox(height: 5),

                  Row(
                    children: [

                      /// 📅 Date Picker
                      Expanded(
                        child: GestureDetector(
                          onTap: pickDate,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                            decoration: BoxDecoration(

                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(10), // match the InputDecoration borderRadius
                              border: Border.all(
                                color: Color(0xFF333333), // same as enabledBorder color
                                width: 2,                  // match border width
                              ),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.calendar_today),
                                const SizedBox(width: 10),
                                Text(
                                  selectedDate == null
                                      ? "Select Date"
                                      : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 10),

                      /// ⏰ Time Slot Dropdown
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          isExpanded: true,
                          initialValue: selectedTimeSlot,
                          items: timeSlots
                              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                              .toList(),
                          onChanged: selectedDate == null
                              ? null
                              : (val) {
                            setState(() {
                              selectedTimeSlot = val;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: "Time Slot",

                            filled: true,
                            fillColor: Colors.grey.shade100,

                            contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),

                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Color(0xFF333333), width: 2),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Color(0xFF0d6efd), width: 2),
                            ),

                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          hint: Text(
                            selectedDate == null
                                ? "Select date first"
                                : "Choose time",
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),

                  /// 📝 Query
                  inputField("Query", Icons.message, maxLines: 3),

                  const SizedBox(height: 20),

                  /// 💳 Button
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF2563EB), Color(0xFF1D4ED8)],
                      ),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      onPressed: () {},
                      child: const Text(
                        "Proceed to Payment",
                        style: TextStyle(fontSize: 16,
                        color: Color(0xFFFFFFFF),),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}