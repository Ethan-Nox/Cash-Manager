import 'package:flutter/material.dart';

class UserAccountList extends StatelessWidget {
  final Function()? onTap;
  final String title;
  final String config;

  const UserAccountList({
    super.key,
    required this.onTap,
    required this.title,
    required this.config,
  });
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.0),
          side: const BorderSide(
              width: 1, // thickness
              color: Color.fromARGB(255, 221, 221, 221) // color
              ),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(color: Colors.black),
          ), // <-- Text
          // SizedBox(
          //   width: 5,
          // ),

          IconButton(
            icon: const Icon(
              Icons.arrow_forward_ios,
              size: 24.0,
              color: Color.fromARGB(255, 139, 139, 139),
            ),
            tooltip: "Voir plus",
            onPressed: onTap,
          ),
        ],
      ),
    );
  }
}
