import 'package:thechronicle/src/Orders/myOrders.dart';
import 'package:thechronicle/src/chroniclehero/heroMainPage.dart';
import 'package:thechronicle/src/chroniclehero/hero_drawer_user_controller.dart';
import 'package:thechronicle/src/chroniclehero/hero_home_drawer.dart';
import 'package:thechronicle/src/pages/home_page.dart';
import 'package:thechronicle/src/pages/mainPage.dart';
import 'package:thechronicle/src/pages/userprofilepage.dart';
import 'package:thechronicle/src/themes/app_theme.dart';
import 'package:thechronicle/src/custom_drawer/drawer_user_controller.dart';
import 'package:thechronicle/src/custom_drawer/home_drawer.dart';
// import 'package:best_flutter_ui_templates/feedback_screen.dart';
// import 'package:best_flutter_ui_templates/help_screen.dart';
// import 'package:best_flutter_ui_templates/home_screen.dart';
// import 'package:best_flutter_ui_templates/invite_friend_screen.dart';
import 'package:flutter/material.dart';

class HeroNavigationHomeScreen extends StatefulWidget {
  @override
  _HeroNavigationHomeScreenState createState() => _HeroNavigationHomeScreenState();
}

class _HeroNavigationHomeScreenState extends State<HeroNavigationHomeScreen> {
  Widget screenView;
  HomeDrawerIndex drawerIndex;

  @override
  void initState() {
    drawerIndex = HomeDrawerIndex.HOME;
    screenView =  HeroMainPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.nearlyWhite,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: AppTheme.nearlyWhite,
          body: HeroDrawerUserController(
            screenIndex: drawerIndex,
            drawerWidth: MediaQuery.of(context).size.width * 0.75,
            onDrawerCall: (HomeDrawerIndex drawerIndexdata) {
              changeIndex(drawerIndexdata);
              //callback from drawer for replace screen as user need with passing DrawerIndex(Enum index)
            },
            screenView: screenView,
            //we replace screen view as we need on navigate starting screens like MyHomePage, HelpScreen, FeedbackScreen, etc...
          ),
        ),
      ),
    );
  }

  void changeIndex(HomeDrawerIndex drawerIndexdata) {
    if (drawerIndex != drawerIndexdata) {
      drawerIndex = drawerIndexdata;
      if (drawerIndex == HomeDrawerIndex.HOME) {
        setState(() {
          screenView =  HeroMainPage();
        });
      }

      // else if (drawerIndex == DrawerIndex.Help) {
      //   setState(() {
      //     // screenView = HelpScreen();
      //   });
      // }
      // else if (drawerIndex == DrawerIndex.MyOrders) {
      //   setState(() {
      //     screenView = MyOrders();
      //   });
      // }

      else if (drawerIndex == HomeDrawerIndex.Settings) {
        setState(() {
          screenView = ProfilePage();
        });
      }
      // else if (drawerIndex == DrawerIndex.About) {
      //   setState(() {
      //     // screenView = ProfilePage();
      //   });
      // }

      // else if (drawerIndex == DrawerIndex.FeedBack) {
      //   setState(() {
      //     // screenView = FeedbackScreen();
      //   });
      // }
      // else if (drawerIndex == DrawerIndex.Invite) {
      //   setState(() {
      //     // screenView = InviteFriend();
      //   });
      // }
    }
  }
}
