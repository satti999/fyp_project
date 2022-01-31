import 'package:flutter/material.dart';
class SelectSize extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Size",style: TextStyle(fontSize: 14,color: Colors.black),),
          SizedBox(height: 5,),
          Container(
            width: 180,
            child: Row(
              children: [
                Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                      color:const Color(0xfff2f2f2),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: Colors.redAccent),
                      boxShadow: [
                        BoxShadow(color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset(0, 1),)
                      ]
                  ),

                  child: const Center(
                    child: Text("S"),
                  ),
                ),
                const SizedBox(width: 5,),
                Container(
                  height: 35,
                  width: 35,
                  decoration:  BoxDecoration(
                      color: const  Color(0xfff2f2f2),
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: const  Offset(0, 1),)
                      ]
                  ),
                  child: const Center(
                    child: Text("M",),
                  ),
                ),
                const  SizedBox(width: 5,),
                Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                      color: const  Color(0xfff2f2f2),
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset(0, 1),)
                      ]
                  ),
                  child: const Center(
                    child: Text("L",),
                  ),
                ),
                const  SizedBox(width: 5,),
                Container(
                  height: 35,
                  width: 35,
                  decoration:  BoxDecoration(
                      color: const  Color(0xfff2f2f2),
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset(0, 1),)
                      ]
                  ),
                  child: const Center(
                    child: Text("XL",),
                  ),
                )

              ],
            ),

          )

        ],


      ),


    );
  }
}
