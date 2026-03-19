import 'package:flutter/material.dart';
import 'dart:math' as math;

class FloatingParticles extends StatefulWidget {
  final int particleCount;
  final Color? particleColor;
  final double particleSize;
  final Duration animationDuration;

  const FloatingParticles({
    super.key,
    this.particleCount = 50,
    this.particleColor,
    this.particleSize = 2.0,
    this.animationDuration = const Duration(seconds: 20),
  });

  @override
  State<FloatingParticles> createState() => _FloatingParticlesState();
}

class _FloatingParticlesState extends State<FloatingParticles>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late List<Particle> _particles;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _initializeParticles();
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _initializeParticles() {
    final random = math.Random();
    _particles = List.generate(widget.particleCount, (index) {
      return Particle(
        x: random.nextDouble(),
        y: random.nextDouble(),
        size: widget.particleSize + random.nextDouble() * 2,
        speed: 0.5 + random.nextDouble() * 1.5,
        opacity: 0.1 + random.nextDouble() * 0.3,
        direction: random.nextDouble() * 2 * math.pi,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: ParticlesPainter(
            particles: _particles,
            animationValue: _controller.value,
            particleColor:
                widget.particleColor ??
                Theme.of(
                  context,
                ).textTheme.bodyLarge?.color?.withOpacity(0.1) ??
                Colors.grey.withOpacity(0.1),
          ),
          size: Size.infinite,
        );
      },
    );
  }
}

class Particle {
  double x;
  double y;
  double size;
  double speed;
  double opacity;
  double direction;

  Particle({
    required this.x,
    required this.y,
    required this.size,
    required this.speed,
    required this.opacity,
    required this.direction,
  });
}

class ParticlesPainter extends CustomPainter {
  final List<Particle> particles;
  final double animationValue;
  final Color particleColor;

  ParticlesPainter({
    required this.particles,
    required this.animationValue,
    required this.particleColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = particleColor
          ..style = PaintingStyle.fill;

    for (final particle in particles) {
      // Calculate new position based on animation
      final newX =
          (particle.x +
              math.cos(particle.direction) * particle.speed * animationValue) %
          1.0;
      final newY =
          (particle.y +
              math.sin(particle.direction) * particle.speed * animationValue) %
          1.0;

      // Draw particle
      canvas.drawCircle(
        Offset(newX * size.width, newY * size.height),
        particle.size,
        paint..color = particleColor.withOpacity(particle.opacity),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}


