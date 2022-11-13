import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

PreferredSizeWidget getIndexAppbar() {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    leading: Builder(builder: (context) {
      return IconButton(
        icon: SvgPicture.asset(
          'assets/icons/hambergur.svg',
          color: const Color(0xff212121),
        ),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      );
    }),
  );
}
