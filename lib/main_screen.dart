import 'package:app_base/controller/app_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sidebarx/sidebarx.dart';

class MainScreen extends StatelessWidget {
  final _controller = SidebarXController(selectedIndex: 0, extended: true);

  MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
          extendBody: AppController.to.extendBody,
          body: const MainScreenBody(),
          bottomNavigationBar: _buildBottomNavigationBar(context),
          drawer: ExampleSidebarX(controller: _controller));
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

class ExampleSidebarX extends StatelessWidget {
  static const primaryColor = Color(0xFF685BFF);
  static const canvasColor = Color(0xFF2E2E48);
  static const scaffoldBackgroundColor = Color(0xFF464667);
  static const accentCanvasColor = Color(0xFF3E3E61);
  static const white = Colors.white;

  final actionColor = Color(0xFF5F5FA7).withOpacity(0.6);
  final divider = Divider(color: white.withOpacity(0.3), height: 1);

  ExampleSidebarX({
    Key? key,
    required SidebarXController controller,
  })  : _controller = controller,
        super(key: key);

  final SidebarXController _controller;

  @override
  Widget build(BuildContext context) {
    return SidebarX(
      controller: _controller,
      theme: SidebarXTheme(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: canvasColor,
          borderRadius: BorderRadius.circular(20),
        ),
        hoverColor: scaffoldBackgroundColor,
        textStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
        selectedTextStyle: const TextStyle(color: Colors.white),
        hoverTextStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
        itemTextPadding: const EdgeInsets.only(left: 30),
        selectedItemTextPadding: const EdgeInsets.only(left: 30),
        itemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: canvasColor),
        ),
        selectedItemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: actionColor.withOpacity(0.37),
          ),
          gradient: const LinearGradient(
            colors: [accentCanvasColor, canvasColor],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.28),
              blurRadius: 30,
            )
          ],
        ),
        iconTheme: IconThemeData(
          color: Colors.white.withOpacity(0.7),
          size: 20,
        ),
        selectedIconTheme: const IconThemeData(
          color: Colors.white,
          size: 20,
        ),
      ),
      extendedTheme: const SidebarXTheme(
        width: 200,
        decoration: BoxDecoration(
          color: canvasColor,
        ),
      ),
      footerDivider: divider,
      headerBuilder: (context, extended) {
        return SizedBox(
          height: 100,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset('assets/images/avatar.png'),
          ),
        );
      },
      items: [
        SidebarXItem(
          icon: Icons.home,
          label: 'Home',
          onTap: () {
            debugPrint('Home');
          },
        ),
        const SidebarXItem(
          icon: Icons.search,
          label: 'Search',
        ),
        const SidebarXItem(
          icon: Icons.people,
          label: 'People',
        ),
        SidebarXItem(
          icon: Icons.favorite,
          label: 'Favorites',
          selectable: false,
          onTap: () => _showDisabledAlert(context),
        ),
        const SidebarXItem(
          iconWidget: FlutterLogo(size: 20),
          label: 'Flutter',
        ),
      ],
    );
  }

  void _showDisabledAlert(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Item disabled for selecting',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}
