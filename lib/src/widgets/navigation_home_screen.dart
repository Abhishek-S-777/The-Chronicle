import 'package:thechronicle/src/Orders/myOrders.dart';
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

class NavigationHomeScreen extends StatefulWidget {
  @override
  _NavigationHomeScreenState createState() => _NavigationHomeScreenState();
}

class _NavigationHomeScreenState extends State<NavigationHomeScreen> {
  Widget screenView;
  DrawerIndex drawerIndex;

  @override
  void initState() {
    drawerIndex = DrawerIndex.HOME;
    screenView =  MainPage();
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
          body: DrawerUserController(
            screenIndex: drawerIndex,
            drawerWidth: MediaQuery.of(context).size.width * 0.75,
            onDrawerCall: (DrawerIndex drawerIndexdata) {
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

  void changeIndex(DrawerIndex drawerIndexdata) {
    if (drawerIndex != drawerIndexdata) {
      drawerIndex = drawerIndexdata;
      if (drawerIndex == DrawerIndex.HOME) {
        setState(() {
          screenView =  MainPage();
        });
      }
      // else if (drawerIndex == DrawerIndex.Help) {
      //   setState(() {
      //     // screenView = HelpScreen();
      //   });
      // }
      else if (drawerIndex == DrawerIndex.MyOrders) {
        setState(() {
          screenView = MyOrders();
        });
      }
      else if (drawerIndex == DrawerIndex.Settings) {
        setState(() {
          screenView = ProfilePage();
        });
      }
      else if (drawerIndex == DrawerIndex.About) {
        setState(() {
          // screenView = ProfilePage();
        });
      }
      else {
        //do in your way......
      }
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
