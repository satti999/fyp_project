import 'package:flutter/material.dart';

import 'cart_counter.dart';

class CounterWithFavBtn extends StatelessWidget {
  const CounterWithFavBtn({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        CartCounter(),
        // Container(
        //
        //   height: 38,
        //   width: 38,
        //   decoration: const BoxDecoration(
        //     color: Color(0xFFFF6464),
        //     shape: BoxShape.circle,
        //   ),
        //   child: const IconButton(
        //     icon: Icon(Icons.favorite,color: Colors.white,),
        //     onPressed: null,
        //   ),
        //
        // )
      ],
    );
  }
}
