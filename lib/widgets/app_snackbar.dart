import 'package:flutter/material.dart';

class AppSnackBar {
  static OverlayEntry? _currentEntry;

  static void show(
      BuildContext context, {
        required String message,
        SnackBarType type = SnackBarType.info,
      }) {
    _currentEntry?.remove(); // remove previous if exists

    final overlay = Overlay.of(context);

    final data = _getData(type);

    _currentEntry = OverlayEntry(
      builder: (context) => _SnackBarWidget(
        message: message,
        color: data.color,
        icon: data.icon,
        onDismiss: dismiss,
      ),
    );

    overlay.insert(_currentEntry!);
  }

  static void dismiss() {
    _currentEntry?.remove();
    _currentEntry = null;
  }

  static _SnackBarData _getData(SnackBarType type) {
    switch (type) {
      case SnackBarType.success:
        return _SnackBarData(Icons.check_circle, Colors.green);
      case SnackBarType.error:
        return _SnackBarData(Icons.cancel, Colors.redAccent);
      case SnackBarType.warning:
        return _SnackBarData(Icons.warning, Colors.orange);
      default:
        return _SnackBarData(Icons.info, Colors.blue);
    }
  }
}

enum SnackBarType { success, error, warning, info }

class _SnackBarData {
  final IconData icon;
  final Color color;

  _SnackBarData(this.icon, this.color);
}

class _SnackBarWidget extends StatefulWidget {
  final String message;
  final Color color;
  final IconData icon;
  final VoidCallback onDismiss;

  const _SnackBarWidget({
    required this.message,
    required this.color,
    required this.icon,
    required this.onDismiss,
  });

  @override
  State<_SnackBarWidget> createState() => _SnackBarWidgetState();
}

class _SnackBarWidgetState extends State<_SnackBarWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Offset> slideAnimation;
  late Animation<double> fadeAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));

    fadeAnimation = Tween<double>(begin: 0, end: 1).animate(controller);

    controller.forward();

    Future.delayed(const Duration(seconds: 3), () async {
      await controller.reverse();
      widget.onDismiss();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 30,
      left: 16,
      right: 16,
      child: FadeTransition(
        opacity: fadeAnimation,
        child: SlideTransition(
          position: slideAnimation,
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: widget.color,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: widget.color.withValues(alpha: 0.4),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(widget.icon, color: Colors.white),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      widget.message,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}