import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/components/product_details_view.dart';
import 'package:shop_app/components/product_single_view.dart';
import 'package:shop_app/model/product_model.dart';
import 'package:shop_app/screens/details/details_screen.dart';
import 'package:shop_app/services/product_service.dart';
import 'package:shop_app/services/snackbar_service.dart';
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
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 2,
              offset: Offset(0, 2),
            )
          ]),
      child: TextButton.icon(
        label: const Text(
          "Scan",
          style: TextStyle(color: Colors.white),
        ),
        icon: const ImageIcon(
          AssetImage(
            "assets/icons/scan_icons.png",
          ),
          color: Colors.white,
        ),
        onPressed:  (){
          scanBarcode(context);
      },
      ),
    );
  }

  Future<void> scanBarcode(context) async {
    var res = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666", "Cancel", true, ScanMode.QR);
   if(res==null || res=='') return SnackBarService().showSnackBar(context, "No result found");
   print(res);
    var id=res.toString().split('/').removeLast();
   ProductModel result= await ProductService().fetchProductUsingId(id);
    if(result==null) return SnackBarService().showSnackBar(context, "No result found");
     Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductDetailPage(product: result)));
  }
}
