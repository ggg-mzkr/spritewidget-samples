import 'dart:ui' as ui show Image;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';
import 'package:spritewidget/spritewidget.dart' as sw;

class Particle extends GetView {
  final RxList<ui.Image> images = <ui.Image>[].obs;

  Particle({Key? key}) : super(key: key) {
    _loadAssets(rootBundle);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => sw.SpriteWidget(RootNode(Particles(images, [1.0, 1.5, 2.0]))));
  }

  Future<void> _loadAssets(AssetBundle bundle) async {
    images.value = await sw.ImageMap(bundle).load(<String>[
      'assets/star_blue.png',
      'assets/star_pink.png',
      'assets/star_red.png',
      'assets/star_yellow.png',
    ]);
  }
}

class RootNode extends sw.NodeWithSize {
  RootNode(Particles particles) : super(const Size(2048.0, 2048.0)) {
    addChild(GradientNode(size, const Color(0xffcbced7), const Color(0xffe0e3ec)));
    addChild(particles);
  }
}

class GradientNode extends sw.NodeWithSize {
  GradientNode(Size size, this.colorTop, this.colorBottom) : super(size);

  Color colorTop;

  Color colorBottom;

  @override
  void paint(Canvas canvas) {
    applyTransformForPivot(canvas);

    Rect rect = Offset.zero & size;
    Paint gradientPaint = Paint()
      ..shader = LinearGradient(
          begin: FractionalOffset.topLeft,
          end: FractionalOffset.bottomLeft,
          colors: <Color>[colorTop, colorBottom],
          stops: const <double>[0.0, 1.0]).createShader(rect);

    canvas.drawRect(rect, gradientPaint);
  }
}

class Particles extends sw.Node {
  Particles(List<ui.Image> images, List<double> distances) {
    for (double distance in distances) {
      for (ui.Image image in images) {
        _addParticle(image, distance);
      }
    }
  }

  void _addParticle(ui.Image image, double distance) {
    sw.ParticleSystem particles = sw.ParticleSystem(sw.SpriteTexture(image),
        transferMode: BlendMode.srcATop,
        posVar: const Offset(1300.0, 0.0),
        direction: 90.0,
        directionVar: 0.0,
        speed: 150.0 / distance,
        speedVar: 50.0 / distance,
        startSize: 1.0 / distance,
        startSizeVar: 0.3 / distance,
        endSize: 1.2 / distance,
        endSizeVar: 0.2 / distance,
        life: 20.0 * distance,
        lifeVar: 10.0 * distance,
        emissionRate: 2.0,
        startRotationVar: 360.0,
        endRotationVar: 360.0,
        radialAccelerationVar: 10.0 / distance,
        tangentialAccelerationVar: 10.0 / distance);

    particles.position = const Offset(1024.0, -50.0);
    particles.opacity = 1.0;

    addChild(particles);
  }
}