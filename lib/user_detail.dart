
class User {
  String phone;
  User(this.phone);

  User.fromJson(Map<String, dynamic> json)
      :phone = json['phone'];

  Map<String, dynamic> toJson() => {
    'phone': phone
  };
}
