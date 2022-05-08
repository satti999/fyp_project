import 'package:flutter/material.dart';
import 'package:shop_app/model/Product.dart';

import '../../../constants.dart';

class Description extends StatelessWidget {
  const Description({
    Key key,
    @required this.description,
  }) : super(key: key);

  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin),
      child: Text(
        description,
        style: const TextStyle(height: 1.5),
      ),
    );
  }
}
