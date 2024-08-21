import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_aqtech/common/widgets/button/create_button.dart';
import 'package:hrm_aqtech/features/time_off_management/controllers/general_time_off_controller.dart';
import 'package:hrm_aqtech/features/time_off_management/models/general_time_off_model.dart';
import 'package:hrm_aqtech/features/time_off_management/views/general_time_off/create_general_time_off.dart/create_general_time_off.dart';
import 'package:hrm_aqtech/features/time_off_management/views/general_time_off_detail/general_time_off_detail.dart';
import 'package:hrm_aqtech/utils/constants/colors.dart';

class GeneralTimeOffScreen extends StatelessWidget {
  const GeneralTimeOffScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GeneralTimeOffController controller =
        Get.put(GeneralTimeOffController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.primaryColor,
        title: const Text("Ngày nghỉ chung"),
      ),
      body: NestedScrollView(
          headerSliverBuilder: (_, innerBoxIsScrolled) {
            return [
              const SliverAppBar(
                automaticallyImplyLeading: false,
                pinned: true,
                floating: true,
                backgroundColor: Colors.white,
              ),
            ];
          },
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSearchBar(),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Spacer(),
                      CreateButton(
                        text: 'Tạo ngày nghỉ chung',
                        width: 150,
                        height: 50,
                        color: MyColors.primaryColor,
                        onTap: () async {
                          await Get.to(
                            () => CreateGeneralTimeOffScreen(
                                generalTimeOff: GeneralTimeOff.empty()),
                          );
                          controller.refreshTimeOffs();
                        },
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  // List of general days off
                  Obx(() {
                    if (controller.isLoading.value) {
                      return const Center(
                          child: CircularProgressIndicator(
                        color: MyColors.primaryColor,
                      ));
                    } else if (controller.error.isNotEmpty) {
                      return Center(child: Text(controller.error.value));
                    } else if (controller.generalTimeOffs.isEmpty) {
                      return const Center(
                          child: Text('Không có ngày nghỉ nào.'));
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.generalTimeOffs.length,
                        itemBuilder: (context, index) {
                          final dayOff = controller.generalTimeOffs[index];
                          return Dismissible(
                            key:
                                ValueKey(dayOff.id), // Unique key for each item
                            direction:
                                DismissDirection.endToStart, // Swipe direction
                            onDismissed: (direction) async {
                              await controller.deleteTimeOff(dayOff.id);
                              // Handle delete
                              Get.snackbar(
                                'Xóa thành công',
                                'Ngày nghỉ đã được xóa.',
                                snackPosition: SnackPosition.BOTTOM,
                              );
                              controller.refreshTimeOffs();
                            },
                            background: Container(
                              color: Colors.red,
                              alignment: Alignment.centerRight,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: const Icon(
                                Icons.delete,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                            child: InkWell(
                              onTap: () async {
                                await Get.to(
                                  () => GeneralTimeOffDetailScreen(
                                      generalTimeOff: dayOff),
                                );
                                // Refresh the list after returning
                                controller.refreshTimeOffs();
                              },
                              child: Card(
                                color: Colors.white,
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Text(
                                            'Lý do nghỉ: ${dayOff.reason}',
                                            style: const TextStyle(
                                              fontSize: 20,
                                              color: Color.fromARGB(
                                                  255, 18, 220, 68),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'Tổng số ngày nghỉ:',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            '${dayOff.sumDay}',
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Text(
                                            'Ghi chú: ${dayOff.note}',
                                            style:
                                                const TextStyle(fontSize: 14),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  }),
                ],
              ),
            ),
          )),
    );
  }

  Widget _buildSearchBar() {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        onChanged: (value) {},
        decoration: InputDecoration(
          hintText: 'Search...',
          prefixIcon: const Icon(Icons.search),
          contentPadding: const EdgeInsets.symmetric(vertical: 15.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }
}
