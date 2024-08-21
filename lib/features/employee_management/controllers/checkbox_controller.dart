import 'package:get/get.dart';

class CheckboxController extends GetxController {
  var isActive = false.obs;
  var isLeader = false.obs;
  var isLunch = false.obs;

  void toggleIsActive() {
    isActive.value = !isActive.value;
  }

  void toggleIsLunch() {
    isLunch.value = !isLunch.value;
  }

  void toggleIsLeader() {
    isLeader.value = !isLeader.value;
  }
}
