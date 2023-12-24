import 'package:flutter/material.dart';
import 'package:thimar_app_g3/views/home_nav/pages/favorites.dart';
import 'package:thimar_app_g3/views/home_nav/pages/home.dart';
import 'package:thimar_app_g3/views/home_nav/pages/my_account.dart';
import 'package:thimar_app_g3/views/home_nav/pages/my_orders.dart';
import 'package:thimar_app_g3/views/home_nav/pages/notifications.dart';

class HomeNavView extends StatefulWidget {
  const HomeNavView({Key? key}) : super(key: key);

  @override
  State<HomeNavView> createState() => _HomeNavViewState();
}

class _HomeNavViewState extends State<HomeNavView> {

  int currentPage = 0;

  final pages = [
    HomePage(),
    MyOrdersPage(),
    NotificationsPage(),
    FavoritesPage(),
    MyAccountPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentPage],
    );
  }
}
