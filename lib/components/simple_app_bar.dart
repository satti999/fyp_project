import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

AppBar buildSimpleAppBar(BuildContext context, String title,{bool searchbar=true}) {
  return AppBar(
    title: Text(
      "${title}",
      style: const TextStyle(color: Colors.black54),
    ),
    centerTitle: true,
    backgroundColor: Colors.white,
    elevation: 0.4,
    leading: IconButton(
      icon: SvgPicture.asset(
        "assets/icons/Back ICon.svg",
        color: Colors.black54,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    ),
    actions:  [
      !searchbar? const Text('') : IconButton(onPressed: null, icon: Icon(Icons.search)),
    ],
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(16))),
  );
}
