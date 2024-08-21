import 'package:hrm_aqtech/utils/constants/enums.dart';

class HeplerFunction {
  static String convertRole(int value) {
    switch (value) {
      case 1:
        {
          return EmployeeRole.Dev.toString();
        }
      case 2:
        {
          return EmployeeRole.Sale.toString();
        }
      default:
        return EmployeeRole.Designer.toString();
    }
  }
}
