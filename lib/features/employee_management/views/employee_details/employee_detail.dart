import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/common/widgets/images/circular_image.dart';
import 'package:hrm_aqtech/features/employee_management/controllers/editable_text_field_controller.dart';
import 'package:hrm_aqtech/features/employee_management/models/employee_model.dart';
import 'package:hrm_aqtech/utils/constants/colors.dart';
import 'package:hrm_aqtech/utils/constants/enums.dart';
import 'package:hrm_aqtech/utils/constants/image_paths.dart';
import 'package:hrm_aqtech/utils/constants/sizes.dart';
import 'package:iconsax/iconsax.dart';

class EmployeeDetailScreen extends StatelessWidget {
  EmployeeDetailScreen({super.key, required this.selectedEmployee});

  // Text controller
  final EditableTextFieldController controller =
      Get.put(EditableTextFieldController());
  final Employee selectedEmployee;

  void fetchEmployeeDetails() {
    controller.emailController.text = selectedEmployee.email;
    controller.tfsController.text = selectedEmployee.tfsName;
    controller.fullNameController.text = selectedEmployee.fullName;
    controller.nickNameController.text = selectedEmployee.nickName;
    controller.phoneController.text = selectedEmployee.phone;
    controller.checkboxController.isActive.value = selectedEmployee.isActive;
    controller.checkboxController.isLeader.value = selectedEmployee.isLeader;
    controller.checkboxController.isLunch.value = selectedEmployee.isLunch;
    if (selectedEmployee.role == "1") {
      controller.roleController.selectedDepartment.value = EmployeeRole.Dev;
    } else {
      controller.roleController.selectedDepartment.value = EmployeeRole.Sale;
    }
  }

  @override
  Widget build(BuildContext context) {
    fetchEmployeeDetails();
    return Scaffold(
        appBar: AppBar(backgroundColor: MyColors.primaryColor, actions: [
          Obx(
            () => IconButton(
                onPressed: () {
                  if (controller.isEditting.value) {
                    controller.save(selectedEmployee);
                  } else {
                    controller.toggleEditting();
                  }
                },
                icon: Icon(
                    controller.isEditting.value ? Icons.save : Iconsax.edit)),
          ),
        ]),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(MySizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1.
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      // Avatar image
                      const MyCircularImage(
                        image: MyImagePaths.defaultUser,
                        width: 80,
                        height: 80,
                      ),
                      // change avatar image
                      TextButton(
                          onPressed: () {},
                          child: const Text("Đổi ảnh đại diện"))
                    ],
                  ),
                ),
                // 2.
                Text(
                  "Thông tin cá nhân",
                  style: Theme.of(context).textTheme.headlineMedium!,
                ),

                const SizedBox(
                  height: MySizes.spaceBtwItems,
                ),

                ProfileMenu(
                  textController: controller.fullNameController,
                  label: 'Họ và tên',
                ),
                const SizedBox(
                  height: MySizes.spaceBtwInputFields,
                ),
                ProfileMenu(
                  textController: controller.tfsController,
                  label: 'Tfs name',
                ),
                const SizedBox(
                  height: MySizes.spaceBtwInputFields,
                ),
                ProfileMenu(
                  textController: controller.nickNameController,
                  label: 'Nick name',
                ),
                const SizedBox(
                  height: MySizes.spaceBtwInputFields,
                ),
                ProfileMenu(
                  textController: controller.emailController,
                  label: 'Email',
                ),
                const SizedBox(
                  height: MySizes.spaceBtwItems,
                ),
                ProfileMenu(
                  textController: controller.phoneController,
                  label: 'Điện thoại',
                ),
                const SizedBox(
                  height: MySizes.spaceBtwItems,
                ),
                Text(
                  "Công ty",
                  style: Theme.of(context).textTheme.headlineMedium!,
                ),

                const SizedBox(
                  height: MySizes.spaceBtwItems,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Text
                    Text(
                      "Phòng ban",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(
                      width: MySizes.sm,
                    ),
                    // Drop down button Phong Ban
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(MySizes.borderRadiusMd),
                          border:
                              Border.all(color: MyColors.accentColor, width: 1),
                        ),
                        child: Obx(
                          () => DropdownButtonHideUnderline(
                            child: DropdownButton(
                              value: controller
                                  .roleController.selectedDepartment.value,
                              dropdownColor: MyColors.iconColor,
                              onChanged: controller.isEditting.value
                                  ? (EmployeeRole? role) {
                                      if (role != null) {
                                        controller.roleController
                                            .setSelectedDepartment(role);
                                      }
                                    }
                                  : null,
                              items:
                                  EmployeeRole.values.map((EmployeeRole role) {
                                return DropdownMenuItem(
                                    value: role,
                                    child: Padding(
                                      padding: const EdgeInsets.all(MySizes.sm),
                                      child:
                                          Text(role.toString().split('.').last),
                                    ));
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: MySizes.spaceBtwItems,
                ),

                const SizedBox(
                  height: MySizes.spaceBtwItems,
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: MyColors.accentColor,
                      ),
                      borderRadius:
                          BorderRadius.circular(MySizes.borderRadiusMd)),
                  child: Column(
                    children: [
                      Obx(
                        () => CheckboxListTile(
                          enabled: (controller.isEditting.value),
                          title: const Text("isLeader"),
                          value: controller.checkboxController.isLeader.value,
                          onChanged: (value) {
                            controller.checkboxController.toggleIsLeader();
                          },
                        ),
                      ),
                      Obx(
                        () => CheckboxListTile(
                          enabled: (controller.isEditting.value),
                          title: const Text(
                            "isLunch",
                          ),
                          value: controller.checkboxController.isLunch.value,
                          onChanged: (value) {
                            controller.checkboxController.toggleIsLunch();
                          },
                        ),
                      ),
                      Obx(
                        () => CheckboxListTile(
                          enabled: (controller.isEditting.value),
                          title: const Text("isActive"),
                          value: controller.checkboxController.isActive.value,
                          onChanged: (value) {
                            controller.checkboxController.toggleIsActive();
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    super.key,
    required this.textController,
    required this.label,
  });

  final String label;
  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        children: [
          Expanded(
            child: TextField(
              controller: textController,
              enabled: (EditableTextFieldController.instance.isEditting.value),
              decoration: InputDecoration(
                label: Text(
                  label,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
