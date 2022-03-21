

  class User2{
  String? otp;
  String? token;
  String? phone;
  User2(this.phone,this.otp,this.token);

  User2.fromJson(Map<String?, dynamic> json)
      :phone = json['phone'],
        otp = json['OTP'],
        token = json['token'];

  Map<String?, dynamic> toJson() => {
  'phone': phone,
    'OTP':otp,
    'token':token
  };
  }

