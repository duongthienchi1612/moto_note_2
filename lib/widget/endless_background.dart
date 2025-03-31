import 'dart:async' as async;

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class EndlessBackground extends FlameGame with TapDetector {
  late SpriteComponent bg1, bg2;
  final double bgSpeed = 100;

  // moto
  late SpriteAnimationComponent motoAnimation;
  late SpriteAnimation movingAnimation;
  late SpriteAnimation accelerateAnimation;
  late SpriteAnimation brakeAnimation;

  int currentColorIndex = 0;

  async.Timer? accelerateTimer;
  async.Timer? colorChangeTimer;

  @override
  Color backgroundColor() => Colors.white;

  @override
  async.FutureOr<void> onLoad() async {
    super.onLoad();

    final sprite1 = await loadSprite('background.png');
    final sprite2 = await loadSprite('background.png');

    bg1 = SpriteComponent(sprite: sprite1, size: size, position: Vector2(0, 0));
    bg2 = SpriteComponent(sprite: sprite2, size: size, position: Vector2(size.x, 0));

    add(bg1);
    add(bg2);

    // moto
    await _loadAnimations();
    motoAnimation = SpriteAnimationComponent()
      ..animation = movingAnimation
      ..scale = Vector2(0.2, 0.2)
      ..position = Vector2(size.x / 2 - 100, 80);
    add(motoAnimation);
    _startActionLoops();
  }

  @override
  void update(double dt) {
    super.update(dt);
    bg1.position.x -= bgSpeed * dt;
    bg2.position.x -= bgSpeed * dt;

    if (bg1.position.x <= -size.x) {
      bg1.position.x = bg2.position.x + size.x;
    }
    if (bg2.position.x <= -size.x) {
      bg2.position.x = bg1.position.x + size.x;
    }
  }

  Future<void> _loadAnimations() async {
    final color = MotoAnimation.motoColors[currentColorIndex];

    movingAnimation = await _loadSpriteAnimation('bike/$color/${color}_moped_moving_', MotoAnimation.movingFrame);
    accelerateAnimation =
        await _loadSpriteAnimation('bike/$color/${color}_moped_accelerate_', MotoAnimation.accelerateFrame);
    brakeAnimation = await _loadSpriteAnimation('bike/$color/${color}_moped_brake_', MotoAnimation.brakeFrame);
  }

  Future<SpriteAnimation> _loadSpriteAnimation(String prefix, int frameCount, {double stepTime = 0.1}) async {
    final frames = <Sprite>[];
    for (int i = 0; i < frameCount; i++) {
      final fileName = '$prefix${i.toString()}.png';
      frames.add(await loadSprite(fileName));
    }
    return SpriteAnimation.spriteList(frames, stepTime: stepTime);
  }

  void _startActionLoops() {
    // Cứ mỗi 5 giây, thực hiện "accelerate" trong 1 giây rồi quay lại "moving"
    accelerateTimer = async.Timer.periodic(Duration(seconds: 5), (timer) async {
      motoAnimation.animation = accelerateAnimation;
      await Future.delayed(Duration(seconds: 1));
      currentColorIndex = (currentColorIndex + 1) % MotoAnimation.motoColors.length;
      await _loadAnimations();
      motoAnimation.animation = movingAnimation;
    });
  }

  @override
  async.Future<void> onTapDown(TapDownInfo info) async {
    // Khi người dùng tap vào xe, thực hiện "brake" trong 1 giây rồi quay lại "moving"
    motoAnimation.animation = brakeAnimation;
    await Future.delayed(Duration(seconds: 1));
    motoAnimation.animation = movingAnimation;
  }
}
