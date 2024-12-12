/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/bus_seat.png
  AssetGenImage get busSeat => const AssetGenImage('assets/icons/bus_seat.png');

  /// File path: assets/icons/seat.png
  AssetGenImage get seat => const AssetGenImage('assets/icons/seat.png');

  /// List of all assets
  List<AssetGenImage> get values => [busSeat, seat];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/bg1.jpg
  AssetGenImage get bg1 => const AssetGenImage('assets/images/bg1.jpg');

  /// File path: assets/images/bg2.jpg
  AssetGenImage get bg2 => const AssetGenImage('assets/images/bg2.jpg');

  /// File path: assets/images/bg3.jpg
  AssetGenImage get bg3 => const AssetGenImage('assets/images/bg3.jpg');

  /// File path: assets/images/bg4.jpg
  AssetGenImage get bg4 => const AssetGenImage('assets/images/bg4.jpg');

  /// File path: assets/images/bg5.jpg
  AssetGenImage get bg5 => const AssetGenImage('assets/images/bg5.jpg');

  /// File path: assets/images/bg6.jpg
  AssetGenImage get bg6 => const AssetGenImage('assets/images/bg6.jpg');

  /// File path: assets/images/bg7.jpg
  AssetGenImage get bg7 => const AssetGenImage('assets/images/bg7.jpg');

  /// File path: assets/images/bg8.jpg
  AssetGenImage get bg8 => const AssetGenImage('assets/images/bg8.jpg');

  /// File path: assets/images/bg9.jpg
  AssetGenImage get bg9 => const AssetGenImage('assets/images/bg9.jpg');

  /// File path: assets/images/bus.png
  AssetGenImage get bus => const AssetGenImage('assets/images/bus.png');

  /// File path: assets/images/bus_ongoing.json
  String get busOngoing => 'assets/images/bus_ongoing.json';

  /// File path: assets/images/login.png
  AssetGenImage get login => const AssetGenImage('assets/images/login.png');

  /// File path: assets/images/no_item_found.json
  String get noItemFound => 'assets/images/no_item_found.json';

  /// File path: assets/images/ride_on_logo.png
  AssetGenImage get rideOnLogo =>
      const AssetGenImage('assets/images/ride_on_logo.png');

  /// List of all assets
  List<dynamic> get values => [
        bg1,
        bg2,
        bg3,
        bg4,
        bg5,
        bg6,
        bg7,
        bg8,
        bg9,
        bus,
        busOngoing,
        login,
        noItemFound,
        rideOnLogo
      ];
}

class Assets {
  Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
