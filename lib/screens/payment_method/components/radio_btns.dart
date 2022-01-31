class User {
  int userId;
  String firstName;

  User({this.userId, this.firstName});

  static List<User> getUsers() {
    return <User>[
      User(userId: 1, firstName: "Bank Transfer", ),
      User(userId: 2, firstName: "Internet Banking",),
      User(userId: 3, firstName: "Cash on delivery", ),
      User(userId: 4, firstName: "Paypal",),
    ];
  }
}