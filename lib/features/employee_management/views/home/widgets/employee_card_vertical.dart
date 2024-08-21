import 'package:flutter/material.dart';
import 'package:hrm_aqtech/common/styles/shadows.dart';
import 'package:hrm_aqtech/common/widgets/images/circular_image.dart';
import 'package:hrm_aqtech/utils/constants/image_paths.dart';
import 'package:hrm_aqtech/utils/constants/sizes.dart';

class EmployeeCardVertical extends StatelessWidget {
  const EmployeeCardVertical({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      decoration: BoxDecoration(
          boxShadow: [MyShadows.verticalProductShadow],
          color: Colors.white,
          borderRadius: BorderRadius.circular(MySizes.borderRadiusMd)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Avatar and name
          Row(
            children: [
              // Avatar
              const MyCircularImage(image: MyImagePaths.defaultUser),
              // Name
              Column(
                children: [
                  Text(
                    "Nguyen Van A",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(MySizes.sm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 2, Email
                Text.rich(
                  textAlign: TextAlign.left,
                  TextSpan(
                      text: "Email: ",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(
                            text: 'abc@gmail.com',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .apply(fontStyle: FontStyle.italic))
                      ]),
                ),

                // 3. role
                Text.rich(
                  textAlign: TextAlign.left,
                  TextSpan(
                      text: "Chức vụ: ",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(
                            text: 'Developer',
                            style: Theme.of(context).textTheme.bodySmall)
                      ]),
                ),
              ],
            ),
          )
          
        ],
      ),
    );
  }
}
