import 'package:flutter/material.dart';

import '../home_constans.dart';
import '../services/cart_service.dart';
import '../services/product_service.dart';
import '../services/snackbar_service.dart';

class DetailsWidget extends StatefulWidget {
  var product;
  var sizeSelectHandler;
  int quan;
  var quanIncHandler;
  var quanDecHandler;
bool enableCartDiscard=false;
var discardCartHandler;
  DetailsWidget(
      {Key key,
      this.product,
      this.sizeSelectHandler,
      this.quan,
      this.quanDecHandler,
      this.quanIncHandler,this.enableCartDiscard,this.discardCartHandler})
      : super(key: key);

  @override
  State<DetailsWidget> createState() => _DetailsWidgetState();
}

class _DetailsWidgetState extends State<DetailsWidget> {
  bool _isloading = false;
  List<String> childs;

  List<bool> tmp;
  String size_id;
  var inCartExist;

  @override
  void initState() {
    // TODO: implement initState
    childs = widget.product.size.toString().split(",").toList();
    tmp = List.generate(childs.length, (index) => false);
    // fetchDetails();
    super.initState();
  }

  // fetchDetails() async {
  //   try {
  //     setState(() {
  //       _isloading = true;
  //     });
  //     inCartExist =
  //         await ProductService().CheckIfProdExistInCart(widget.product.id);
  //   } catch (err) {
  //     SnackBarService().showSnackBar(context, "$err");
  //   } finally {
  //     setState(() {
  //       _isloading = false;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      maxChildSize: .8,
      initialChildSize: .53,
      minChildSize: .53,
      builder: (context, scrollController) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
              color: Colors.white),
          child: SingleChildScrollView(
              controller: scrollController,
              child: _isloading
                  ? const Center(
                  child: CircularProgressIndicator(color: kPrimaryColor))
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        SizedBox(height: 5),
                        Container(
                          alignment: Alignment.center,
                          child: Container(
                            width: 50,
                            height: 5,
                            decoration: BoxDecoration(
                                color: kPrimaryColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: Text("${widget.product.name}",
                                  style: TextStyle(fontSize: 25)),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text("\$",
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.red)),
                                    Text("${widget.product.price}",
                                        style: TextStyle(fontSize: 25)),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Icon(Icons.star,
                                        color: Colors.yellow, size: 17),
                                    Icon(Icons.star,
                                        color: Colors.yellow, size: 17),
                                    Icon(Icons.star,
                                        color: Colors.yellow, size: 17),
                                    Icon(Icons.star,
                                        color: Colors.yellow, size: 17),
                                    Icon(Icons.star_border, size: 17),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),

                        // _availableSize(),
                        // SizedBox(
                        //   height: 20,
                        // ),
                        // _availableColor(),

                        SizedBox(
                          height: 20,
                        ),
                        widget.product.size != null && childs.isNotEmpty
                            ? Row(
                                children: [
                                  const Text("Size"),
                                  sizeSelector(),
                                ],
                              )
                            : Text(''),
                        SizedBox(
                          height: 20,
                        ),
                        _description(),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _quanBtns(),
                          widget.enableCartDiscard
                                ? IconButton(
                                    onPressed: widget.discardCartHandler,
                                    icon: Icon(
                                        Icons.remove_shopping_cart_outlined))
                                : Text('')
                          ],
                        )
                      ],
                    )),
        );
      },
    );
  }

  Widget sizeSelector() {
    return ToggleButtons(
        selectedColor: kPrimaryColor,
        fillColor: kPrimaryColor,
        renderBorder: false,
        onPressed: (int index) {
          setState(() {
            for (int buttonIndex = 0; buttonIndex < tmp.length; buttonIndex++) {
              if (buttonIndex == index) {
                tmp[buttonIndex] = true;
                // size_id = childs[buttonIndex];
                widget.sizeSelectHandler(childs[buttonIndex]);
              } else {
                tmp[buttonIndex] = false;
              }
            }
          });
        },
        isSelected: tmp,
        children: childs.map((e) => singleSizeWidget(e)).toList());
  }

  Widget singleSizeWidget(String text) {
    return Container(
      height: 35,
      width: 35,
      color: const Color(0xfff2f2f2),
      child: Center(child: Text(text)),
    );
  }

  Widget _description() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Description",
          style: TextStyle(
            fontSize: 14,
          ),
        ),
        SizedBox(height: 20),
        Text(widget.product.description),
      ],
    );
  }

  Widget _quanBtns() {
    return Row(
      children: [
        IconButton(
            onPressed: () {
              widget.quanDecHandler();
            },
            icon: Icon(Icons.remove)),
        Text("${widget.quan}"),
        IconButton(
            onPressed: () {
              widget.quanIncHandler();
            },
            icon: Icon(Icons.add))
      ],
    );
  }
}
