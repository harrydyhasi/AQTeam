import 'package:get/get.dart';
import 'package:hrm_aqtech/data/time_off/time_off_repository.dart';
import 'package:hrm_aqtech/features/time_off_management/models/general_time_off_model.dart';

class GeneralTimeOffController extends GetxController {
  final isLoading = false.obs;
  final RxString error = ''.obs; // Observable error message

  static GeneralTimeOffController get instance => Get.find();
  RxList<GeneralTimeOff> generalTimeOffs = <GeneralTimeOff>[].obs;
  final _timeOffRepository = Get.put(TimeOffRepository());

  @override
  void onInit() {
    super.onInit();
    fetchGeneralTimeOffs();
  }

  Future<void> fetchGeneralTimeOffs() async {
    try {
      isLoading.value = true;
      final timeOffs = await _timeOffRepository.getAllGeneralTimeOffs();
      generalTimeOffs.assignAll(timeOffs);
    } catch (_) {
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateGeneralTimeOff(GeneralTimeOff timeOff) async {
    try {
      isLoading.value = true;
      await _timeOffRepository.updateGeneralTimeOff(timeOff);
    } catch (_) {
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshTimeOffs() async {
    fetchGeneralTimeOffs();
  }

  Future<void> deleteTimeOff(int id) async {
    try {
      await _timeOffRepository.deleteTimeOff(id);
    } catch (_) {
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createTimeOff(GeneralTimeOff timeOff) async {
    try {
      isLoading.value = true;
      await _timeOffRepository.createGeneralTimeOff(timeOff);
    } catch (_) {
    } finally {
      isLoading.value = false;
    }
  }
}
