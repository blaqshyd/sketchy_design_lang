import 'dart:math';

/// Configuration describing how rough shapes are drawn.
class DrawConfig {
  const DrawConfig._({
    this.maxRandomnessOffset,
    this.roughness,
    this.bowing,
    this.curveFitting,
    this.curveTightness,
    this.curveStepCount,
    this.seed,
    this.randomizer,
  });

  /// Maximum offset applied when randomizing points.
  final double? maxRandomnessOffset;

  /// How rough the resulting lines should be.
  final double? roughness;

  /// Amount of bowing applied to lines.
  final double? bowing;

  /// How closely curves should match their targets.
  final double? curveFitting;

  /// Tightness applied to curves.
  final double? curveTightness;

  /// Number of points used to approximate curves.
  final double? curveStepCount;

  /// Seed used for deterministic randomness.
  final int? seed;

  /// Random number generator backing this config.
  final Randomizer? randomizer;

  /// Default configuration used when values aren't provided.
  static DrawConfig defaultValues = DrawConfig.build(
    maxRandomnessOffset: 2,
    roughness: 1,
    bowing: 1,
    curveFitting: 0.95,
    curveTightness: 0,
    curveStepCount: 9,
    seed: 1,
  );

  /// Factory that builds a new [DrawConfig] with sensible defaults.
  factory DrawConfig.build({
    double? maxRandomnessOffset,
    double? roughness,
    double? bowing,
    double? curveFitting,
    double? curveTightness,
    double? curveStepCount,
    int? seed,
  }) => DrawConfig._(
    maxRandomnessOffset:
        maxRandomnessOffset ?? defaultValues.maxRandomnessOffset,
    roughness: roughness ?? defaultValues.roughness,
    bowing: bowing ?? defaultValues.bowing,
    curveFitting: curveFitting ?? defaultValues.curveFitting,
    curveTightness: curveTightness ?? defaultValues.curveTightness,
    curveStepCount: curveStepCount ?? defaultValues.curveStepCount,
    seed: seed ?? defaultValues.seed,
    randomizer: Randomizer(seed: seed ?? defaultValues.seed!),
  );

  /// Returns a random offset between [min] and [max] scaled by [roughnessGain].
  double offset(double min, double max, [double roughnessGain = 1]) =>
      roughness! * roughnessGain * ((randomizer!.next() * (max - min)) + min);

  /// Returns a symmetric random offset between `-x` and `x`.
  double offsetSymmetric(double x, [double roughnessGain = 1]) =>
      offset(-x, x, roughnessGain);

  /// Creates a copy with selectively overridden values.
  DrawConfig copyWith({
    double? maxRandomnessOffset,
    double? roughness,
    double? bowing,
    double? curveFitting,
    double? curveTightness,
    double? curveStepCount,
    double? fillWeight,
    int? seed,
    bool? combineNestedSvgPaths,
    Randomizer? randomizer,
  }) => DrawConfig._(
    maxRandomnessOffset: maxRandomnessOffset ?? this.maxRandomnessOffset,
    roughness: roughness ?? this.roughness,
    bowing: bowing ?? this.bowing,
    curveFitting: curveFitting ?? this.curveFitting,
    curveTightness: curveTightness ?? this.curveTightness,
    curveStepCount: curveStepCount ?? this.curveStepCount,
    seed: seed ?? this.seed,
    randomizer:
        randomizer ??
        (this.randomizer == null
            ? null
            : Randomizer(seed: this.randomizer!.seed)),
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DrawConfig &&
          runtimeType == other.runtimeType &&
          maxRandomnessOffset == other.maxRandomnessOffset &&
          roughness == other.roughness &&
          bowing == other.bowing &&
          curveFitting == other.curveFitting &&
          curveTightness == other.curveTightness &&
          curveStepCount == other.curveStepCount &&
          seed == other.seed &&
          randomizer == other.randomizer;

  @override
  int get hashCode =>
      maxRandomnessOffset.hashCode ^
      roughness.hashCode ^
      bowing.hashCode ^
      curveFitting.hashCode ^
      curveTightness.hashCode ^
      curveStepCount.hashCode ^
      seed.hashCode ^
      randomizer.hashCode;
}

/// Simple random number wrapper that keeps track of its seed.
class Randomizer {
  /// Creates a randomizer seeded with [seed].
  Randomizer({int seed = 0}) {
    _seed = seed;
    _random = Random(seed);
  }

  late Random _random;
  late int _seed;

  /// Seed used for this randomizer.
  int get seed => _seed;

  /// Returns the next random double.
  double next() => _random.nextDouble();

  /// Resets the underlying RNG to the original seed.
  void reset() {
    _random = Random(_seed);
  }
}
