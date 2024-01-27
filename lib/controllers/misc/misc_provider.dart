import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final bottomTabControllerProvider =
    Provider<PageController>((ref) => PageController());

final selectedIndexProvider = StateProvider<int>((ref) => 0);

final selectedDateProvider = StateProvider<DateTime>((ref) => DateTime.now());