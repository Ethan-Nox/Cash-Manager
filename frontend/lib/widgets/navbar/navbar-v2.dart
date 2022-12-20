import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/providers/navbar_provider.dart';
import 'package:provider/provider.dart';

class MyNavBar extends StatelessWidget {
  const MyNavBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Color primary = const Color(0xFF7c2bfb);
    Color primaryFade = const Color(0x667c2bfb);

    Color secondary = const Color(0xFFb737cc);
    Color secondaryFade = const Color(0x66b737cc);
    return (ConvexAppBar(
      backgroundColor: const Color(0xFFFFFFFF),
      initialActiveIndex: 1,
      items: [
        TabItem(
          icon: Container(
            transform: Matrix4.translationValues(0.0, -10.0, 0.0),
            child: const Icon(Icons.search,
                size: 25, color: Color(0x667c2bfb)),
          ),
          activeIcon: Container(
            transform: Matrix4.translationValues(0.0, -10.0, 0.0),
            child: const Icon(
              Icons.search,
              size: 25,
              color: Color(0xFF7c2bfb),
            ),
          ),
        ),

        TabItem(
          icon: Container(
            transform: Matrix4.translationValues(0.0, -5.0, 0.0),
            child: Transform.scale(
              scale: 1.5,
              // child: Image.asset(
              //   'assets/images/logo-charge.png',
              //   color: Colors.white.withOpacity(0.5),
              //   colorBlendMode: BlendMode.modulate,
              child: const Icon(Icons.shopping_cart,
                  size: 25, color: Color(0x667c2bfb)),
            ),
          ),
          // activeIcon: Container(
          //   transform: Matrix4.translationValues(-5.0, 0.0, 0.0),
          //   child: Transform.scale(
          //     scale: 1.5,
          //     child: const Icon(Icons.calendar_month_outlined,
          //         size: 25, color: Color(0x667c2bfb)),
          //   ),
          // ),
          activeIcon: Container(
            transform: Matrix4.translationValues(0.0, -5.0, 0.0),
            child: Transform.scale(
              scale: 1.5,
              child: const Icon(
                Icons.shopping_cart,
                size: 25,
                color: Color(0xFF7c2bfb),
              ),
            ),
          ),
        ),
        // TabItem(
        //     icon: Container(
        //       transform: Matrix4.translationValues(0.0, -10.0, 0.0),
        //       child: const Icon(Icons.message_outlined,
        //           size: 25, color: Color(0x667c2bfb)),
        //     ),
        //     activeIcon: Container(
        //         transform: Matrix4.translationValues(0.0, -10.0, 0.0),
        //         child: const Icon(
        //           Icons.message,
        //           size: 25,
        //           color: Color(0xFF7c2bfb),
        //         ))),
        TabItem(
          icon: Container(
            transform: Matrix4.translationValues(0.0, -10.0, 0.0),
            child: const Icon(Icons.person_outline,
                size: 25, color: Color(0x667c2bfb)),
          ),
          activeIcon: Container(
            transform: Matrix4.translationValues(0.0, -10.0, 0.0),
            child: const Icon(
              Icons.person,
              size: 25,
              color: Color(0xFF7c2bfb),
            ),
          ),
        ),
      ],
      onTap: (int i) =>
          Provider.of<NavBarProvider>(context, listen: false).changePage(i),
      style: TabStyle.fixed,
    ));
  }
}
