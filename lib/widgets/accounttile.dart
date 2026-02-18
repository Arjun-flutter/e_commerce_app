import 'package:flutter/material.dart';

Widget settingTile(IconData icon, String title, bool activate, VoidCallback onTap) {
  return Container(
    margin: EdgeInsets.only(bottom: 8),
    decoration: BoxDecoration(
      color: Colors.grey[100],
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      children: [
        ListTile(
          leading: Icon(
            icon,
            color: activate ? Colors.orange : Colors.grey,
            size: 20,
          ),
          title: Text(
            title, 
            style: TextStyle(
              fontSize: 15
              )
              ),
          trailing: Icon(
            Icons.arrow_forward_ios,
             size: 15
             ),
          onTap: onTap,
        ),
        Divider(height: 1),
      ],
    ),
  );
}
