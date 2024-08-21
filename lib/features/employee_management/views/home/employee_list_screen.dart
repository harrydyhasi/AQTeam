import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/common/widgets/appbar/tabbar.dart';
import 'package:hrm_aqtech/features/employee_management/controllers/employee_controller.dart';
import 'package:hrm_aqtech/features/employee_management/views/employee_details/employee_detail.dart';
import 'package:hrm_aqtech/utils/constants/colors.dart';
import 'package:hrm_aqtech/utils/constants/enums.dart';
import 'package:hrm_aqtech/utils/constants/sizes.dart';
import 'package:iconsax/iconsax.dart';

class EmployeeListScreen extends StatelessWidget {
  const EmployeeListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final EmployeeController controller = Get.put(EmployeeController());

    return DefaultTabController(
      length: EmployeeRole.values.length,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: MyColors.primaryColor,
            title: const Text("Danh sách nhân sự AQTech"),
            actions: [
              IconButton(
                  onPressed: () {
                    //Get.to(() => EmployeeDetailScreen())
                  },
                  icon: const Icon(Iconsax.add))
            ],
          ),
          body: NestedScrollView(
              headerSliverBuilder: (_, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    pinned: true,
                    floating: true,
                    backgroundColor: Colors.white,
                    expandedHeight: 150,
                    flexibleSpace: const Padding(
                        padding: EdgeInsets.all(MySizes.defaultSpace),
                        child: TextField(
                          decoration: InputDecoration(
                              prefixIcon: Icon(Iconsax.search_normal),
                              hintText: "Tìm kiếm nhân viên"),
                        )),
                    bottom: MyTabbar(
                      onTap: (index) {
                        controller
                            .changeFilteredRole(EmployeeRole.values[index]);
                      },
                      tabs: EmployeeRole.values.map((role) {
                        return Tab(
                          text: role.toString().split('.').last,
                        );
                      }).toList(),
                    ),
                  ),
                ];
              },
              body: Obx(() => ListView.builder(
                    itemCount: controller.filteredEmployees.length,
                    itemBuilder: (context, index) {
                      final employee = controller.filteredEmployees[index];

                      return ListTile(
                        onTap: () => Get.to(() => EmployeeDetailScreen(
                              selectedEmployee: employee,
                            )),
                        title: Text(employee.email),
                        subtitle: Text(convertRole(employee.role)),
                      );
                    },
                  )))),
    );
  }

  String convertRole(String value) {
    switch (value) {
      case "1":
        {
          return EmployeeRole.Dev.toString().split('.').last;
        }
      case "2":
        {
          return EmployeeRole.Sale.toString().split('.').last;
        }
      default:
        return EmployeeRole.Designer.toString().split('.').last;
    }
  }
}
