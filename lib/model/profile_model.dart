class ProfileModel {
  // {data: {id: 17, name: user demo, email: userdemo@gmail.com, email_verified_at: null, address: null, contact: 03323537811, social_id: null, photo: null, dob: null, gender: null, zip_code: null, state: null, city: null, country: null, phone: null, created_at: 2022-04-11T15:03:31.000000Z, updated_at: 2022-04-11T15:03:31.000000Z}}
  String name;
  String email;
  String address;
  String contact;
String country;
String state;
String city;
  ProfileModel({this.name, this.email, this.address, this.contact,this.city,this.country,this.state});

  factory ProfileModel.fromMap(data) {
    return ProfileModel(
        name: data['name'],
        address: data['address'],
        email: data['email'],
        city: data['city'],
        country: data['country'],
        state: data['state'],
        contact: data['contact']);
  }
}
