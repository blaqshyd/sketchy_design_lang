import 'package:flutter/material.dart';

import '../../rough/rough.dart';
import 'wired_painter.dart';
import 'wired_painter_base.dart';

class WiredCanvas extends StatelessWidget {
  const WiredCanvas({
    required this.painter,
    required this.fillerType,
    Key? key,
    this.drawConfig,
    this.fillerConfig,
    this.size,
  }) : super(key: key);
  final WiredPainterBase painter;
  final DrawConfig? drawConfig;
  final FillerConfig? fillerConfig;
  final RoughFilter fillerType;
  final Size? size;

  @override
  Widget build(BuildContext context) {
    final effectiveDrawConfig = drawConfig ?? DrawConfig.defaultValues;
    final effectiveFillerConfig = fillerConfig ?? FillerConfig.defaultConfig;

    final filler = _filters[fillerType]!.call(effectiveFillerConfig);
    return CustomPaint(
      size: size == null ? Size.infinite : size!,
      painter: WiredPainter(effectiveDrawConfig, filler, painter),
    );
  }
}

Map<RoughFilter, Filler Function(FillerConfig)> _filters =
    <RoughFilter, Filler Function(FillerConfig)>{
      RoughFilter.NoFiller: (fillerConfig) => NoFiller(fillerConfig),
      RoughFilter.HachureFiller: (fillerConfig) => HachureFiller(fillerConfig),
      RoughFilter.ZigZagFiller: (fillerConfig) => ZigZagFiller(fillerConfig),
      RoughFilter.HatchFiller: (fillerConfig) => HatchFiller(fillerConfig),
      RoughFilter.DotFiller: (fillerConfig) => DotFiller(fillerConfig),
      RoughFilter.DashedFiller: (fillerConfig) => DashedFiller(fillerConfig),
      RoughFilter.SolidFiller: (fillerConfig) => SolidFiller(fillerConfig),
    };

enum RoughFilter {
  NoFiller,
  HachureFiller,
  ZigZagFiller,
  HatchFiller,
  DotFiller,
  DashedFiller,
  SolidFiller,
}
