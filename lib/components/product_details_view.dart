import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/home_constans.dart';
import 'package:shop_app/model/cart_view_item_model.dart';
import 'package:shop_app/model/product_model.dart';
import 'package:shop_app/services/cart_service.dart';
import 'package:shop_app/services/product_service.dart';
import 'package:shop_app/services/snackbar_service.dart';

class ProductDetailPage extends StatefulWidget {
  ProductModel product;

  ProductDetailPage({Key key, this.product}) : super(key: key);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage>
    with TickerProviderStateMixin {
  int quan = 1;
  bool _isloading = false;
  AnimationController controller;
  Animation<double> animation;

  List<String> childs;

  List<bool> tmp;
  String size_id;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    animation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeInToLinear));
    controller.forward();
    childs = widget.product.size.toString().split(",").toList();
    tmp = List.generate(childs.length, (index) => false);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  bool isLiked = true;

  Widget _appBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _icon(
            Icons.arrow_back_ios,
            color: Colors.black54,
            size: 15,
            padding: 12,
            isOutLine: true,
            onPressed: () {
              print("ge");
              Navigator.of(context).pop();
            },
          ),
          FutureBuilder(
              future: ProductService()
                  .CheckIfProdExistInWishlist(widget.product.id),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Text('');
                return IconButton(
                    onPressed: _isloading
                        ? null
                        : () async {
                            try {
                              setState(() {
                                _isloading = true;
                              });
                              var res = snapshot.data != 0
                                  ? await CartService()
                                      .deleteWishlist(snapshot.data['id'])
                                  : await CartService().addToWishlist(
                                      widget.product.id,
                                    );
                              SnackBarService()
                                  .showSnackBar(context, res.toString());
                            } catch (Err) {
                              SnackBarService()
                                  .showSnackBar(context, Err.toString());
                            } finally {
                              setState(() {
                                _isloading = false;
                              });
                            }
                          },
                    icon: Icon(
                        snapshot.data != 0
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: kPrimaryColor));
              })
        ],
      ),
    );
  }

  Widget _icon(
    IconData icon, {
    Color color = kPrimaryColor,
    double size = 20,
    double padding = 10,
    bool isOutLine = false,
    Function onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 40,
        width: 40,
        padding: EdgeInsets.all(padding),
        // margin: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          border: Border.all(
              color: kPrimaryColor,
              style: isOutLine ? BorderStyle.solid : BorderStyle.none),
          borderRadius: BorderRadius.all(Radius.circular(13)),
          color: isOutLine
              ? Colors.transparent
              : Theme.of(context).backgroundColor,
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Color(0xfff8f8f8),
                blurRadius: 5,
                spreadRadius: 10,
                offset: Offset(5, 5)),
          ],
        ),
        child: Icon(icon, color: color, size: size),
      ),
    );
  }

  Widget _productImage() {
    return SingleChildScrollView(
      child: AnimatedBuilder(
        builder: (context, child) {
          return AnimatedOpacity(
            duration: Duration(milliseconds: 500),
            opacity: animation.value,
            child: child,
          );
        },
        animation: animation,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            Text("AIP", style: TextStyle(fontSize: 160, color: Colors.black26)),
            Image.network(
                "$IMAGESURL${widget.product.image.toString().split(',')[0]}")
          ],
        ),
      ),
    );
  }

  Widget _categoryWidget() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0),
      width: MediaQuery.of(context).size.width,
      height: 80,
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.product.image
              .toString()
              .split(',')
              .map((x) => _thumbnail(x))
              .toList()),
    );
  }

  Widget _thumbnail(String image) {
    return AnimatedBuilder(
      animation: animation,
      //  builder: null,
      builder: (context, child) => AnimatedOpacity(
        opacity: animation.value,
        duration: Duration(milliseconds: 500),
        child: child,
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          height: 40,
          width: 50,
          decoration: BoxDecoration(
            border: Border.all(
              color: kPrimaryColor,
            ),
            borderRadius: BorderRadius.all(Radius.circular(13)),
            // color: Theme.of(context).backgroundColor,
          ),
          child: Image.network("$IMAGESURL$image"),
        ),
      ),
    );
  }

  Widget _detailWidget() {
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
              child: FutureBuilder(
                future:
                    ProductService().CheckIfProdExistInCart(widget.product.id),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                        child: CircularProgressIndicator(color: kPrimaryColor));
                  }
                  return Column(
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
                          snapshot.data != 0
                              ? IconButton(
                                  onPressed: () async {
                                    try {
                                      setState(() {
                                        _isloading = true;
                                      });
                                      CartViewItemModel cartItem =
                                          snapshot.data;
                                      var r = await CartService()
                                          .deleteCartProduct(cartItem.cartId);
                                      SnackBarService()
                                          .showSnackBar(context, "$r");
                                    } catch (err) {
                                      SnackBarService()
                                          .showSnackBar(context, "$err");
                                    } finally {
                                      setState(() {
                                        _isloading = false;
                                      });
                                    }
                                  },
                                  icon:
                                      Icon(Icons.remove_shopping_cart_outlined))
                              : Text('')
                        ],
                      )
                    ],
                  );
                },
              )),
        );
      },
    );
  }

  Widget singleSizeWidget(String text) {
    return Container(
      height: 35,
      width: 35,
      color: const Color(0xfff2f2f2),
      child: Center(child: Text(text)),
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
                size_id = childs[buttonIndex];
              } else {
                tmp[buttonIndex] = false;
              }
            }
          });
        },
        isSelected: tmp,
        children: childs.map((e) => singleSizeWidget(e)).toList());
  }

  Widget _availableSize() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Available Size",
          style: TextStyle(
            fontSize: 14,
          ),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _sizeWidget("US 6"),
            _sizeWidget("US 7", isSelected: true),
            _sizeWidget("US 8"),
            _sizeWidget("US 9"),
          ],
        )
      ],
    );
  }

  Widget _sizeWidget(String text, {bool isSelected = false}) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
            color: Colors.blue,
            style: !isSelected ? BorderStyle.solid : BorderStyle.none),
        borderRadius: BorderRadius.all(Radius.circular(13)),
        color: isSelected ? Colors.orange : Theme.of(context).backgroundColor,
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          color: isSelected ? Colors.yellow : Colors.black,
        ),
      ),
    );
  }

  Widget _availableColor() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Available Size", style: TextStyle(fontSize: 14)),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _colorWidget(Colors.yellow, isSelected: true),
            SizedBox(
              width: 30,
            ),
            _colorWidget(Colors.lightBlue),
            SizedBox(
              width: 30,
            ),
            _colorWidget(Colors.black),
            SizedBox(
              width: 30,
            ),
            _colorWidget(Colors.red),
            SizedBox(
              width: 30,
            ),
            _colorWidget(Colors.lightBlue),
          ],
        )
      ],
    );
  }

  Widget _quanBtns() {
    return Row(
      children: [
        IconButton(
            onPressed: () {
              setState(() {
                if (quan > 1) {
                  quan--;
                }
              });
            },
            icon: Icon(Icons.remove)),
        Text("$quan"),
        IconButton(
            onPressed: () {
              setState(() {
                quan++;
              });
            },
            icon: Icon(Icons.add))
      ],
    );
  }

  Widget _colorWidget(Color color, {bool isSelected = false}) {
    return CircleAvatar(
      radius: 12,
      backgroundColor: color.withAlpha(150),
      child: isSelected
          ? Icon(
              Icons.check_circle,
              color: color,
              size: 18,
            )
          : CircleAvatar(radius: 7, backgroundColor: color),
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

  _CartButton() {
    return Container(
      height: 50,
      child: MaterialButton(
        disabledColor: Colors.black26,
        onPressed: _isloading
            ? null
            : () async {
                try {
                  if (widget.product.size != null &&
                      childs.isNotEmpty &&
                      size_id == null) {
                    throw "Must select size";
                  }
                  setState(() {
                    _isloading = true;
                  });
                  var res = await CartService().addToCart({
                    "product_id": widget.product.id,
                    "quantity": quan,
                    "size_id": size_id,
                    "vendor_id": widget.product.vendor_id
                  });
                  SnackBarService().showSnackBar(context, res.toString());
                } catch (Err) {
                  SnackBarService().showSnackBar(context, Err.toString());
                } finally {
                  setState(() {
                    _isloading = false;
                  });
                }
              },
        color: Colors.orange,
        child: _isloading
            ? const Text(
                "Loading...",
                style: TextStyle(color: Colors.white, fontSize: 20),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.shopping_basket, color: Colors.white),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text("Add to cart",
                            style:
                                TextStyle(color: Colors.white, fontSize: 20)),
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _CartButton(),
      // floatingActionButton: _flotingCartButton(),
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Color(0xfffbfbfb),
              Color(0xfff7f7f7),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  _appBar(),
                  _productImage(),
                  _categoryWidget(),
                ],
              ),
              _detailWidget()
            ],
          ),
        ),
      ),
    );
  }
}
