import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../size_config.dart';


class IconBtnWithCounter extends StatelessWidget {
    const IconBtnWithCounter({
    Key key,
    @required this.svgSrc,
    this.numOfitem = 0,
    @required this.press,
  }) : super(key: key);

  final String svgSrc;
  final int numOfitem;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {

    return Container(
            height: getProportionateScreenWidth(47),
            width: getProportionateScreenWidth(100),
            decoration: BoxDecoration(
                color: Color(0xFFFF7660),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: Offset(0, 2),)
                ]
            ),
            child: TextButton.icon(
              label: const Text("Scan",style: TextStyle(color: Colors.white),),
              icon: const ImageIcon(AssetImage("assets/icons/scan_icons.png",),color: Colors.white,),
              onPressed: (scanBarcode),
            ),
    );

  }
  Future<void> scanBarcode() async{
    FlutterBarcodeScanner.scanBarcode("#ff6666", "Cancel", true, ScanMode.BARCODE);

  }
}