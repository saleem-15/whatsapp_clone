import 'dart:ui';

import 'package:flutter_screenutil/flutter_screenutil.dart';

enum MediaType {
  landscape,
  portrait,
}

class MediaMessageSize {
  MediaMessageSize._();

  static double portraitMaxHeight = 300.h;
  static double landscapeMaxWidth = 310.w;

  static MediaType getMediaType(double width, double height) {
    if (height > width) {
      return MediaType.portrait;
    }

    ///if the `width > height` OR Its a `square dimensions` then its => `landscape`
    return MediaType.landscape;
  }

  static double getAspectRatio(double width, double height) => height / width;

  ///Used to calculate the size of a media message(photo or video)
  static Size calculateMediaSize({
    required double messageHeight,
    required double messageWidth,
  }) {
    /// is the media a `Portrait` Or `Landscape`
    final mediaType = getMediaType(messageWidth, messageHeight);
    final aspectRatio = getAspectRatio(messageWidth, messageHeight);

    if (mediaType.name == MediaType.portrait.name) {
      return _getPortraitMediaSize(messageHeight, messageWidth, aspectRatio);
    }
    return _getLandscapeMediaSize(messageHeight, messageWidth, aspectRatio);
  }

  /// calculates the size of a `portrait` media.\
  /// `It preserves the aspect ratio of the media`
  static Size _getPortraitMediaSize(
    double messageHeight,
    double messageWidth,
    double aspectRatio,
  ) {
    double w = messageWidth;
    double h = messageHeight;

    /// If the original height of the media exceeds [portraitMaxHeight],
    /// the height is set to [portraitMaxHeight].
    if (messageHeight > portraitMaxHeight) {
      h = portraitMaxHeight;
    }

    /// The width is calculated based on the updated height to
    /// maintain the aspect ratio.
    w = h / aspectRatio;

    // Logger().w('original aspectRatio: ${messageWidth / messageHeight} \n new aspectRatio: ${w / h}');
    // log('height: $h\t\t w:$w');

    return Size(w, h);
  }

  /// calculates the size of a `Landscape` media.\
  /// `It preserves the aspect ratio of the media`
  static Size _getLandscapeMediaSize(
    double messageHeight,
    double messageWidth,
    double aspectRatio,
  ) {
    double w = messageWidth;
    double h = messageHeight;

    /// If the original width of the media exceeds [landscapeMaxWidth],
    /// the width is set to [landscapeMaxWidth].
    if (messageWidth > landscapeMaxWidth) {
      w = landscapeMaxWidth;
    }

    /// The height is calculated based on the updated width to
    /// maintain the aspect ratio.
    h = w * aspectRatio;

    // Logger().w('original aspectRatio: ${messageWidth / messageHeight} \n new aspectRatio: ${w / h}');
    // log('height: $h\t\t w:$w');

    return Size(w, h);
  }
}
