import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spritewidget/spritewidget.dart' as sw;

class AnimationWidget extends StatefulWidget {
  const AnimationWidget({Key? key}) : super(key: key);

  @override
  AnimationWidgetState createState() => AnimationWidgetState();
}

class AnimationWidgetState extends State<AnimationWidget> {
  late sw.NodeWithSize rootNode;

  @override
  void initState() {
    super.initState();
    rootNode = RootNode(size: const Size(300, 500), nodes: [
      Y(), U(), M(), E(), M(), I(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return sw.SpriteWidget(rootNode);
  }
}

class RootNode extends sw.NodeWithSize {
  RootNode({required List<AnimationNode> nodes, required Size size}) : super(size) {
    var unit = size.width / (nodes.length * 2);
    nodes.asMap().forEach((int i, AnimationNode node) {
      node.position = Offset(unit * (2 * i + 1), size.height / 2);
      node.runAnimation();
      addChild(node);
    });
  }
}

abstract class AnimationNode extends sw.Node{
  void runAnimation();
}

class Y extends AnimationNode {
  @override
  void paint(Canvas canvas) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 10;
    canvas.drawLine(const Offset(0, 0), const Offset(20, 20), paint);
    canvas.drawLine(const Offset(40, 0), const Offset(20, 20), paint);
    canvas.drawLine(const Offset(20, 20), const Offset(20, 60), paint);
  }

  @override
  void runAnimation() {
    final rotateR = sw.MotionTween<double>((animation) => rotation = animation, 0, 5.0, 1);
    final rotateL = sw.MotionTween<double>((animation) => rotation = animation, 0, -5.0, 1);
    final sequence = sw.MotionSequence([
      rotateR,
      rotateL,
    ]);
    motions.run(sw.MotionRepeatForever(sequence));
  }
}

class U extends AnimationNode {

  @override
  void paint(Canvas canvas) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 10;

    canvas.drawLine(const Offset(0, 0), const Offset(0, 40), paint);
    canvas.drawLine(const Offset(-1, 38), const Offset(10, 60), paint);
    canvas.drawLine(const Offset(6, 58), const Offset(24, 58), paint);
    canvas.drawLine(const Offset(20, 60), const Offset(31, 38), paint);
    canvas.drawLine(const Offset(30, 40), const Offset(30, 0), paint);
  }

  @override
  void runAnimation() {
    final up = sw.MotionTween<Offset>((animation)  => position = animation, position, position + const Offset(0, 5), 1.0,);
    final down = sw.MotionTween<Offset>((animation) => position = animation, position, position - const Offset(0, 5), 1.0,);
    final sequence = sw.MotionSequence([
      up,
      down,
    ]);
    motions.run(sw.MotionRepeatForever(sequence));
  }
}

class M extends AnimationNode {

  @override
  void paint(Canvas canvas) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 10;

    canvas.drawLine(const Offset(0, 0), const Offset(0, 60), paint);
    canvas.drawLine(const Offset(0, 2), const Offset(20, 60), paint);
    canvas.drawLine(const Offset(40, 2), const Offset(20, 60), paint);
    canvas.drawLine(const Offset(40, 0), const Offset(40, 60), paint);
  }

  @override
  void runAnimation() {
    final right = sw.MotionTween<Offset>((animation)  => position = animation, position, position + const Offset(5, 0), 1.0,);
    final left = sw.MotionTween<Offset>((animation) => position = animation, position, position - const Offset(5, 0), 1.0,);
    final sequence = sw.MotionSequence([
      right,
      left,
    ]);
    motions.run(sw.MotionRepeatForever(sequence));
  }

}


class E extends AnimationNode {

  @override
  void paint(Canvas canvas) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 10;

    canvas.drawLine(const Offset(5, 0), const Offset(5, 60), paint);
    canvas.drawLine(const Offset(5, 5), const Offset(40, 5), paint);
    canvas.drawLine(const Offset(5, 30), const Offset(40, 30), paint);
    canvas.drawLine(const Offset(5, 55), const Offset(40, 55), paint);
  }

  @override
  void runAnimation() {
    final up = sw.MotionTween<Offset>((animation)  => position = animation, position, position + const Offset(0, 5), 1.0,);
    final down = sw.MotionTween<Offset>((animation) => position = animation, position, position - const Offset(0, 5), 1.0,);
    final sequence = sw.MotionSequence([
      up,
      down,
    ]);
    motions.run(sw.MotionRepeatForever(sequence));
  }
}

class I extends AnimationNode {

  @override
  void paint(Canvas canvas) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 10;

    canvas.drawLine(const Offset(10, 0), const Offset(10, 60), paint);
    canvas.drawLine(const Offset(0, 5), const Offset(20, 5), paint);
    canvas.drawLine(const Offset(0, 55), const Offset(20, 55), paint);
  }

  @override
  void runAnimation() {
    final rotateR = sw.MotionTween<double>((animation) => rotation = animation, 0, 5.0, 1);
    final rotateL = sw.MotionTween<double>((animation) => rotation = animation, 0, -5.0, 1);
    final sequence = sw.MotionSequence([
      rotateL,
      rotateR,
    ]);
    motions.run(sw.MotionRepeatForever(sequence));
  }
}