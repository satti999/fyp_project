// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:shop_app/screens/home/home_screem.dart';
//
// import '../../../size_config.dart';
//
// class Categories extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     List<Map<String, dynamic>> categories = [
//       {"icon": "assets/icons/garment_icon.svg", "text": "Garments",},
//       {"icon": "assets/icons/electronics_icon.svg", "text": "Electronics"},
//       {"icon": "assets/icons/cosmetics_icon.svg", "text": "Cosmetic"},
//       {"icon": "assets/icons/cosmetics_icon.svg", "text": "Cosmetic"}
//
//     ];
//     return Padding(
//       padding: EdgeInsets.all(getProportionateScreenWidth(20)),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: List.generate(
//           categories.length,
//               (index) => CategoryCard(
//             icon: categories[index]["icon"],
//             text: categories[index]["text"],
//             press: () {},
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class CategoryCard extends StatelessWidget {
//   const CategoryCard({
//     Key key,
//     @required this.icon,
//     @required this.text,
//     @required this.press,
//   }) : super(key: key);
//
//   final String icon, text;
//   final GestureTapCallback press;
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: press,
//       child: SizedBox(
//         width: getProportionateScreenWidth(105),
//         child: Column(
//           children: [
//             Container(
//               height: getProportionateScreenWidth(47),
//               width: getProportionateScreenWidth(105),
//               decoration: BoxDecoration(
//                 color: Color(0xFFF5F5F5),
//                 borderRadius: BorderRadius.circular(10),
//                 boxShadow: [
//                   BoxShadow(color: Colors.grey.withOpacity(0.2),
//                     spreadRadius: 1,
//                     blurRadius: 1,
//                     offset: Offset(0, 1),)
//                 ]
//               ),
//               child:TextButton.icon(
//                 label: Text(text,style: TextStyle(fontSize: 11,fontWeight:FontWeight.w300,color:Colors.black54),),
//                 icon: SvgPicture.asset(icon),
//                 onPressed: (){
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => HomeScreen() ),
//                   );
//
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
