class ProductModel {
  // "id": 1,
  // "categoryId": 1,
  // "name": "Momo",
  // "urlname": "momo-2",
  // "mrp": null,
  // "pricetag": 100,
  // "price": -20,
  // "discount": 120,
  // "description": "delicious",
  // "image": "HSsQJksLC42orehc0KNKoFuW3Dm40kN75nI19iXf.jpg,sjN46RzBbgfDTQLwD9DNcmOktJ9K6SvSTAcSPhFW.jpg",
  // "stock": 10,
  // "size": "M,S",
  // "colors": null,
  // "weight": 0,
  // "highlighted": "1",
  // "available": "1",
  // "status": 1,
  // "vendor_id": 1,
  // "created_at": "2022-03-12T04:14:10.000000Z",
  // "updated_at": "2022-03-28T14:10:17.000000Z"
  int id;
  String description;
  int categoryId;
  String name;
  int price;
  String image;
  String size;
  String colors;
  int vendor_id;

  ProductModel(
      {this.id,
      this.categoryId,
      this.name,
      this.price,
      this.image,
      this.size,
      this.colors,
      this.description,
      this.vendor_id});

  Map toMap(ProductModel product) {
    var res = {
      "id": product.id,
      "categoryId": product.categoryId,
      "description": product.description,
      "name": product.name,
      "price": product.price,
      "colors": product.colors,
      "size": product.size,
      "image": product.image,
      "vendor_id": product.vendor_id
    };
    return res;
  }

  ProductModel.fromMap(data)
      : id = data['id'],
        categoryId = data['categoryId'],
        description = data['description'],
        name = data['name'],
        image = data['image'],
        price = data['price'],
        colors = data['colors'],
        vendor_id = data['vendor_id'],
        size = data['size'];
}
