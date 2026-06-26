import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import '../notification/notification_service.dart';
import '../widgets/rotating_waves.dart';

class QuickNotificationSection extends StatefulWidget {
  final VoidCallback? onViewAll;

  const QuickNotificationSection({super.key, this.onViewAll});

  @override
  State<QuickNotificationSection> createState() =>
      _QuickNotificationSectionState();
}

class _QuickNotificationSectionState extends State<QuickNotificationSection> {
  final ScrollController _scrollController = ScrollController();

  List<dynamic> notifications = [];

  Timer? autoScrollTimer;

  bool isUserScrolling = false;
  bool isLoading = true;
  bool hasError = false;
  String errorMessage = "";
  @override
  void initState() {
    super.initState();

    fetchNotifications();

    _scrollController.addListener(() {
      /// user manually scroll
      if (_scrollController.position.isScrollingNotifier.value) {
        pauseAutoScroll();
      }
    });
  }

  Future<void> downloadAndOpenPDF(String url) async {
    try {
      final dir = await getTemporaryDirectory();

      final filePath = "${dir.path}/${url.split('/').last}";

      await Dio().download(url, filePath);

      await OpenFile.open(filePath);
    } catch (e) {
      debugPrint("PDF Error: $e");
    }
  }

  Future<void> fetchNotifications() async {
    try {
      setState(() {
        isLoading = true;
        hasError = false;
        errorMessage = "";
      });

      final data = await NotificationService.fetchNotifications();

      data.sort((a, b) {
        return DateTime.parse(
          b['created_at'],
        ).compareTo(DateTime.parse(a['created_at']));
      });

      if (mounted) {
        setState(() {
          notifications = data;
          isLoading = false;
        });

        startAutoScroll();
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          isLoading = false;
          hasError = true;
          errorMessage = "No internet connection or server error";
        });
      }
    }
  }

  /// AUTO SCROLL
  void startAutoScroll() {
    autoScrollTimer?.cancel();

    autoScrollTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (!_scrollController.hasClients) return;

      if (isUserScrolling) return;

      double current = _scrollController.offset;

      double max = _scrollController.position.maxScrollExtent;

      double next = current + 70;

      if (next >= max) {
        next = 0;
      }

      _scrollController.animateTo(
        next,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOut,
      );
    });
  }

  /// USER SCROLL HANDLE
  void pauseAutoScroll() {
    isUserScrolling = true;

    Future.delayed(const Duration(seconds: 3), () {
      isUserScrolling = false;
    });
  }

  @override
  void dispose() {
    autoScrollTimer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const SizedBox(
        height: 160,
        child: Center(
          child: RotatingWaves(
            size: 150,
            color: Colors.lightBlue,
            centered: true,
          ),
        ),
      );
    }
    if (hasError) {
      return SizedBox(
        height: 160,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.wifi_off, size: 40, color: Colors.grey),
              const SizedBox(height: 10),
              const Text(
                "You're offline",
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 5),
              Text(
                errorMessage,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: fetchNotifications,
                child: const Text("Retry"),
              ),
            ],
          ),
        ),
      );
    }
    if (notifications.isEmpty) {
      return const SizedBox();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// HEADER
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(11),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Colors.blue.shade700, Colors.indigo.shade500],
                  ),
                  boxShadow: [
                    BoxShadow(color: Colors.blue.shade200, blurRadius: 12),
                  ],
                ),
                child: const Icon(
                  Icons.notifications_active_outlined,
                  color: Colors.white,
                  size: 20,
                ),
              ),

              const SizedBox(width: 15),

              const Expanded(
                child: Text(
                  "Notifications",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                ),
              ),

              InkWell(
                borderRadius: BorderRadius.circular(30),
                onTap: widget.onViewAll,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.blue.shade50,
                  ),
                  child: Text(
                    "View All",
                    style: TextStyle(
                      color: Colors.blue.shade700,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),

          /// NOTIFICATION LIST
          SizedBox(
            height: 160,
            child: NotificationListener<UserScrollNotification>(
              onNotification: (notification) {
                if (notification.direction != ScrollDirection.idle) {
                  pauseAutoScroll();
                }

                return true;
              },

              child: ListView.builder(
                controller: _scrollController,

                physics: const BouncingScrollPhysics(),

                itemCount: notifications.length,

                itemBuilder: (context, index) {
                  final item = notifications[index];

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 0),

                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// TIMELINE
                        Column(
                          children: [
                            Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.blue.shade700,
                              ),
                            ),

                            Container(
                              width: 1.5,
                              height: 58,
                              color: Colors.grey.shade300,
                            ),
                          ],
                        ),

                        const SizedBox(width: 14),

                        /// CARD
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 12,
                            ),

                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),

                              gradient: LinearGradient(
                                colors: [Colors.white, Colors.blue.shade50],
                              ),

                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),

                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    item['title'] ?? "",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      height: 1.4,
                                    ),
                                  ),
                                ),

                                const SizedBox(width: 10),
                                if (item['file'] != null &&
                                    item['file'].toString().isNotEmpty)
                                  InkWell(
                                    onTap: () {
                                      final pdfUrl =
                                          "https://bodmaseducation.com/storage/notices/${item['file']}";

                                      downloadAndOpenPDF(pdfUrl);
                                    },

                                    borderRadius: BorderRadius.circular(20),

                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 6,
                                      ),

                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),

                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.blue.shade600,
                                            Colors.blue.shade600,
                                            // Colors.indigo.shade500,
                                          ],
                                        ),
                                      ),

                                      child: const Row(
                                        mainAxisSize: MainAxisSize.min,

                                        children: [
                                          Text(
                                            "View",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 11,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                // Container(
                                //   padding: const EdgeInsets.symmetric(
                                //     horizontal: 12,
                                //     vertical: 6,
                                //   ),
                                //   decoration: BoxDecoration(
                                //     borderRadius: BorderRadius.circular(20),
                                //     color: Colors.blue.shade100,
                                //   ),
                                //   child: Text(
                                //     "View",
                                //     style: TextStyle(
                                //       color: Colors.blue.shade800,
                                //       fontSize: 11,
                                //       fontWeight: FontWeight.w700,
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
