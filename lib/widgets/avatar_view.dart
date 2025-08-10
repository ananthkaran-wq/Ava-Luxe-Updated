import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/avatar_model.dart';

class AvatarView extends StatelessWidget {
  const AvatarView({super.key, this.size = 180});
  final double size;

  @override
  Widget build(BuildContext context) {
    final a = context.watch<AvatarModel>();

    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _AvatarPainter(a),
      ),
    );
  }
}

class _AvatarPainter extends CustomPainter {
  final AvatarModel a;
  _AvatarPainter(this.a);

  @override
  void paint(Canvas canvas, Size s) {
    final center = Offset(s.width / 2, s.height / 2);
    final headR = s.width * .28;

    // shirt circle
    final shirtPaint = Paint()..color = a.shirt;
    canvas.drawCircle(Offset(center.dx, center.dy + headR * 1.4), headR * 1.2, shirtPaint);

    // head
    final skinPaint = Paint()..color = a.skin;
    canvas.drawCircle(center, headR, skinPaint);

    // hair (simple arc)
    final hairPaint = Paint()..color = a.hair;
    final rect = Rect.fromCircle(center: center.translate(0, -headR * .2), radius: headR * 1.05);
    canvas.drawArc(rect, 3.14, 3.14, true, hairPaint);

    // eyes
    final eyePaint = Paint()..color = Colors.black87;
    final eyeOffset = headR * .35;
    canvas.drawCircle(center.translate(-eyeOffset, -headR * .1), headR * .08, eyePaint);
    canvas.drawCircle(center.translate( eyeOffset, -headR * .1), headR * .08, eyePaint);

    // smile
    final smile = Paint()
      ..color = Colors.black54
      ..style = PaintingStyle.stroke
      ..strokeWidth = headR * .06
      ..strokeCap = StrokeCap.round;
    final smileRect = Rect.fromCircle(center: center.translate(0, headR * .05), radius: headR * .45);
    canvas.drawArc(smileRect, .1, 3.14 - .2, false, smile);
  }

  @override
  bool shouldRepaint(covariant _AvatarPainter oldDelegate) => oldDelegate.a != a;
}
