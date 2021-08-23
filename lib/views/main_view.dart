import 'package:auto_route/auto_route.dart';
import 'package:basics_samples/l10n/locale_keys.dart';
import 'package:basics_samples/navigation/app_router.gr.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class MainView extends StatelessWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: const [
        HomeTab(),
        ProfileTab(),
      ],
      builder: (context, child, animation) => child,
      bottomNavigationBuilder: _buildBottomNavigationBar,
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context, TabsRouter tabsRouter) {
    return BottomNavigationBar(
      selectedItemColor: Colors.orange,
      backgroundColor: const Color(0xFF494949),
      iconSize: 28,
      currentIndex: tabsRouter.activeIndex,
      onTap: (index) {
        // if the tapped tab is the current one, pop all pushed routes of this tab
        if (index == tabsRouter.activeIndex) {
          tabsRouter.popTop();
        } else {
          tabsRouter.setActiveIndex(index);
        }
      },
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: LocaleKeys.views_home.tr()),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: LocaleKeys.views_profile.tr()),
      ],
    );
  }
}
