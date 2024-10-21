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
  return NavigationTabItem.values.map((item) => item.toBottomNavigationBarItem(context, isActivated: false)).toList();
}

enum NavigationTabItem {
  home(Icons.home, 'Home', Placeholder()),
  help(Icons.help, 'Help', Placeholder());

  final IconData activeIcon;
  final IconData inActiveIcon;
  final String name;
  final Widget initialPage;

  const NavigationTabItem(this.activeIcon, this.name, this.initialPage, {IconData? inActiveIcon})
      : inActiveIcon = inActiveIcon ?? activeIcon;

  BottomNavigationBarItem toBottomNavigationBarItem(BuildContext context, {required bool isActivated}) {
    return BottomNavigationBarItem(
        icon: Icon(
          key: ValueKey(name),
          isActivated ? activeIcon : inActiveIcon,
          color: isActivated
              ? MainController.to.themeColors.iconButton
              : MainController.to.themeColors.iconButtonInactivate,
        ),
        label: name);
  }
}
