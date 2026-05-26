import 'package:bodmas_education/meeting/payment_screen.dart';
import 'package:bodmas_education/widgets/app_snackbar.dart';
import 'package:flutter/material.dart';
import '../env.dart';
import 'field_widget.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'meeting_model.dart';

class MeetingFormScreen extends StatefulWidget {
  const MeetingFormScreen({super.key});

  @override
  State<MeetingFormScreen> createState() => _MeetingFormScreenState();
}

class _MeetingFormScreenState extends State<MeetingFormScreen> {

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final queryController = TextEditingController();
  final rankController = TextEditingController();


  String? selectedMode;
  String? selectedCourse;

  List<CourseModel> allCourses = [];
  List<CourseModel> filteredCourses = [];
  CourseModel? selectedCourseObj;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchCourses();
  }

  Future<void> fetchCourses() async {
    setState(() => isLoading = true);

    final response = await http.get(
      Uri.parse("${Env.baseUrl}/courses"),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      List list = data['data'];

      allCourses = list.map((e) => CourseModel.fromJson(e)).toList();
    }

    setState(() => isLoading = false);
  }

  bool isExpanded = false;



  DateTime? selectedDate;
  String? selectedTimeSlot;

  List<TimeSlotModel> allSlots = [];
  List<TimeSlotModel> availableSlots = [];
  TimeSlotModel? selectedSlot;

  bool isSlotLoading = false;

  Future<void> fetchTimeSlots(String date) async {
    setState(() => isSlotLoading = true);

    final response = await http.get(
      Uri.parse("${Env.baseUrl}/time-slots?date=$date"),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      List list = data['data'];

      allSlots = list.map((e) => TimeSlotModel.fromJson(e)).toList();

      // Only available slots
      availableSlots =
          allSlots.where((slot) => slot.status == "available").toList();
    }

    setState(() => isSlotLoading = false);
  }

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
        selectedSlot = null;
      });

      // 👉 format: YYYY-MM-DD
      String formattedDate =
          "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";

      await fetchTimeSlots(formattedDate);
    }
  }

  Future<void> createBooking() async {

    // ✅ validation
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        phoneController.text.isEmpty ||
        selectedCourseObj == null ||
        selectedSlot == null ||
        selectedDate == null ||
        selectedMode == null) {

      AppSnackBar.show(context, message: "Please fill all required fields",type: SnackBarType.warning);

      return;
    }

    String formattedDate =
        "${selectedDate!.year}-${selectedDate!.month.toString().padLeft(2, '0')}-${selectedDate!.day.toString().padLeft(2, '0')}";

    final body = {
      "type": selectedMode == "Online" ? "1" : "2",
      "user": nameController.text,
      "number": phoneController.text,
      "email": emailController.text,
      "course_id": selectedCourseObj!.id.toString(),
      "date": formattedDate,
      "time_slot_id": selectedSlot!.id.toString(),
      "user-id": "2",
      "price": selectedCourseObj!.price.toString(),
    };

    final response = await http.post(
      Uri.parse("${Env.baseUrl}/booking/create"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );

    // final data = json.decode(response.body);
    debugPrint("📥 RAW RESPONSE:");
    debugPrint(response.body);

    debugPrint("📥 STATUS CODE: ${response.statusCode}");

    if (response.statusCode != 200) {
      debugPrint("❌ SERVER ERROR");
      return;
    }

    if (!response.body.trim().startsWith("{")) {
      debugPrint("❌ NOT JSON RESPONSE");
      return;
    }

    final data = json.decode(response.body);

    if (data['status'] == true) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => PaymentScreen(
            bookingId: data['data']['booking_id'],
            orderId: data['data']['razorpay_order_id'],
            amount: data['data']['amount'],
            name: nameController.text,
            email: emailController.text,
            phone: phoneController.text,
          ),
        ),
      );
    } else {

      AppSnackBar.show(context, message: data['message'],type: SnackBarType.error);

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
                  inputField("Name", Icons.person,controller: nameController),

                  const SizedBox(height: 5),

                  inputField("Email", Icons.email,controller: emailController,keyboardType: TextInputType.emailAddress),

                  const SizedBox(height: 5),

                  /// 📞 Phone + Mode
                  inputField("Number", Icons.phone,controller: phoneController,keyboardType: TextInputType.number),
                  const SizedBox(height: 5),
                  dropdownField(
                    label: "Mode",
                    value: selectedMode,
                    items: ["Online", "Offline"],
                    onChanged: (val) {
                      setState(() {


                        selectedMode = val;
                        selectedCourse = null;
                        selectedCourseObj = null;

                        int type = val == "Online" ? 1 : 2;

                        filteredCourses =
                            allCourses.where((course) => course.type == type).toList();
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
                      items: filteredCourses
                          .map((e) => "${e.name} - ₹${e.price}")
                          .toList(),
                      onChanged: (val) {
                        setState(() {
                          selectedCourse = val;

                          selectedCourseObj = filteredCourses.firstWhere(
                                (e) => "${e.name} - ₹${e.price}" == val,
                          );
                        });
                      },
                    ),
                  ),

                  if (selectedCourseObj != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),


                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                selectedCourseObj!.name,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              "₹${selectedCourseObj!.price}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),

                        Text(
                          "Description",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5),


                        Text(
                          isExpanded
                              ? selectedCourseObj!.description
                              .replaceAll("\r\n\r\n\r\n", "\n")
                              .replaceAll("\r\n\r\n", "\n")
                              : selectedCourseObj!.description
                              .replaceAll("\r\n\r\n\r\n", "\n")
                              .replaceAll("\r\n\r\n", "\n")
                              .length >120
                              ? "${selectedCourseObj!.description
                              .replaceAll("\r\n\r\n\r\n", "\n")
                              .replaceAll("\r\n\r\n", "\n")
                              .substring(0, 120)}..."
                              : selectedCourseObj!.description
                              .replaceAll("\r\n\r\n\r\n", "\n")
                              .replaceAll("\r\n\r\n", "\n"),
                        ),

                        GestureDetector(
                          onTap: () {
                            setState(() => isExpanded = !isExpanded);
                          },
                          child: Text(
                            isExpanded ? "Read Less" : "Read More",
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 5),

                  inputField("Rank/Score", Icons.star,keyboardType: TextInputType.datetime, controller: rankController),

                  const SizedBox(height: 5),

                  Row(
                    children: [

                      /// 📅 Date Picker
                      Expanded(
                        child: GestureDetector(
                          onTap: pickDate,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
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
                                const Icon(Icons.calendar_today, color: Color(0xFF333333), ),
                                const SizedBox(width: 10),
                                Text(
                                  selectedDate == null
                                      ? "Select Date"
                                      : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
                                  style: TextStyle(
                                   // fontSize: 16,            // 👉 text size
                                    color: Color(0xFF333333),   // 👉 text color
                                   // fontWeight: FontWeight.w400, // optional
                                  ),
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
                          menuMaxHeight: 400,

                          initialValue: selectedSlot?.id.toString(),


                          dropdownColor: Colors.white,
                          elevation: 3,
                          borderRadius: BorderRadius.circular(10),

                          items: availableSlots.map((slot) {
                            return DropdownMenuItem(
                              value: slot.id.toString(),
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "${slot.startTime} - ${slot.endTime}",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                   // fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF333333),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),

                          onChanged: selectedDate == null
                              ? null
                              : (val) {
                            setState(() {
                              selectedSlot = availableSlots.firstWhere(
                                    (slot) => slot.id.toString() == val,
                              );
                            });
                          },

                          decoration: InputDecoration(
                            labelText: "Time Slot",

                            isDense: true, // 👈 height compact

                            contentPadding:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 10),

                            filled: true,
                            fillColor: Colors.grey.shade100,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Color(0xFF333333), width: 2),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Color(0xFF0d6efd), width: 2),
                            ),
                          ),

                          hint: Text(
                            isSlotLoading
                                ? "Loading slots..."
                                : selectedDate == null
                                ? "Select date first"
                                : "Choose time",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              //fontSize: 14,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),

                  const SizedBox(height: 5),

                  /// 📝 Query
                  inputField("Query",controller: queryController, Icons.message, maxLines: 3),

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
                      onPressed: createBooking,
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