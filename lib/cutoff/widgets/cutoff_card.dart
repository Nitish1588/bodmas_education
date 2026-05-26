import 'package:flutter/material.dart';
import '../../env.dart';
import '../model/cutoff_model.dart';

class CutoffCard extends StatefulWidget {

  final CutoffModel cutoff;
  final bool expanded;
  final VoidCallback onToggle;
  final VoidCallback onPay;

  const CutoffCard({
    super.key,
    required this.cutoff,
    required this.expanded,
    required this.onToggle,
    required this.onPay,
  });

  @override
  State<CutoffCard> createState() => _CutoffCardState();
}

class _CutoffCardState extends State<CutoffCard>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;

  late Animation<double> _animation;

  bool get isNew {

    try {

      final createdDate =
      DateTime.parse(widget.cutoff.createdAt);

      final difference =
      DateTime.now().difference(createdDate);

      return difference.inDays <= 30;

    } catch (e) {

      return false;
    }
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    )..repeat(reverse: true);

    _animation = Tween<double>(
      begin: 0.4,
      end: 1,
    ).animate(_controller);
  }

  @override
  void dispose() {

    _controller.dispose();

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),

        gradient: const LinearGradient(
          colors: [
            Color(0xFFF5FCFF),
            Colors.white,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),

        boxShadow: [
          BoxShadow(
            color: Colors.blue.withValues(alpha: 0.08),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// IMAGE SECTION
          Stack(
            children: [

              /// IMAGE
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),

                child: Image.network(
                  "${Env.imgCutoff}/${widget.cutoff.image}",
                  width: double.infinity,
                 // height: 220,
                  fit: BoxFit.fitHeight,

                  // Loading Widget
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;

                    return Container(
                      width: double.infinity,
                      height: 220,
                      color: Colors.grey.shade200,
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            strokeWidth: 2,
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "Loading image...",
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    );
                  },

                  // Error Handling
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: double.infinity,
                      height: 220,
                      color: Colors.grey.shade200,
                      padding: const EdgeInsets.all(16),
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.wifi_off_rounded,
                            size: 40,
                            color: Colors.grey.shade700,
                          ),

                          const SizedBox(height: 12),

                          Text(
                            "Image could not be loaded",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade800,
                            ),
                          ),

                          const SizedBox(height: 6),

                          Text(
                            "Check your internet connection\nor try again later.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),


              /// PRICE BADGE
              Positioned(
                top: 12,
                right: 12,

                child: Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Color(0xFFBFF2FF),
                    borderRadius: BorderRadius.circular(20),

                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.08),
                        blurRadius: 8,
                      ),
                    ],
                  ),

                  child: Text(
                    "ONLY ₹${widget.cutoff.salePrice}",

                    style: const TextStyle(

                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),

              /// NEW BADGE
              if (isNew)
                Positioned(
                  top: 12,
                  left: 12,

                  child: FadeTransition(
                    opacity: _animation,

                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 7,
                      ),

                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFFFF1744),
                            Color(0xFFFF5252),
                          ],
                        ),

                        borderRadius: BorderRadius.circular(30),

                        boxShadow: [
                          BoxShadow(
                            color: Colors.red.withValues(alpha: 0.4),
                            blurRadius: 12,
                            spreadRadius: 1,
                          ),
                        ],
                      ),

                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [

                          Icon(
                            Icons.local_fire_department,
                            color: Colors.white,
                            size: 16,
                          ),

                          SizedBox(width: 4),

                          Text(
                            "NEW",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),

          /// CONTENT
          Padding(
            padding: const EdgeInsets.all(12),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// TITLE
                Text(
                  widget.cutoff.productName,

                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2663E9),
                    height: 1.2,
                  ),
                ),

                const SizedBox(height: 4),

                /// PRICE ROW
                Row(
                  children: [

                    Text(
                      "₹${widget.cutoff.regularPrice}",

                      style: const TextStyle(
                        color: Colors.red,
                        decoration: TextDecoration.lineThrough,
                        fontSize: 13,
                      ),
                    ),

                    const SizedBox(width: 10),

                    Text(
                      "₹${widget.cutoff.salePrice}",

                      style: const TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 2),

                /// DESCRIPTION
                AnimatedCrossFade(
                  firstChild: const SizedBox(),

                  secondChild: Text(
                    widget.cutoff.description,

                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      height: 1.4,
                    ),
                  ),

                  crossFadeState: widget.expanded
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,

                  duration: const Duration(milliseconds: 300),
                ),

                const SizedBox(height: 12),

                /// BUTTONS
                Row(
                  children: [

                    Expanded(
                      child: _button(
                        text: widget.expanded
                            ? "Hide Details"
                            : "View Details",

                        onPressed: widget.onToggle,
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: _button(
                        text: "Pay Now",
                        onPressed: widget.onPay,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _button({
    required String text,
    required VoidCallback onPressed,
  }) {
    return Container(
      height: 45,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),

        gradient: const LinearGradient(
          colors: [
            Color(0xFFFFFAA0),
            Color(0xFFFFF176),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),

        boxShadow: [
          BoxShadow(
            color: Colors.yellow.withValues(alpha: 0.25),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: ElevatedButton(
        onPressed: onPressed,

        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),

        child: Text(
          text,

          style: TextStyle(
            color: Colors.red.shade700,
            fontWeight: FontWeight.bold,
            fontSize: 15,
            letterSpacing: 0.75,
          ),
        ),
      ),
    );
  }

}

/// LOAD MORE BUTTON
class LoadMoreWidget extends StatelessWidget {
  final bool hasMoreData;
  final bool isLoadingMore;
  final VoidCallback loadMore;

  const LoadMoreWidget({
    super.key,
    required this.hasMoreData,
    required this.isLoadingMore,
    required this.loadMore,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),

      child: hasMoreData
          ? Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: const LinearGradient(
            colors: [Color(0xFF4FACFE), Color(0xFF007BFF),],
            begin: Alignment.topLeft, end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.blueAccent.withValues(alpha: 0.35),
              blurRadius: 12, offset: const Offset(0, 6),
            ),
          ],
        ),

        child: ElevatedButton(
          onPressed: isLoadingMore ? null : loadMore,

          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            disabledBackgroundColor: Colors.transparent,
            padding: const EdgeInsets.symmetric(vertical: 15,),
            minimumSize: const Size.fromHeight(42),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),

          child: isLoadingMore
              ? const SizedBox(
            height: 22, width: 22,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              valueColor:
              AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          )
              : const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,

            children: [
              Icon(
                Icons.expand_more_rounded,
                color: Colors.white, size: 22,),

              SizedBox(width: 8),

              Text(
                "Load More",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      )

          : Container(
        padding: const EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 18,
        ),

        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.blue.shade100,
          ),
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,

          children: [
            Icon(
              Icons.check_circle_outline_rounded,
              color: Colors.blue.shade400,
              size: 20,
            ),

            const SizedBox(width: 8),

            Text(
              "No More Data",
              style: TextStyle(
                color: Colors.blueGrey.shade600,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}