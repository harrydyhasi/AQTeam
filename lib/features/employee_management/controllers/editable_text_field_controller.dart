import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/data/employees/employee_repository.dart';
import 'package:hrm_aqtech/features/employee_management/controllers/checkbox_controller.dart';
import 'package:hrm_aqtech/features/employee_management/controllers/role_controller.dart';
import 'package:hrm_aqtech/features/employee_management/models/employee_model.dart';

class EditableTextFieldController extends GetxController {
  static EditableTextFieldController get instance => Get.find();
  TextEditingController emailController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController tfsController = TextEditingController();
  TextEditingController nickNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  RoleController roleController = Get.put(RoleController());
  CheckboxController checkboxController = Get.put(CheckboxController());
  var isEditting = false.obs;

  @override
  void onInit() {
    //emailController.text = "Nguyen Anh Duy";
    //fullNameController.text = "abc@gmail.com";
    super.onInit();
  }

  @override
  void onClose() {
    emailController.dispose();
    fullNameController.dispose();
    roleController.dispose();
    phoneController.dispose();
    super.onClose();
  }

  void toggleEditting() {
    isEditting.value = !isEditting.value;
  }

  void save(Employee newEmployee) {
    // xu ly luu qua api
    //newEmployee.email = emailController.text.toString().trim();
    // newEmployee.fullName = fullNameController.text.toString().trim();
    // newEmployee.tfsName = tfsController.text.toString().trim();
    // newEmployee.nickName = nickNameController.text.toString().trim();
    // newEmployee.isActive = checkboxController.isActive.value;
    // newEmployee.isLunch = checkboxController.isLunch.value;
    // newEmployee.isLeader = checkboxController.isLeader.value;
    EmployeeRepository.instance.updateEmployeeInfor(newEmployee);
    // print("======");
    // print(newEmployee.id);
    // print(newEmployee.email.toString());
    toggleEditting();
  }
}
