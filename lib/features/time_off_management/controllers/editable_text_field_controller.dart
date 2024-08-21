import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/data/time_off/time_off_repository.dart';
import 'package:hrm_aqtech/features/time_off_management/models/general_time_off_model.dart';
import 'package:intl/intl.dart';

class EditableTextFieldController extends GetxController {
  EditableTextFieldController(this.generalTimeOff);

  final GeneralTimeOff generalTimeOff;

  var dateFrom = Rx<DateTime>(DateTime.now());
  var dateTo = Rx<DateTime>(DateTime.now());
  var sumDay = Rx<int>(0);

  var isEditing = false.obs;

  final reasonController = TextEditingController();
  final noteController = TextEditingController();
  final dateFromController = TextEditingController();
  final dateToController = TextEditingController();
  final sumDayController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    reasonController.text = generalTimeOff.reason;
    noteController.text = generalTimeOff.note;
    dateFromController.text =
        DateFormat('dd/MM/yyyy').format(generalTimeOff.dateFrom);
    dateToController.text =
        DateFormat('dd/MM/yyyy').format(generalTimeOff.dateTo);
    dateFrom.value = generalTimeOff.dateFrom;
    dateTo.value = generalTimeOff.dateTo;
    sumDay.value = generalTimeOff.sumDay;

    dateFrom.listen((_) => _updateSumDay());
    dateTo.listen((_) => _updateSumDay());
  }

  Future<void> saveChanges() async {
    generalTimeOff.dateFrom = dateFrom.value;
    generalTimeOff.dateTo = dateTo.value;
    generalTimeOff.sumDay =
        generalTimeOff.dateTo.difference(generalTimeOff.dateFrom).inDays;
    generalTimeOff.reason = reasonController.text;
    generalTimeOff.note = noteController.text;

    TimeOffRepository.instance.updateGeneralTimeOff(generalTimeOff);
    toggleEditing();
  }

  void toggleEditing() {
    isEditing.value = !isEditing.value;
  }

  void _updateSumDay() {
    sumDay.value = dateTo.value.difference(dateFrom.value).inDays + 1;
    sumDayController.text = sumDay.value.toString();
  }

  Future<void> saveToCreate() async {
    generalTimeOff.dateFrom = dateFrom.value;
    generalTimeOff.dateTo = dateTo.value;
    generalTimeOff.sumDay =
        generalTimeOff.dateTo.difference(generalTimeOff.dateFrom).inDays + 1;
    generalTimeOff.reason = reasonController.text;
    generalTimeOff.note = noteController.text;

    await TimeOffRepository.instance.createGeneralTimeOff(generalTimeOff);
    Get.back();
  }
}
