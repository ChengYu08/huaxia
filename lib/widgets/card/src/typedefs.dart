import 'dart:async';

import 'package:flutter/material.dart';

import 'enums.dart';

typedef CardSwiperOnSwipe = FutureOr<bool> Function(
  int previousIndex,
  int? currentIndex,
  CardSwiperDirection direction,
);

typedef CardWidgetBuilder = Widget? Function(BuildContext context, int index,bool current);
typedef CardSwiperOnEnd = FutureOr<void> Function();
typedef Like = void Function(int like);
typedef CardSwiperOnTapDisabled = FutureOr<void> Function();

typedef CardSwiperOnUndo = bool Function(
  int? previousIndex,
  int currentIndex,
  CardSwiperDirection direction,
);
