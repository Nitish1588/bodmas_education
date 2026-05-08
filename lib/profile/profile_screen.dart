import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../login/login_screen.dart';
import '../login/services/auth_service.dart';
import '../login/services/session.dart';
import '../widgets/app_snackbar.dart';
import 'booking/booked_model.dart';
import 'booking/booking_controller.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  final BookingController bookingController = BookingController();
  List<BookingModel> bookings = [];
  bool isLoading = true;


  @override
  void initState() {
    super.initState();
    loadBookings();
  }

  Future<void> loadBookings() async {
    try {
      bookings = await bookingController.getBookings();
    } catch (e) {
      print("LOAD ERROR: $e");
    }

    /// ALWAYS STOP LOADING
    setState(() {
      isLoading = false;
    });
  }




  Widget buildViewTile(String label, String value, IconData icon) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: Colors.blue),
      title: Text(label),
      subtitle: Text(value),
    );
  }

  /// Purchase Tile UI
  Widget buildBookingCard(BookingModel item) {
    final isOnline = item.type.toLowerCase() == "online";

    Color statusColor =
    item.status == "confirmed"
        ? Colors.green
        : item.status == "pending"
        ? Colors.orange
        : Colors.grey;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          colors: [
            Colors.white,
            Colors.blue.shade50,
          //  Colors.purple.shade50,
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .06),
            blurRadius: 12,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// TOP
          Row(
            children: [

              /// ICON
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF4A90E2),
                      Color(0x344A90E2),
                    ],
                  ),
                ),
                child: const Icon(
                  Icons.school_rounded,
                  color: Colors.white,
                ),
              ),

              const SizedBox(width: 12),

              /// TITLE
              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.course,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          size: 13,
                          color: Colors.grey.shade600,
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            "${item.date} • ${item.time}",
                            maxLines: 2,
                            softWrap: true,
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              /// STATUS
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: .12),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  item.status.toUpperCase(),
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          /// TYPE + PRICE
          Row(
            children: [

              /// TYPE
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    Icon(
                      isOnline
                          ? Icons.wifi
                          : Icons.location_on,
                      size: 15,
                      color: Colors.blue,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      item.type,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              /// PRICE
              Text(
                "₹${item.price}",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF014C04),
                ),
              ),
            ],
          ),

          /// LOCATION
          if (!isOnline) ...[
            const SizedBox(height: 10),

            Row(
              children: [
                Icon(
                  Icons.place,
                  size: 15,
                  color: Colors.orange.shade700,
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: Text(
                    item.location,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
          ],

          /// ZOOM BUTTON
          if (item.zoomLink != null &&
              item.zoomLink!.trim().isNotEmpty) ...[
            const SizedBox(height: 12),

            Align(
              alignment: Alignment.centerRight,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  gradient: const LinearGradient(
                    colors: [
                      Colors.blue,
                      Colors.purple,
                    ],
                  ),
                ),
                child: IconButton(
                  onPressed: () async {
                    final Uri url = Uri.parse(item.zoomLink!);

                    if (await canLaunchUrl(url)) {
                      await launchUrl(
                        url,
                        mode: LaunchMode.externalApplication,
                      );
                    }
                  },
                  icon: const Icon(
                    Icons.videocam,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// 🔥 Top Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF4A90E2), Color(0xFF357ABD)],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: Session.user?["profile_photo"] != null &&
                        Session.user!["profile_photo"].toString().isNotEmpty
                        ? NetworkImage(Session.user!["profile_photo"])
                        : null,
                    child: Session.user?["profile_photo"] == null ||
                        Session.user!["profile_photo"].toString().isEmpty
                        ? Text(
                      (Session.user?["name"] ?? "U")
                          .toString()
                          .substring(0, 1)
                          .toUpperCase(),
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                        : null,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(Session.user?["name"],
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text(Session.user?["number"],
                            style: const TextStyle(color: Colors.white70)),
                        const SizedBox(height: 4),
                        Text(Session.user?["email"],
                            style: const TextStyle(color: Colors.white70)),
                      ],
                    ),
                  )
                ],
              ),
            ),



            /// 🔥 Details Section
            if (
            (Session.user?["address"] ?? "").toString().isNotEmpty ||
                (Session.user?["gender"] ?? "").toString().isNotEmpty ||
                (Session.user?["dob"] ?? "").toString().isNotEmpty
            )
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    )
                  ],
                ),
                child: Column(
                  children: [
                    if ((Session.user?["address"] ?? "")
                        .toString()
                        .isNotEmpty)
                      buildViewTile(
                        "Address",
                        Session.user?["address"],
                        Icons.location_on,
                      ),

                    if ((Session.user?["gender"] ?? "")
                        .toString()
                        .isNotEmpty)
                      buildViewTile(
                        "About",
                        Session.user?["gender"],
                        Icons.info,
                      ),

                    if ((Session.user?["dob"] ?? "")
                        .toString()
                        .isNotEmpty)
                      buildViewTile(
                        "DOB",
                        Session.user?["dob"],
                        Icons.calendar_today,
                      ),
                  ],
                ),
              ),

            const SizedBox(height: 20),

            /// My Purchases Section
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 4))
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("My Bookings",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      TextButton(
                        onPressed: () {},
                        child: const Text("View All"),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : bookings.isEmpty
                      ? const Text("No bookings found")
                      : Column(
                    children: bookings.map((item) {
                      return buildBookingCard(item);
                    }).toList(),
                  )
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// Help & Privacy
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Column(
                children: const [
                  ListTile(
                    leading: Icon(Icons.help_outline),
                    title: Text("Help"),
                  ),
                  Divider(height: 1),
                  ListTile(
                    leading: Icon(Icons.privacy_tip_outlined),
                    title: Text("Privacy Policy"),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// Logout Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {

                  String? token = await Session.getToken();

                  if (token != null) {
                    await AuthService.logout(token);
                  }

                  await Session.clear(); // 🔥 VERY IMPORTANT

                  AppSnackBar.show(context, message: "Log-Out Successfully",
                      type: SnackBarType.success);

                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                        (route) => false,
                  );


                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text("Logout"),
              ),
            ),

            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  print(Session.user);
                  print(Session.user?["id"]);
                  print(Session.user?["name"]);


                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text("demo check"),
              ),
            )
          ],
        ),
      ),
    );
  }
}