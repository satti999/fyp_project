class CartViewItemModel {
  String productName;
  int product_id;
  String image;
  int quantity;
  int price;
  int cartId;
  String size_id;

  CartViewItemModel(this.productName, this.product_id, this.image,
      this.quantity, this.price, this.cartId, this.size_id);

  CartViewItemModel.fromMap(data)
      : productName = data['p_name'],
        image = data['image'],
        product_id = data['product_id'],
        quantity = data['quantity'],
        price = data['price'],
        size_id = data['size_id'],
        cartId = data['c_id'];

// {
// "cart_items": [
// {
// "p_name": "Jasmine Bullock",
// "image": "HSsQJksLC42orehc0KNKoFuW3Dm40kN75nI19iXf.jpg",
// "quantity": 25,
// "mrp": null,
// "pricetag": 200,
// "price": 200,
// "discount": null,
// "c_id": 1,
// "size_id": null
// },
// {
// "p_name": "Jasmine Bullock",
// "image": "i8ldNJbOBFERGgtk6LtFlaA22OmPqP6rh7jYiFzt.webp",
// "quantity": 3,
// "mrp": null,
// "pricetag": 772,
// "price": 134,
// "discount": 638,
// "c_id": 2,
// "size_id": null
// },
// {
// "p_name": "Playstation 4",
// "image": "KKcImY8ApU2ERqLl5iDBf5veACAOq0fBz9mNlmSU.jpg",
// "quantity": 1,
// "mrp": null,
// "pricetag": 50000,
// "price": -15000,
// "discount": 65000,
// "c_id": 5,
// "size_id": null
// }
// ]
// }

}
