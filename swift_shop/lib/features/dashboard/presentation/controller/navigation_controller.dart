import 'package:flutter_riverpod/flutter_riverpod.dart';

final navigationControllerProvider =
    StateNotifierProvider<NavigationControllerNotifier, int>(
        (ref) => NavigationControllerNotifier());

class NavigationControllerNotifier extends StateNotifier<int> {
  NavigationControllerNotifier() : super(0);

  void changeIndex(int newIndex) {
    state = newIndex;
  }
}
