class CategoryModel {
  // "id": 1,
  // "parentId": null,
  // "title": "Food",
  // "urltitle": "food",
  // "description": "Good for health",
  // "icon": "YUoLm4rsycfx7aNiApUTJnScUoAl4dP04FJGKPV8.png",
  // "status": 1,
  // "created_at": "2022-03-12T04:13:29.000000Z",
  // "updated_at": "2022-03-24T15:02:15.000000Z"

  int id;
  int pareintId;
  String title;
  String urltitle;
  String description;
  String icon;

  CategoryModel(
      {this.id,
      this.pareintId,
      this.title,
      this.urltitle,
      this.description,
      this.icon});

  CategoryModel.fromMap(data)
      : id = data['id'],
        pareintId = data['parentId'],
        description = data['description'],
        title = data['title'],
        urltitle = data['urltitle'],
        icon = data['icon'];
}
