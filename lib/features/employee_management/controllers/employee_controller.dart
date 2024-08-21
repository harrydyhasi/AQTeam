import 'package:get/get.dart';
import 'package:hrm_aqtech/data/employees/employee_repository.dart';
import 'package:hrm_aqtech/features/employee_management/models/employee_model.dart';
import 'package:hrm_aqtech/utils/constants/enums.dart';

class EmployeeController extends GetxController {
  var filteredRole = EmployeeRole.All.obs; // handle tab
  final isLoading = false.obs;
  static EmployeeController get instance => Get.find();
  RxList<Employee> allEmployees = <Employee>[].obs;
  final _employeeRepository = Get.put(EmployeeRepository());

  @override
  void onInit() {
    fetchEmployees();
    super.onInit();
  }

  Future<void> fetchEmployees() async {
    try {
      // show loader while loading list
      isLoading.value = true;
      // fetch employees from api
      final employees = await _employeeRepository.getAllEmployees();
      // update the employees list
      allEmployees.assignAll(employees);
    } catch (e) {
    } finally {
      // stop loader
    }
  }

  Future<void> updateEmployeeInfor() async {
    
  }

  // Lọc danh sách nhân viên theo chức vụ
  List<Employee> get filteredEmployees {
    if (filteredRole.value == EmployeeRole.All) {
      return allEmployees;
    } else {
      return allEmployees
          .where((employee) =>
              convertRole(employee.role).trim() ==
              filteredRole.value.toString().trim())
          .toList();
    }
  }

  String convertRole(String value) {
    switch (value) {
      case "1":
        {
          return EmployeeRole.Dev.toString();
        }
      case "2":
        {
          return EmployeeRole.Sale.toString();
        }
      default:
        return EmployeeRole.Designer.toString();
    }
  }

  void changeFilteredRole(EmployeeRole role) {
    filteredRole.value = role;
  }
}
