import 'package:flutter/material.dart';
import 'package:hrm_aqtech/utils/constants/colors.dart';
import 'package:hrm_aqtech/utils/constants/enums.dart';
import 'package:hrm_aqtech/utils/devices/device_utils.dart';

class MyTabbar extends StatelessWidget implements PreferredSizeWidget {
  const MyTabbar({super.key, this.onTap, required this.tabs});

  final ValueChanged<int>? onTap;
  final List<Widget> tabs;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: TabBar(
        onTap: onTap,
        tabs: tabs,
        isScrollable: true,
        indicatorColor: MyColors.accentColor,
        labelColor: MyColors.primaryTextColor,
        unselectedLabelColor: Colors.grey,
        tabAlignment: TabAlignment.start,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(MyDeviceUtils.getAppBarHeight());
}
