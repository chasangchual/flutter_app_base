import 'package:app_base/controller/app_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        extendBody: AppController.to.extendBody,
        body: const MainScreenBody(),
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
        bottom: !AppController.to.extendBody,
        child: const Placeholder(),
      ),
    );
  }
}

Widget _buildBottomNavigationBar(BuildContext context) {
  return Container(
    child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, showUnselectedLabels: true, items: bottomNavigationItems(context)),
  );
}

List<BottomNavigationBarItem> bottomNavigationItems(BuildContext context) {
  return NavigationTabItem.values.map((item) => item.toBottomNavigationBarItem(context, isActivated: true)).toList();
}

enum NavigationTabItem {
  home(
      Icons.home_filled,
      'Home',
      Center(
        child: Text('Home'),
      )),
  user(
      Icons.verified_user,
      'User',
      Center(
        child: Text('User'),
      )),
  help(Icons.help, 'Help', Center(child: Text('Help'))),
  more(Icons.more_horiz, 'More', Center(child: Text('More')));

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
          color:
              isActivated ? AppController.to.themeColors.iconButton : AppController.to.themeColors.iconButtonInactivate,
        ),
        label: name,
        tooltip: name);
  }
}
