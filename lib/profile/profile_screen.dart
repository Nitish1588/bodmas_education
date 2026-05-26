import 'package:bodmas_education/counsellingguidance/counsellingguidance_screen.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../cutoff/model/purchased_cutoff_model.dart';
import '../cutoff/service/purchased_cutoff_service.dart';
import '../cutoff/widgets/purchased_cutoff_card.dart';
import '../login/login_screen.dart';
import '../login/services/auth_service.dart';
import '../login/services/session.dart';
import '../widgets/app_snackbar.dart';
import 'booking/booked_model.dart';
import 'booking/booking_controller.dart';
import 'package:intl/intl.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final BookingController bookingController = BookingController();
  List<BookingModel> bookings = [];
  bool isLoading = true;

  List<PurchasedCutoffModel> purchasedCutoffs = [];

  bool isCutoffLoading = true;

  @override
  void initState() {
    super.initState();
    loadBookings();
    loadPurchasedCutoffs();
  }

  Future<void> loadBookings() async {
    setState(() {
      isLoading = true;
    });

    try {
      bookings = await bookingController.getBookings();
    } catch (e) {
      print("LOAD ERROR: $e");
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<void> loadPurchasedCutoffs() async {
    try {
      final token = await Session.getToken();

      if (token == null) return;

      final data = await PurchasedCutoffService().getPurchasedCutoffs(
        token: token,
      );

      setState(() {
        purchasedCutoffs = data;
      });
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isCutoffLoading = false;
      });
    }
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

    Color statusColor = item.status == "confirmed"
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
          ),
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
                    colors: [Color(0xFF4A90E2), Color(0x344A90E2)],
                  ),
                ),
                child: const Icon(Icons.school_rounded, color: Colors.white),
              ),

              const SizedBox(width: 12),

              /// TITLE
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                          color: Colors.blue,
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            "Booked on: ${DateFormat('dd/MMM/yy').format(DateTime.parse(item.createdAt).toLocal())}",
                            style: const TextStyle(
                              fontSize: 11,
                              color: Colors.black54,
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

          const SizedBox(height: 10),
          Row(
            children: [
              /// LEFT SIDE (must shrink)
              Expanded(
                child: Row(
                  children: [
                    const Icon(Icons.access_time, size: 15, color: Colors.blue),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        "Time Slot: ${item.date} • ${item.time}",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),

              //const SizedBox(width: 8),
              //const Spacer(),

              /// RIGHT CHIP
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isOnline ? Icons.wifi : Icons.location_on,
                      size: 15,
                      color: Colors.blue,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      item.type,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          /// LOCATION
          if (!isOnline) ...[
            const SizedBox(height: 10),

            Row(
              children: [
                Icon(Icons.place, size: 15, color: Colors.orange.shade700),
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
          if (item.zoomLink != null && item.zoomLink!.trim().isNotEmpty) ...[
            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Join Now:-",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: const LinearGradient(
                        colors: [Colors.blue, Colors.purple],
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
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Future<void> _refreshData() async {
    setState(() {
      isLoading = true;
      isCutoffLoading = true;
    });

    await Future.wait([loadBookings(), loadPurchasedCutoffs()]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFDFF),
      appBar: AppBar(title: const Text("Profile")),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
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
                      backgroundImage:
                          Session.user?["profile_photo"] != null &&
                              Session.user!["profile_photo"]
                                  .toString()
                                  .isNotEmpty
                          ? NetworkImage(Session.user!["profile_photo"])
                          : null,
                      child:
                          Session.user?["profile_photo"] == null ||
                              Session.user!["profile_photo"].toString().isEmpty
                          ? Text(
                              (Session.user?["name"] ?? "U")
                                  .toString()
                                  .substring(0, 2)
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
                          Text(
                            Session.user?["name"],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            Session.user?["number"],
                            style: const TextStyle(color: Colors.white70),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            Session.user?["email"],
                            style: const TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              /// 🔥 Details Section
              if ((Session.user?["address"] ?? "").toString().isNotEmpty ||
                  (Session.user?["gender"] ?? "").toString().isNotEmpty ||
                  (Session.user?["dob"] ?? "").toString().isNotEmpty)
                Container(
                  margin: const EdgeInsets.only(top: 15),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
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

                      if ((Session.user?["gender"] ?? "").toString().isNotEmpty)
                        buildViewTile(
                          "About",
                          Session.user?["gender"],
                          Icons.info,
                        ),

                      if ((Session.user?["dob"] ?? "").toString().isNotEmpty)
                        buildViewTile(
                          "DOB",
                          Session.user?["dob"],
                          Icons.calendar_today,
                        ),
                    ],
                  ),
                ),

              // const SizedBox(height: 16),
              //   Container(
              //     padding: const EdgeInsets.all(16),
              //     decoration: BoxDecoration(
              //       color: Colors.white,
              //       borderRadius: BorderRadius.circular(16),
              //       boxShadow: const [
              //         BoxShadow(
              //           color: Colors.black12,
              //           blurRadius: 10,
              //           offset: Offset(0, 4),
              //         )
              //       ],
              //     ),
              //     child: Column(
              //       children: [
              //
              //           buildViewTile("Address", Session.user?["address"]?? "Not Available"  , Icons.location_on,),
              //
              //
              //           buildViewTile("About",Session.user?["gender"] ?? "Not Available",Icons.info,),
              //
              //
              //           buildViewTile("DOB",Session.user?["dob"] ?? "Not Available",Icons.calendar_today,),
              //       ],
              //     ),
              //   ),
              const SizedBox(height: 20),

              /// My Purchases Section
              Container(
                height: 420,
                padding: const EdgeInsets.fromLTRB(12, 15, 12, 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFFE0ECFF),
                      Color(0xFFD4E4FF),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withValues(alpha: 0.08),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: DefaultTabController(
                  length: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Top Heading
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: const LinearGradient(
                                colors: [Color(0xff5B86E5), Color(0xff36D1DC)],
                              ),
                            ),
                            child: const Icon(
                              Icons.shopping_bag_rounded,
                              color: Colors.white,
                              size: 22,
                            ),
                          ),

                          const SizedBox(width: 12),

                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "My Purchases",
                                style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.3,
                                ),
                              ),

                              SizedBox(height: 1),

                              Text(
                                "Meetings & Premium Cutoffs",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      /// Modern Tabs
                      Container(
                        height: 55,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.grey.shade200),
                        ),
                        child: TabBar(
                          indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            gradient: const LinearGradient(
                              colors: [Color(0xff5B86E5), Color(0xff36D1DC)],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blue.withValues(alpha: 0.25),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          dividerColor: Colors.transparent,
                          labelColor: Colors.white,
                          unselectedLabelColor: Colors.black87,
                          labelStyle: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                          tabs: const [
                            /// Meetings Tab
                            Tab(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.video_call_rounded, size: 18),
                                  SizedBox(width: 6),
                                  Text("Meetings"),
                                ],
                              ),
                            ),

                            /// Cutoff Tab
                            Tab(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.workspace_premium_rounded,
                                    size: 18,
                                  ),
                                  SizedBox(width: 6),
                                  Text("Cutoff"),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 12),

                      /// Views
                      Expanded(
                        child: TabBarView(
                          children: [
                            /// Meetings
                            isLoading
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : bookings.isEmpty
                                ? const Center(child: Text("No bookings found"))
                                : Scrollbar(
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: bookings.map((item) {
                                          return buildBookingCard(item);
                                        }).toList(),
                                      ),
                                    ),
                                  ),

                            /// Cutoff
                            Scrollbar(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    /// Premium Cutoff Card
                                    isCutoffLoading
                                        ? const Center(
                                            child: CircularProgressIndicator(),
                                          )
                                        : purchasedCutoffs.isEmpty
                                        ? const Center(
                                            child: Text("No cutoff purchased"),
                                          )
                                        : Scrollbar(
                                            child: SingleChildScrollView(
                                              child: Column(
                                                children: purchasedCutoffs.map((
                                                  item,
                                                ) {
                                                  return PurchasedCutoffCard(
                                                    item: item,

                                                    token: Session.token ?? '',

                                                    downloadUrl:
                                                        PurchasedCutoffService()
                                                            .downloadUrl(
                                                              item.packageId,
                                                            ),
                                                  );
                                                }).toList(),
                                              ),
                                            ),
                                          ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),

              /// Help & Privacy
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
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

              const SizedBox(height: 15),

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

                    AppSnackBar.show(
                      context,
                      message: "Log-Out Successfully",
                      type: SnackBarType.success,
                    );

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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CounsellingGuidanceScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text("demo check"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
