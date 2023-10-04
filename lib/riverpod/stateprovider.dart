

import 'package:flutter_riverpod/flutter_riverpod.dart';

final commonBoolValue = StateProvider.autoDispose<bool>((ref) => true);
final selectedBottomNavIndexProvider =
StateProvider.autoDispose<int>((ref) => 0);