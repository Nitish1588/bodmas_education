import 'package:flutter/material.dart';

class RotatingWaves extends StatefulWidget {
  const RotatingWaves({
    super.key,
    this.size = 220,
    this.color = Colors.lightBlue,
    this.centered = false,
  });

  final double size;
  final bool centered;
  final Color color;

  @override
  State<RotatingWaves> createState() => _RotatingWavesState();
}

class _RotatingWavesState extends State<RotatingWaves>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: List.generate(
        6,
            (index) => Container(
          width: widget.size,
          height: widget.size,
          padding: EdgeInsets.all(index * (widget.size / 10)),
          child: AnimatedBuilder(
            animation: _controller,
            builder: (BuildContext context, Widget? child) {
              return Transform.rotate(
                angle: _controller.value * (index + 1) * 6.3,
                child: child,
              );
            },
            child: Shapes(
              index,
              widget.color,
              widget.centered,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class Shapes extends StatefulWidget {
  const Shapes(
      this.index,
      this.color,
      this.centered, {
        super.key,
      });

  final int index;
  final bool centered;
  final Color color;

  @override
  State<Shapes> createState() => _ShapesState();
}

class _ShapesState extends State<Shapes> {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DrawShapes(
        widget.index,
        widget.color,
        widget.centered,
      ),
    );
  }
}

class DrawShapes extends CustomPainter {
  DrawShapes(
      this.index,
      this.color,
      this.centered,
      );

  final Color color;
  final bool centered;
  final int index;

  @override
  void paint(Canvas canvas, Size size) {
    Paint brush = Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    var startArc = (20 * index * 3.14) / 180;
    var endArc = (90 * 3.14) / 180;

    if (index == 0 && centered) {
      brush.style = PaintingStyle.fill;

      canvas.drawCircle(
        Offset(size.height / 2, size.width / 2),
        5,
        brush,
      );
    } else {
      brush.style = PaintingStyle.stroke;

      canvas.drawArc(
        Rect.fromCenter(
          center: Offset(size.height / 2, size.width / 2),
          height: size.height,
          width: size.width,
        ),
        startArc,
        endArc,
        false,
        brush,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}