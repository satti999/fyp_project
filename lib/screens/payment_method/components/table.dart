import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class Cart_Detail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        margin: const EdgeInsets.only(top: 10,left: 5),

        child:  Table(
            children: const [TableRow
              (children: [Text("Product Name",style: TextStyle(fontSize: 20,),),Text(" "),Text(" "),Text("\$ 200",style: TextStyle(fontSize: 18, fontWeight:FontWeight.bold))]),
              TableRow(children: [Text(""),Text(" "),Text(" "),Text("")]),
              TableRow(children: [Text(""),Text(" "),Text(" "),Text("")]),
              TableRow(children: [Text("Delivery Fee",style: TextStyle(fontSize: 20,)),Text(" "),Text(" "),Text("\$ 100",style: TextStyle(fontSize: 18, fontWeight:FontWeight.bold))]),
              TableRow(children: [Text(""),Text(" "),Text(" "),Text("")]),
              TableRow(children: [Text(""),Text(" "),Text(" "),Text("")]),
              TableRow(children: [Text("Total:",style: TextStyle(fontSize: 20, fontWeight:FontWeight.bold)),Text(" "),Text(" "),Text("\$ 400",style: TextStyle(fontSize: 18, fontWeight:FontWeight.bold))])

            ]),
      ),
    );
  }
}
