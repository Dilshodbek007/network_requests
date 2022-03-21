
class User {
  // String phone1;
  // String phone2;
  // String phone3;
  // String phone4;
  String phone;
  User(this.phone);

  User.fromJson(Map<String, dynamic> json)
      :phone = json['phone'];

  Map<String, dynamic> toJson() => {
    'phone': phone
  };
}
