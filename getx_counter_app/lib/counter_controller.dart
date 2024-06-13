import 'package:get/get.dart';

class CounterController extends GetxController {
  //Observable state
  var counter = 0.obs;

  void increment() {
    counter++;
  }

  void decrement() {
    if (counter > 0) counter--;
  }
}
