import 'package:flutter/material.dart';
import '../../widgets/customwebview_screen.dart';

class CounsellingPackageCard extends StatelessWidget {
  final String image;
  final String courseName;
  final String price;
  final String gst;
  final String total;

  /// PAGE ROUTE
  final Widget? page;

  /// EXTERNAL LINK
  final String? link;

  const CounsellingPackageCard({
    super.key,
    required this.image,
    required this.courseName,
    required this.price,
    required this.gst,
    required this.total,

    /// optional
    this.page,
    this.link,
  });

  /// HANDLE BOTH
  Future<void> _handleTap(BuildContext context) async {
    /// OPEN PAGE
    if (page != null) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => page!));
      return;
    }

    /// OPEN LINK
    if (link != null && link!.isNotEmpty) {
      final Uri uri = Uri.parse(link!);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => CustomWebViewScreen(
            url: uri.toString(),
            title: courseName.toUpperCase(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final titleSize = width * .055;
    final priceSize = width * .075;
    final buttonTextSize = width * .045;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .05),
            blurRadius: 25,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// IMAGE
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
            child: Image.asset(
              image,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  courseName.toUpperCase(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: titleSize,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xff111827),
                    height: 1.25,
                  ),
                ),

                const SizedBox(height: 15),

                /// PRICE CARD
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: const LinearGradient(
                      colors: [Color(0xffF8FAFF), Color(0xffEEF3FF)],
                    ),
                    border: Border.all(color: const Color(0xffDCE7FF)),
                  ),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              price,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: priceSize,
                                fontWeight: FontWeight.w800,
                                color: const Color(0xff111827),
                              ),
                            ),
                          ),

                          const SizedBox(width: 10),

                          Flexible(
                            child: Text(
                              "+ GST $gst",
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                color: Colors.grey.shade700,
                                fontSize: width * .034,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      Container(
                        height: 1,
                        color: Colors.blue.withValues(alpha: .08),
                      ),

                      const SizedBox(height: 12),

                      /// TOTAL BOX
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Total Amount",
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontSize: width * .037,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),

                            Flexible(
                              child: Text(
                                total,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: const Color(0xff2457FF),
                                  fontWeight: FontWeight.w800,
                                  fontSize: width * .055,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 15),

                /// BUTTON
                InkWell(
                  onTap: () => _handleTap(context),
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: const LinearGradient(
                        colors: [Color(0xff2B65FF), Color(0xff1440D8)],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xff2457FF).withValues(alpha: .35),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            "Book Now",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: buttonTextSize,
                            ),
                          ),
                        ),

                        const SizedBox(width: 8),

                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: .18),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.arrow_forward_rounded,
                            color: Colors.white,
                            size: 18,
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
    );
  }
}
