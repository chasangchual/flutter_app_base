import 'package:app_base/controller/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        extendBody: MainController.to.extendBody,
        body: MainScreenBody(),
        bottomNavigationBar: _buildBottomNavigationBar(context),
      );
    });
  }
}

class MainScreenBody extends StatelessWidget {
  const MainScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: Placeholder(),
        bottom: !MainController.to.extendBody,
      ),
    );
  }
}

Widget _buildBottomNavigationBar(BuildContext context) {
  return Container(
    child: BottomNavigationBar(items: bottomNavigationItems(context)),
  );
}

List<BottomNavigationBarItem> bottomNavigationItems(BuildContext context) {
  return [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.help), label: 'Help')
  ];
}

//
// enum TabItem {
//   home(Icons.home, '홈', Container()),
//   favorite(Icons.star, '즐겨찾기', const Container());
//
//   final IconData activeIcon;
//   final IconData inActiveIcon;
//   final String tabName;
//   final Widget firstPage;
//
//   const TabItem(this.activeIcon, this.tabName, this.firstPage, {IconData? inActiveIcon})
//       : inActiveIcon = inActiveIcon ?? activeIcon;
//
//   BottomNavigationBarItem toNavigationBarItem(BuildContext context, {required bool isActivated}) {
//     return BottomNavigationBarItem(
//         icon: Icon(
//           key: ValueKey(tabName),
//           isActivated ? activeIcon : inActiveIcon,
//           color:
//           isActivated ? context.appColors.iconButton : context.appColors.iconButtonInactivate,
//         ),
//         label: tabName);
//   }
// }
