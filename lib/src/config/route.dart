import 'package:flutter/material.dart';
import 'package:thechronicle/src/Admin/adminHome.dart';
import 'package:thechronicle/src/Admin/adminManageProducts.dart';
import 'package:thechronicle/src/Admin/adminShiftOrders.dart';
import 'package:thechronicle/src/Admin/adminlogin.dart';
import 'package:thechronicle/src/chroniclehero/cherologin.dart';
import 'package:thechronicle/src/chroniclehero/hero_navigation_home_screen.dart';
import 'package:thechronicle/src/model/wrapper.dart';
import 'package:thechronicle/src/pages/cart.dart';
import 'package:thechronicle/src/pages/home_page.dart';
import 'package:thechronicle/src/pages/login.dart';
import 'package:thechronicle/src/pages/mainPage.dart';
import 'package:thechronicle/src/pages/product_detail.dart';
import 'package:thechronicle/src/pages/shopping_cart_page.dart';
import 'package:thechronicle/src/pages/signup.dart';
import 'package:thechronicle/src/pages/test.dart';
import 'package:thechronicle/src/widgets/capturecamera.dart';
import 'package:thechronicle/src/widgets/navigation_home_screen.dart';
// import 'package:irespawn/src/pages/cherologin.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoute() {
    return <String, WidgetBuilder>{

      'signup': (context) => Signup(),
      'test':(context) => test(),
      'navidrawer':(context) => NavigationHomeScreen(),
      'heronavidrawer':(context) => HeroNavigationHomeScreen(),
      'Login': (context) => Login(),
      'HeroLogin': (context) => HeroLogin(),
      'AdminLogin1': (context) => AdminLogin1(),
      'AdminHome': (context) => AdminHome(),
      'ManageProducts': (context) => ManageProducts(),



      'AdminShiftOrders' : (context) => AdminShiftOrders(),
      'Shopping': (context) => ShoppingCartPage(),
      'Main': (context) => MainPage(),
      'Home': (context) => MyHomePage(),
      'detail': (context) => ProductDetailPage(),
      'CartPage': (context) => CartPage(),

      //making the first page as the wrapper page..
      // '/': (_) => Wrapper(),
      //// '/': (_) => MainPage() should not be included as the home property is specified in the main.dart file...
      // '/': (_) => MainPage(),
      // '/detail': (_) => ProductDetailPage()
    };
  }
}
